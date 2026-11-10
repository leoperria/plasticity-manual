# Build system and theme

How `make` turns `book/` into the PDF, and where to change the design.

## Pipeline

```
book/chapters/*.md ──► tools/index.py   regenerates the tool index in 11-quick-reference-shortcut-card.md
                   ──► tools/check.py   lints the chapters (stops the build on errors)
                   ──► pandoc           Markdown → Typst, using
                                          theme/filter/main.lua   (Markdown conventions → Typst calls)
                                          theme/template.typ      (+ book/metadata.yaml)
                                        → build/manual.typ
                   ──► typst compile    → build/Plasticity_Manual_<timestamp>.pdf
```

`tools/build.py` runs all four steps; `--watch` repeats them whenever a file in `book/` or `theme/` changes, and
`--typ` stops after `build/manual.typ`. Paths shared by the tools are defined once in `tools/common.py`.
CI (`.github/workflows/build.yml`) runs `python3 tools/build.py` on every push and pull request and attaches the PDF.

## Theme files

| File | Contains |
|---|---|
| `theme/template.typ` | The pandoc template. Fills in `book/metadata.yaml`, imports the theme and applies `style.typ`. Do not write dollar signs in its comments: pandoc reads them as template variables. |
| `theme/style.typ` | `manual()`: page size and margins, header and footer, body text, headings, tables, cover, contents. The comment at the top explains how the original ReportLab measurements were converted to Typst. |
| `theme/components.typ` | What the filter emits inside chapters: `key`, version tags (`ver`, `docver`, `tested`), claim tags, `cmdref`, `command` cards, `cmdlabel`, `notebox`, `cardtable`, `flowblock`. |
| `theme/palette.typ` | Colours, and the version-tag colours loaded from `versions.json`. |
| `theme/versions.json` | Plasticity version → tag colour. Read by Typst and by `tools/check.py`. |
| `theme/cover.svg` | Cover background. |

## Filter modules (`theme/filter/`)

| Module | Handles |
|---|---|
| `main.lua` | Entry point: loads the modules and sets the order of the passes. |
| `spans.lua` | `[…]{.key}`, `.ver`, `.doc`, `.tested`, claim tags, `.cmd` links, `.studio`; image paths. |
| `cards.lua` | `::: {.command}` cards, their section labels, and where long cards may break across pages. |
| `blocks.lua` | Note boxes, shortcut-card tables, centred blocks, headings (`{.pagebreak}`, `{-}`), pipe tables, figures. |
| `spacing.lua` | Exact vertical gaps between top-level blocks (the `TAIL` / `HEAD` tables). |
| `util.lua` | Shared helpers: Typst string quoting, raw blocks, block weights. |

To add a new Markdown convention: handle it in the right filter module, add the Typst function it emits to
`components.typ`, document it in `docs/writing-guide.md`, and add a lint rule to `tools/check.py` if it can be
written wrongly.

## A new Plasticity release

1. Add the version and a colour to `theme/versions.json` (otherwise its tags show a red “?” and `make check` fails).
2. Tag new commands and options with `[x.y]{.ver}` / `version="x.y"` (see the writing guide).
3. Update the reference version in `book/metadata.yaml` and `README.md`.
4. Record the change in `CHANGELOG.md`.

## Troubleshooting

- `make typ` writes `build/manual.typ` without compiling it; Typst error messages refer to line numbers in that file.
- “unknown font family”: install the DejaVu fonts or copy them into `fonts/`.
- A red “25.4?” tag: that version has no colour yet in `theme/versions.json`.
- “unknown variable” from Typst: the filter emits a function that `theme/components.typ` does not define.
