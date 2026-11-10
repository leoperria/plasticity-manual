# Writing guide

The manual ("Detailed Guide") explains every tool in enough detail that a Plasticity user can learn it from the page.
**Model chapter:** `chapters/08-face-and-edge-commands.md`. Read it in full before writing; match its tone, length and structure.

## Audience and language

- Plasticity users, from beginners to experienced modellers. Explain the *why* as well as the *how*.
- UK English (colour, centre, behaviour), second person ("select the face…"), short sentences, plain words.
- Dates DD/MM/YYYY.

## Chapter layout

- Keep the chapter's `#` and `##` headings exactly as they are: section numbers and cross-references depend on them.
- Tool chapters open with one or two sentences and an **"I want to… | Use"** table listing every tool in the chapter (see chapter 8).

## Card layout

```markdown
::: {.command name="Exact name" key="[K]{.key}" version="25.1"}
One or two short paragraphs: what the tool does and when you would use it.

![](figures/cNN-name.svg)        ← optional diagram, alone in its paragraph

Before you start:
- selection mode, what to select, how the tool starts (key, palette, auto-start)

Step by step:
1. numbered steps, saying what the user sees (handles, gizmo, preview, dialog)

Options explained:
- **Option** – what it does; sub-bullets for each value

Keys:
- every in-command key

Common problems:
- symptom → fix

Tips:
- practical advice

Older versions:
- historical behaviour, old defaults, removed options

Unresolved:
- what is unknown, and the exact application test that would settle it

Related:
Other tools, comma-separated.
:::
```

- Section lines must be written exactly as above, each in its own paragraph. Leave out a section if there is nothing documented for it. Short tools (e.g. Unjoin) can be short cards.
- Do **not** change `name="…"`: names must stay unique, and the tool index links to them with `[Name]{.cmd}`. Change `key="…"` only if the official docs clearly show it is wrong, and report it.
- Version labels: `version="x.y"` / `[x.y]{.ver}` = **Introduced in** (the release notes announce it); `documented="x.y"` / `[x.y]{.doc}` = **Documented in** (available, introduction unknown); `tested="x.y.z"` / `[x.y.z]{.tested}` = **Verified in** an application build. Never use a fallback version for an unknown date.
- Current behaviour goes in the normal sections; historical behaviour only under `Older versions:` (or a `::: {.note .history}` box outside cards).
- Claim-status tags: `[UNRESOLVED]{.unresolved}`, `[UNTESTED]{.untested}`, `[ADVICE]{.advice}`; amber `::: {.note .unresolved}` boxes for larger open questions. Add every open item to `UNRESOLVED.md` with its test.
- Shortcuts: full bindings (`[Ctrl+Shift+D]{.key}`), sequences as "[O]{.key}, then [O]{.key}", never slash notation for different bindings.
- Do not promise completeness ("every option"); describe what the docs cover.
- Markup: `[Ctrl+R]{.key}` keys, `[STUDIO]{.studio}`, `studio="true"` on Studio-only cards.

## Accuracy

- Sources: the official manual at https://doc.plasticity.xyz (command pages, Plasticity Essentials, release notes 1.3–2026.2) and its source repository https://github.com/KioArts/plasticity-document-revisions (raw MDX: `https://raw.githubusercontent.com/KioArts/plasticity-document-revisions/main/pages/<path>.en.mdx`). WebFetch often paraphrases; use the raw MDX when you need exact wording.
- Keep every fact and key already in the card unless a source shows it is wrong; then correct it and log the change in `CORRECTIONS.md`. You may reword it.
- Add only what the docs state. Never invent behaviour, defaults, value ranges or key bindings.
- When the docs are silent, ambiguous or contradict each other, say so briefly in the card ("the docs do not say…", "check in your version") rather than guessing.
- New facts from a specific release get that label (e.g. `[26.2]{.ver}`); otherwise leave new facts untagged.
- Worked examples may use arithmetic, but never invented measurements; write measured examples as exercises until someone has run them in the application.
- General modelling advice is fine in **Tips** if it is plainly advice, not a claim about Plasticity's behaviour.

## Diagrams

- Follow `docs/DIAGRAM-STYLE.md` (canvas, panels, colours, captions). Name files `figures/cNN-short-name.svg` with your chapter prefix.
- Add a diagram only where it shows something faster than words: option values side by side, before/after, a selection order.
- Draw only documented behaviour.
- Check every diagram visually: render it to PNG and look at it (overlaps, clipped text, wrong arrows).

## Checking your work

- `python3 tools/check.py chapters` must pass.
- To preview just your chapter, run this from the repository root (do not run `tools/build.py`: other writers may be building at the same time):

```bash
mkdir -p build/preview-cNN
pandoc --from=markdown --to=typst --lua-filter=filters/manual.lua --template=template/manual.typ \
  --metadata-file=metadata.yaml --metadata=build-time:preview --columns=20 --wrap=none \
  chapters/<your-file>.md -o build/preview-cNN/preview.typ
typst compile --root . --font-path fonts build/preview-cNN/preview.typ build/preview-cNN/preview.pdf
pdftoppm -r 70 -png build/preview-cNN/preview.pdf build/preview-cNN/page
```

Then look at the page images. Delete `build/preview-cNN/` when you are done.
