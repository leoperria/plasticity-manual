"""Paths and helpers shared by build.py, check.py and index.py."""
import glob, json, os, re

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))

CHAPTERS = os.path.join(ROOT, "book", "chapters")        # one Markdown file per chapter (or part of one)
METADATA = os.path.join(ROOT, "book", "metadata.yaml")   # cover, header/footer, PDF title
THEME = os.path.join(ROOT, "theme")
TEMPLATE = os.path.join(THEME, "template.typ")           # pandoc template
FILTER = os.path.join(THEME, "filter", "main.lua")       # pandoc Lua filter
VERSIONS = os.path.join(THEME, "versions.json")          # Plasticity version -> tag colour
FONTS = os.path.join(ROOT, "fonts")
BUILD = os.path.join(ROOT, "build")

# Every source that affects the PDF (used by build.py --watch).
SOURCE_PATTERNS = ["book/**/*", "theme/**/*"]


def rel(path):
    """Path relative to the repository root, for messages and command lines."""
    return os.path.relpath(path, ROOT)


def chapter_files():
    """The chapter files, in build order (filename order)."""
    return sorted(glob.glob(os.path.join(CHAPTERS, "*.md")))


def known_versions():
    """Plasticity versions that have a tag colour."""
    with open(VERSIONS, encoding="utf-8") as f:
        return set(json.load(f))


# A command card opens with  ::: {.command name="..." key="..." version="..."}
CARD_RE = re.compile(r"^:::.*\.command")


def card_attrs(line):
    """The attributes of a command card's opening line, as a dict (empty if the line is not a card)."""
    if not CARD_RE.match(line):
        return {}
    return dict(re.findall(r'(?<![\w-])([\w-]+)="([^"]*)"', line))
