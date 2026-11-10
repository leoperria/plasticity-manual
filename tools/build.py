#!/usr/bin/env python3
"""Build the manual: Markdown --pandoc--> Typst --typst--> PDF.

Usage:
  python3 tools/build.py          index + check + build build/Plasticity_Manual_<timestamp>.pdf
  python3 tools/build.py --watch  rebuild whenever a source file changes
  python3 tools/build.py --typ    stop after writing build/manual.typ (for debugging)

Needs only Python 3 (standard library), pandoc 3.x and typst 0.12+ on the PATH.
"""
import argparse, datetime, glob, os, shutil, subprocess, sys, time

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
BUILD = os.path.join(ROOT, "build")
ED = dict(chapters="chapters", metadata="metadata.yaml", typ="manual.typ", pdf="Plasticity_Manual")

def need(tool, hint):
    if not shutil.which(tool):
        sys.exit(f"'{tool}' not found on PATH. {hint}")

def sources(ed):
    pats = [ed["chapters"] + "/*.md", "figures/**/*.svg", "template/*", "filters/*.lua", ed["metadata"]]
    return sorted(f for p in pats for f in glob.glob(os.path.join(ROOT, p), recursive=True))

def run(cmd):
    print("$", " ".join(os.path.relpath(c, ROOT) if os.path.isabs(c) else c for c in cmd))
    return subprocess.run(cmd, cwd=ROOT).returncode == 0

def build(ed, typ_only=False):
    # the tool index is generated from the command cards
    if subprocess.run(
            [sys.executable, os.path.join(ROOT, "tools", "index.py"), ed["chapters"]], cwd=ROOT).returncode:
        return False
    if subprocess.run([sys.executable, os.path.join(ROOT, "tools", "check.py"), ed["chapters"]], cwd=ROOT).returncode:
        return False
    os.makedirs(BUILD, exist_ok=True)
    now = datetime.datetime.now()
    pdf = os.path.join(BUILD, f"{ed['pdf']}_{now:%Y%m%d-%H%M%S}.pdf")
    typ = os.path.join(BUILD, ed["typ"])
    chapters = sorted(glob.glob(os.path.join(ROOT, ed["chapters"], "*.md")))
    ok = run(["pandoc", "--from=markdown", "--to=typst",
              "--lua-filter=filters/manual.lua", "--template=template/manual.typ",
              f"--metadata-file={ed['metadata']}", f"--metadata=build-time:{now:%d/%m/%Y %H:%M:%S}", "--columns=20", "--wrap=none",
              *[os.path.relpath(c, ROOT) for c in chapters], "-o", os.path.relpath(typ, ROOT)])
    if not ok or typ_only:
        return ok
    ok = run(["typst", "compile", "--root", ".", "--font-path", "fonts",
              os.path.relpath(typ, ROOT), os.path.relpath(pdf, ROOT)])
    if ok:
        print(f"Built {os.path.relpath(pdf, ROOT)}")
    return ok

def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--watch", action="store_true", help="rebuild on changes")
    ap.add_argument("--typ", action="store_true", help="only produce the .typ file in build/")
    a = ap.parse_args()
    ed = ED
    need("pandoc", "Install pandoc 3.x – see README.md.")
    if not a.typ:
        need("typst", "Install typst – see README.md.")
    if not a.watch:
        sys.exit(0 if build(ed, a.typ) else 1)
    stamp = None
    print("Watching for changes – Ctrl+C to stop.")
    try:
        while True:
            now = tuple((f, os.path.getmtime(f)) for f in sources(ed))
            if now != stamp:
                stamp = now
                build(ed, a.typ)
                print("…waiting for changes")
            time.sleep(1)
    except KeyboardInterrupt:
        pass

if __name__ == "__main__":
    main()
