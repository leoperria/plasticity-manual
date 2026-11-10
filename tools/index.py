#!/usr/bin/env python3
"""Regenerate the tool index in the shortcut-card chapter from the command cards.

Usage: python3 tools/index.py      (run automatically by tools/build.py)

Every ::: {.command ...} card becomes one row: [Name]{.cmd} (a link with the card's page number),
its default key (or a dash) and the chapter it is in. The table between the "<!-- index:start -->" and
"<!-- index:end -->" markers in book/chapters/*shortcut-card*.md is replaced; the rest is left alone.
"""
import os, re, sys

from common import card_attrs, chapter_files, rel

START, END = "<!-- index:start -->", "<!-- index:end -->"


def collect(files):
    """(name, key, chapter) for every card, sorted by name."""
    rows, chapter = [], "?"
    for path in files:
        for line in open(path, encoding="utf-8"):
            h = re.match(r"# (.+?)(\s*\{[^}]*\})?\s*$", line)
            if h:
                chapter = h.group(1)
            a = card_attrs(line)
            if a:
                rows.append((a["name"], a.get("key", "–"), chapter))
    return sorted(rows, key=lambda r: r[0].lower())


def main():
    files = chapter_files()
    target = next(f for f in files if "shortcut-card" in os.path.basename(f))
    rows = collect(files)
    table = ["| Tool | Default key | Chapter |",
             "|------------------------------------------|--------------------|--------------------------|"]
    table += [f"| [{n}]{{.cmd}} | {k.replace('|', chr(92) + '|')} | {c} |" for n, k, c in rows]

    text = open(target, encoding="utf-8").read()
    if START not in text:
        sys.exit(f"{rel(target)}: add {START} and {END} around the tool index table")
    before, rest = text.split(START, 1)
    after = rest.split(END, 1)[1]
    new = before + START + "\n\n" + "\n".join(table) + "\n\n" + END + after
    if new != text:   # only write on change, so build.py --watch does not loop
        open(target, "w", encoding="utf-8").write(new)
    print(f"Tool index: {len(rows)} cards in {rel(target)}")


if __name__ == "__main__":
    main()
