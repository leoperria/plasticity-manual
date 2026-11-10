#!/usr/bin/env python3
"""Regenerate the tool index in the shortcut-card chapter from the command cards.

Usage: python3 tools/index.py [chapters-dir]   (default: chapters)

Every ::: {.command ...} card becomes one row: [Name]{.cmd} (a link with the card's page number),
its default key (or a dash) and the chapter it is in. The table between the "<!-- index:start -->" and
"<!-- index:end -->" markers is replaced; the rest of the chapter is left alone.
"""
import glob, os, re, sys

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
CHAPTERS = sys.argv[1] if len(sys.argv) > 1 else "chapters"
files = sorted(glob.glob(os.path.join(ROOT, CHAPTERS, "*.md")))
target = next(f for f in files if "shortcut-card" in os.path.basename(f))

rows, chapter = [], "?"
for path in files:
    for line in open(path, encoding="utf-8"):
        h = re.match(r"# (.+?)(\s*\{[^}]*\})?\s*$", line)
        if h:
            chapter = h.group(1)
        if line.startswith(":::") and ".command" in line:
            name = re.search(r'name="([^"]*)"', line).group(1)
            key = re.search(r'key="([^"]*)"', line)
            rows.append((name, key.group(1) if key else "–", chapter))

rows.sort(key=lambda r: r[0].lower())
table = ["| Tool | Default key | Chapter |",
         "|------------------------------------------|--------------------|--------------------------|"]
table += [f"| [{n}]{{.cmd}} | {k.replace('|', chr(92) + '|')} | {c} |" for n, k, c in rows]

text = open(target, encoding="utf-8").read()
start, end = "<!-- index:start -->", "<!-- index:end -->"
if start not in text:
    sys.exit(f"{os.path.relpath(target, ROOT)}: add {start} and {end} around the tool index table")
before, rest = text.split(start, 1)
after = rest.split(end, 1)[1]
new = before + start + "\n\n" + "\n".join(table) + "\n\n" + end + after
if new != text:   # only write on change, so build.py --watch does not loop
    open(target, "w", encoding="utf-8").write(new)
print(f"Tool index: {len(rows)} cards in {os.path.relpath(target, ROOT)}")
