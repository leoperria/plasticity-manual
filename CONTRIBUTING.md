# Contributing

Thank you for helping keep this manual accurate.

## What we welcome
- Corrections (wrong key, wrong option name, wrong version tag).
- Missing commands or options, especially for new Plasticity releases.
- Clearer wording, typo fixes, better tips.

## Rules for factual changes
1. **Cite a source** in the pull request: an official manual page, a release note, or a short screen recording from a named Plasticity version.
2. **Version labels**: `[25.2]{.ver}` (“Introduced in”) only when the release notes announce it; otherwise `[25.2]{.doc}`
   (“Documented in”) with the earliest source that mentions it. Never guess an introduction date. `[26.2.0]{.tested}`
   only with a screen recording or written test from that build.
3. **Unverified behaviour**: if you cannot prove it, label it `[UNRESOLVED]{.unresolved}` or put it under `Unresolved:`,
   and add the test that would settle it to `docs/review/unresolved.md`.
4. **Your own words**: paraphrase. Do not paste text, screenshots or icons from the official documentation.
5. **Default keys only**: describe factory defaults (Windows/Linux), not personal keymaps.
6. **One topic per pull request** keeps review simple.

## Style
- UK English spelling; dates as DD/MM/YYYY.
- Commands: `what` is one or two sentences; `steps` are imperative; options start with the key or the option name in bold.
- Prefer one precise sentence to three vague ones. Follow [docs/writing-guide.md](docs/writing-guide.md).

## Workflow
```bash
git checkout -b fix/rotate-freestyle
# edit book/chapters/*.md
make            # checks and builds build/Plasticity_Manual_<timestamp>.pdf
git commit -m "Rotate: document freestyle on faces (26.1)"
```
Open a pull request; CI lints the sources and attaches the built PDF as an artifact.
