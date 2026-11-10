# Plasticity Reference Manual (community edition)

An unofficial, detailed reference guide for the [Plasticity](https://www.plasticity.xyz) 3D CAD modeller,
covering versions up to **2026.2** (reference version 26.2.0). For the main tools it covers what to select,
step-by-step use, the documented options, common problems, tips, related commands, diagrams and practical
workflows. Commands and options carry a version label: *Introduced in* when the release notes confirm the
introduction, *Documented in* when only availability is known.

The manual is written in **Markdown**. [Pandoc](https://pandoc.org) converts it to [Typst](https://typst.app),
which produces the PDF.

## Quick start

```bash
make                 # build  →  build/Plasticity_Manual_<timestamp>.pdf
make check           # lint the chapters only
make watch           # rebuild whenever a file in book/ or theme/ changes
make typ             # write build/manual.typ without compiling (debugging)
make clean           # delete build/
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
book/                     THE MANUAL – what you edit to change the content
  chapters/               one Markdown file per chapter, built in filename order
                          (NN = chapter number; a long chapter is split into NNa, NNb, …)
  figures/                SVG diagrams, named cNN-name.svg after the chapter that uses them
  metadata.yaml           cover text, running header/footer, PDF title

theme/                    HOW IT LOOKS – the PDF design
  template.typ            pandoc template: fills in metadata.yaml, inserts the chapters
  style.typ               page, text, headings, tables, cover, contents
  components.typ          tags, command cards, note boxes, shortcut tables used inside chapters
  palette.typ             colours
  versions.json           Plasticity version → tag colour (add each new release here)
  cover.svg               cover background
  filter/                 pandoc Lua filter: turns the Markdown conventions into Typst calls

tools/                    build.py (index → check → pandoc → typst), check.py (linter),
                          index.py (regenerates the tool index), common.py (shared paths)

docs/                     FOR CONTRIBUTORS
  writing-guide.md        how to write chapters and cards, with the full markup reference
  diagram-style.md        how to draw diagrams
  build-system.md         how the build, filter and theme work; new Plasticity releases
  review/                 the accuracy review: correction plan, correction log, unresolved items

fonts/                    optional font files (see fonts/README.md)
```

To change **what the manual says**, edit `book/` – start with [docs/writing-guide.md](docs/writing-guide.md).
To change **how it looks**, edit `theme/` – see [docs/build-system.md](docs/build-system.md).

## Accuracy

Every factual change cites a source. Corrections are logged in
[docs/review/corrections.md](docs/review/corrections.md); open questions, each with the application test that
would settle it, are in [docs/review/unresolved.md](docs/review/unresolved.md). The manual has not yet been
tested in the application, so it must not be described as fully verified.

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md): one topic per pull request, cite a source for every factual change, run
`make` before pushing. Manual releases use semantic versioning with git tags; changes are recorded in
[CHANGELOG.md](CHANGELOG.md).

## Licence and legal notes

The manual's text and diagrams are licensed under [CC BY-SA 4.0](LICENSE-CC-BY-SA-4.0.txt); the build tooling
under MIT. See [LICENSE](LICENSE) for which files fall under which licence. By contributing you agree to license
your contribution under the same terms.

This manual describes a commercial product and was compiled by paraphrasing the official Plasticity documentation and release notes.
“Plasticity” is a product of Plastic Software. Before publishing, consider checking the terms of use of doc.plasticity.xyz or asking
Plastic Software for permission, and keep contributions in your own words (no copied passages, screenshots or icons).
This is general information, not legal advice.
