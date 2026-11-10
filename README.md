# Plasticity Reference Manual (community edition)

An unofficial, detailed reference guide for the [Plasticity](https://www.plasticity.xyz) 3D CAD modeller,
covering versions up to **2026.2** (reference version 26.2.0). Commands and options carry a version label: *Introduced in* when the release notes confirm
the introduction, *Documented in* when only availability is known.

The manual is written in **Markdown**. [Pandoc](https://pandoc.org) converts it to [Typst](https://typst.app), which produces the PDF.

For the main tools it covers what to select, step-by-step use, the documented options, common problems, tips,
related commands, diagrams and practical workflows. Corrections are logged in `docs/CORRECTIONS.md`; open
questions, each with the application test that would settle it, in `docs/UNRESOLVED.md`.

## Quick start

```bash
make                 # build  →  build/Plasticity_Manual_<timestamp>.pdf
make check           # lint the chapters only
make watch           # rebuild on every save
make typ             # write build/manual.typ without compiling (debugging)
```

### Requirements

Pandoc **3.1 or newer**, Typst **0.12 or newer**, Python 3 (standard library only) and the DejaVu fonts.

| System | Install |
|---|---|
| Arch / Manjaro | `sudo pacman -S pandoc-cli typst ttf-dejavu` |
| macOS (Homebrew) | `brew install pandoc typst` and `brew install --cask font-dejavu` |
| Windows | e.g. `winget install JohnMacFarlane.Pandoc Typst.Typst`, fonts from dejavu-fonts.github.io |
| Debian / Ubuntu | `sudo apt install fonts-dejavu-core`; pandoc and typst from their GitHub release pages if the distribution versions are too old |

If the fonts are not installed system-wide, copy the `.ttf` files into `fonts/`.

## Repository layout

```
chapters/            One Markdown file per chapter, built in filename order  ← you edit these
figures/             Diagrams as SVG (cNN-name.svg = used by chapter NN)
metadata.yaml        Cover, running header/footer, PDF title
docs/WRITING-GUIDE.md   How to write cards and diagrams (read before editing chapters/)
docs/DIAGRAM-STYLE.md   Diagram canvas, panels, colours and captions
docs/CORRECTIONS.md     Correction log
docs/UNRESOLVED.md      Open questions, each with the application test that settles it
docs/CORRECTION-PLAN.md The correction plan the current text was checked against
template/manual.typ  Typst template: page layout, colours, command cards, version-tag colours
template/cover.svg   Cover background
filters/manual.lua   Pandoc filter that turns the conventions below into Typst
tools/build.py       Build script (check → pandoc → typst), with --watch
tools/check.py       Lints chapters: version tags, ::: blocks, duplicate commands, table rows, missing images
tools/index.py       Regenerates the tool index from the command cards (run by build.py)
```

## Writing content

Plain Markdown works as usual: `#` chapter, `##` section, `**bold**`, `*italic*`, lists and pipe tables.
Headings are numbered automatically – do not type numbers.

Manual-specific conventions:

| You write | You get |
|---|---|
| `[Ctrl+R]{.key}` | a keyboard shortcut |
| `[25.2]{.ver}` | “Introduced in 25.2” – the release notes confirm it was added or changed there (red “?” if the version has no colour) |
| `[1.3]{.doc}` | “Documented in 1.3” – available in that version, introduction unknown |
| `[26.2.0]{.tested}` | “Verified in 26.2.0” – behaviour tested in that application build |
| `[UNRESOLVED]{.unresolved}` / `[UNTESTED]{.untested}` / `[ADVICE]{.advice}` | claim-status tags |
| `[Card name]{.cmd}` | link to a command card with its page number (name must match a card) |
| `[STUDIO]{.studio}` | Studio-licence tag |
| `# Chapter title {.pagebreak}` | the chapter starts on a new page |
| `::: {.note title="Title"}` … `:::` | violet note box (`.green` green, `.history` grey for older behaviour, `.unresolved` amber for open questions) |
| `::: center` … `:::` | centred content, e.g. a figure |
| `![](figures/name.svg)` | a full-width figure (when the image is alone in its paragraph) |
| `## Heading {-}` | unnumbered heading, still listed in the contents |
| ```` ```{=typst} ```` / `#v(4pt, weak: true)` / ```` ``` ```` | extra vertical space (raw Typst block) |

A **command card** is a `::: {.command name="Rotate" key="[R]{.key}" version="25.1"}` … `:::` block.
`version="x.y"` means introduced in x.y; use `documented="x.y"` instead when the introduction is unknown
(exactly one of the two); `tested="26.2.0"` adds “Verified in 26.2.0”. `key` is optional (omit it for “no
default key”); several keys: `key="[Ctrl+Shift+C]{.key} / [Ctrl+Shift+V]{.key}"`. Studio-only commands add `studio="true"`.

Cards start with a paragraph saying what the tool is for, then use these section lines
(each its own paragraph, in this order, all optional): `Before you start:` (selection mode, what to select,
how the command starts), `Step by step:` (numbered steps, saying what you see at each step), `Options explained:`
(the documented options and the effect of each value), `Keys:`, `Common problems:` (problem → fix), `Tips:`,
`Older versions:` (historical behaviour), `Unresolved:` (open questions and the test that settles each), `Related:`.
The last section of a card is kept on one page with the item before it.
A diagram goes inside the card where it helps: `![](figures/cNN-name.svg)` alone in a paragraph.
Cards may split across pages (`card-breakable: true` in `metadata.yaml`). See `docs/WRITING-GUIDE.md`.

**Tables:** the relative column widths come from the number of dashes in the separator line, e.g. `|------|------------------|`
gives a narrow first column. The first row is the header; the first column is bold.

**Escaping:** write `\*`, `\_`, `\#`, `\$`, `\@`, `\|` (inside tables), `\[` and `\]` when you mean the literal character.

## Layout

`template/manual.typ` reproduces the original ReportLab edition: DejaVu Sans 8.8 pt body text on a 12.2 pt
baseline grid, 17 / 11.5 pt headings, 7.6 pt tables, 8.2 pt command cards, and the same margins, header, footer,
cover and contents layout. The comment at the top of the template explains how ReportLab's baseline-to-baseline
spacing is converted to Typst, so new styles can be added consistently.

## Versioning conventions

- `.ver` / `version=` (“Introduced in”) only when the release notes of that version announce the feature or change.
- Otherwise `.doc` / `documented=` (“Documented in”) with the earliest release notes or manual page that mention it,
  or the current version if nothing older is known. Never guess an introduction date.
- `.tested` / `tested=` (“Verified in”) only for behaviour tested in the named application build.
- When a default key changes, the card shows the current default; the old one goes under `Older versions:`.
- New Plasticity release: add its colour to `ver-colours` in `template/manual.typ`, then tag new commands and options.
- Manual releases use semantic versioning with git tags; record changes in `CHANGELOG.md`.

## Troubleshooting

- `make typ` writes `build/manual.typ` without compiling it; Typst error messages refer to line numbers in that file.
- “unknown font family”: install the DejaVu fonts or copy them into `fonts/`.
- A red “25.4?” tag: that version has no colour yet in `template/manual.typ`.

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md): one topic per pull request, cite a source for every factual change, run `make` before pushing.

## Licence and legal notes

No licence has been chosen yet – add a `LICENSE` file before accepting outside contributions
(a common split is MIT for the tooling and CC BY-SA 4.0 for the text).

This manual describes a commercial product and was compiled by paraphrasing the official Plasticity documentation and release notes.
“Plasticity” is a product of Plastic Software. Before publishing, consider checking the terms of use of doc.plasticity.xyz or asking
Plastic Software for permission, and keep contributions in your own words (no copied passages, screenshots or icons).
This is general information, not legal advice.
