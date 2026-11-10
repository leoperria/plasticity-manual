#!/usr/bin/env python3
"""Lint the Markdown chapters before building (also run in CI).

Usage: python3 tools/check.py [chapters-dir]   (default: chapters)

Checks:
  * every [x.y]{.ver} / [x.y]{.doc} tag and command version="x.y" / documented="x.y" has a colour
    in template/manual.typ; [x.y.z]{.tested} and tested="x.y.z" name a full build number
  * every ::: fence is closed
  * command blocks have a name and exactly one of version / documented, and names are unique
  * every [Name]{.cmd} reference names an existing command card
  * table rows have the same number of cells as the header
  * every image ![](path) exists
Exit code 1 if anything is wrong.
"""
import glob, os, re, sys

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
template = open(os.path.join(ROOT, "template", "manual.typ"), encoding="utf-8").read()
KNOWN = set(re.findall(r'^\s*"(\d+\.\d+)":\s*rgb', template, re.M))

errors, names, refs = [], {}, []
CHAPTERS = sys.argv[1] if len(sys.argv) > 1 else "chapters"
files = sorted(glob.glob(os.path.join(ROOT, CHAPTERS, "*.md")))
if not files:
    sys.exit(f"No chapters found in {CHAPTERS}/")
for path in files:
    fn = os.path.basename(path)
    depth, table_cols = 0, None
    for n, line in enumerate(open(path, encoding="utf-8"), 1):
        where = f"{fn}:{n}"
        s = line.rstrip("\n")
        for img in re.findall(r"!\[[^\]]*\]\(([^)\s]+)\)", s):
            if not os.path.exists(os.path.join(ROOT, img.lstrip("/"))):
                errors.append(f"{where}: image {img} not found")
        for cls in ("ver", "doc"):
            for v in re.findall(r"\[([^\]]*)\]\{\." + cls + r"\}", s):
                if v not in KNOWN:
                    errors.append(f"{where}: version tag [{v}]{{.{cls}}} has no colour in template/manual.typ")
        for v in re.findall(r"\[([^\]]*)\]\{\.tested\}", s) + re.findall(r'tested="([^"]*)"', s):
            if not re.fullmatch(r"\d+\.\d+\.\d+", v):
                errors.append(f"{where}: tested build \"{v}\" is not a full build number (e.g. 26.2.0)")
        for r in re.findall(r"\[([^\]]*)\]\{\.cmd\}", s):
            refs.append((where, r))
        if s.startswith(":::"):
            if s.strip() == ":::":
                depth -= 1
                if depth < 0:
                    errors.append(f"{where}: closing ::: without an opening fence"); depth = 0
            else:
                depth += 1
                if ".command" in s:
                    name = re.search(r'name="([^"]*)"', s)
                    ver = re.search(r'(?<![\w-])(version|documented)="([^"]*)"', s)
                    if not name: errors.append(f"{where}: command without name=\"...\"")
                    if len(re.findall(r'(?<![\w-])(?:version|documented)="', s)) != 1:
                        errors.append(f"{where}: command needs exactly one of version=\"...\" (introduced in) or documented=\"...\"")
                    elif ver.group(2) not in KNOWN:
                        errors.append(f"{where}: command {ver.group(1)} \"{ver.group(2)}\" has no colour in template/manual.typ")
                    if name:
                        if name.group(1) in names:
                            errors.append(f"{where}: duplicate command \"{name.group(1)}\" (also {names[name.group(1)]})")
                        names[name.group(1)] = where
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
