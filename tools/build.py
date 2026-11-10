#!/usr/bin/env python3
"""Build the manual: Markdown --pandoc--> Typst --typst--> PDF.

Usage:
  python3 tools/build.py          index + check + build build/Plasticity_Manual_<timestamp>.pdf
  python3 tools/build.py --watch  rebuild whenever a file in book/ or theme/ changes
  python3 tools/build.py --typ    stop after writing build/manual.typ (for debugging)

Steps: tools/index.py regenerates the tool index, tools/check.py lints the chapters, pandoc turns the
chapters into build/manual.typ (theme/filter/ + theme/template.typ), typst compiles it to the PDF.
Needs only Python 3 (standard library), pandoc 3.x and typst 0.12+ on the PATH.
"""
import argparse, datetime, glob, os, shutil, subprocess, sys, time

from common import BUILD, FILTER, FONTS, METADATA, ROOT, SOURCE_PATTERNS, TEMPLATE, chapter_files, rel

TOOLS = os.path.dirname(os.path.abspath(__file__))
TYP = os.path.join(BUILD, "manual.typ")


def need(tool, hint):
    if not shutil.which(tool):
        sys.exit(f"'{tool}' not found on PATH. {hint}")


def run(cmd):
    print("$", " ".join(cmd))
    return subprocess.run(cmd, cwd=ROOT).returncode == 0


def tool(name):
    """Run another script in tools/; True on success."""
    return subprocess.run([sys.executable, os.path.join(TOOLS, name)], cwd=ROOT).returncode == 0


def build(typ_only=False):
    if not (tool("index.py") and tool("check.py")):
        return False
    os.makedirs(BUILD, exist_ok=True)
    now = datetime.datetime.now()
    pdf = os.path.join(BUILD, f"Plasticity_Manual_{now:%Y%m%d-%H%M%S}.pdf")
    ok = run(["pandoc", "--from=markdown", "--to=typst",
              f"--lua-filter={rel(FILTER)}", f"--template={rel(TEMPLATE)}",
              f"--metadata-file={rel(METADATA)}", f"--metadata=build-time:{now:%d/%m/%Y %H:%M:%S}",
              "--columns=20", "--wrap=none",
              *[rel(c) for c in chapter_files()], "-o", rel(TYP)])
    if not ok or typ_only:
        return ok
    ok = run(["typst", "compile", "--root", ".", "--font-path", rel(FONTS), rel(TYP), rel(pdf)])
    if ok:
        print(f"Built {rel(pdf)}")
    return ok


def sources():
    return sorted(f for p in SOURCE_PATTERNS for f in glob.glob(os.path.join(ROOT, p), recursive=True)
                  if os.path.isfile(f))


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--watch", action="store_true", help="rebuild on changes")
    ap.add_argument("--typ", action="store_true", help="only produce build/manual.typ")
    a = ap.parse_args()
    need("pandoc", "Install pandoc 3.x – see README.md.")
    if not a.typ:
        need("typst", "Install typst – see README.md.")
    if not a.watch:
        sys.exit(0 if build(a.typ) else 1)
    stamp = None
    print("Watching book/ and theme/ – Ctrl+C to stop.")
    try:
        while True:
            now = tuple((f, os.path.getmtime(f)) for f in sources())
            if now != stamp:
                stamp = now
                build(a.typ)
                print("…waiting for changes")
            time.sleep(1)
    except KeyboardInterrupt:
        pass


if __name__ == "__main__":
    main()
