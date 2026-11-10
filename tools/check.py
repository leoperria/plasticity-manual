#!/usr/bin/env python3
"""Lint the Markdown chapters in book/chapters/ before building (also run in CI).

Usage: python3 tools/check.py

Checks:
  * every [x.y]{.ver} / [x.y]{.doc} tag and card version="x.y" / documented="x.y" has a colour
    in theme/versions.json; [x.y.z]{.tested} and tested="x.y.z" name a full build number
  * every ::: fence is closed
  * command cards have a name and exactly one of version / documented, and names are unique
  * every [Name]{.cmd} reference names an existing command card
  * table rows have the same number of cells as the header
  * every image ![](path) exists
Exit code 1 if anything is wrong.
"""
import os, re, sys

from common import ROOT, VERSIONS, card_attrs, chapter_files, known_versions, rel

KNOWN = known_versions()
NO_COLOUR = f"has no colour in {rel(VERSIONS)}"


def check_line(s, where, errors, refs, names):
    for img in re.findall(r"!\[[^\]]*\]\(([^)\s]+)\)", s):
        if not os.path.exists(os.path.join(ROOT, img.lstrip("/"))):
            errors.append(f"{where}: image {img} not found")
    for cls in ("ver", "doc"):
        for v in re.findall(r"\[([^\]]*)\]\{\." + cls + r"\}", s):
            if v not in KNOWN:
                errors.append(f"{where}: version tag [{v}]{{.{cls}}} {NO_COLOUR}")
    for v in re.findall(r"\[([^\]]*)\]\{\.tested\}", s) + re.findall(r'tested="([^"]*)"', s):
        if not re.fullmatch(r"\d+\.\d+\.\d+", v):
            errors.append(f"{where}: tested build \"{v}\" is not a full build number (e.g. 26.2.0)")
    refs += [(where, r) for r in re.findall(r"\[([^\]]*)\]\{\.cmd\}", s)]


def check_card(s, where, errors, names):
    a = card_attrs(s)
    name = a.get("name")
    if name is None:
        errors.append(f"{where}: command without name=\"...\"")
    status = [k for k in ("version", "documented") if k in a]
    if len(status) != 1:
        errors.append(f"{where}: command needs exactly one of version=\"...\" (introduced in) or documented=\"...\"")
    elif a[status[0]] not in KNOWN:
        errors.append(f"{where}: command {status[0]} \"{a[status[0]]}\" {NO_COLOUR}")
    if name is not None:
        if name in names:
            errors.append(f"{where}: duplicate command \"{name}\" (also {names[name]})")
        names[name] = where


def main():
    errors, names, refs = [], {}, []
    files = chapter_files()
    if not files:
        sys.exit("No chapters found in book/chapters/")
    for path in files:
        fn = os.path.basename(path)
        depth, table_cols = 0, None
        for n, line in enumerate(open(path, encoding="utf-8"), 1):
            where = f"{fn}:{n}"
            s = line.rstrip("\n")
            check_line(s, where, errors, refs, names)
            # ::: fences
            if s.startswith(":::"):
                if s.strip() == ":::":
                    depth -= 1
                    if depth < 0:
                        errors.append(f"{where}: closing ::: without an opening fence"); depth = 0
                else:
                    depth += 1
                    if ".command" in s:
                        check_card(s, where, errors, names)
            # pipe tables: compare cell counts with the header row
            if s.startswith("|"):
                cells = len(re.split(r"(?<!\\)\|", s.strip().strip("|")))
                if table_cols is None:
                    table_cols = cells
                elif cells != table_cols:
                    errors.append(f"{where}: table row has {cells} cells, header has {table_cols}")
            else:
                table_cols = None
        if depth != 0:
            errors.append(f"{fn}: {depth} unclosed ::: block(s)")

    for where, r in refs:
        if r not in names:
            errors.append(f"{where}: [{r}]{{.cmd}} does not match any command card name")

    if errors:
        print("\n".join(errors)); print(f"\n{len(errors)} problem(s) found."); sys.exit(1)
    print(f"OK – {len(names)} commands, version tags valid.")


if __name__ == "__main__":
    main()
