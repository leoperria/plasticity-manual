# Changelog

All notable changes to the manual's content and tooling. Dates use DD/MM/YYYY.

## [Unreleased]
- Repository restructured for maintainability (10/11/2026); the manual's content is unchanged (generated Typst
  identical, every PDF page pixel-identical apart from the cover's build time):
  - `book/` holds the content (chapters, figures, metadata), `theme/` the design, `docs/` the contributor guides,
    `docs/review/` the correction plan, correction log and unresolved items.
  - Chapter files numbered after their chapter (`09p` → `10`, `10` → `11`); every figure named `cNN-name.svg`.
  - Typst template split into `template.typ` (pandoc), `style.typ`, `components.typ` and `palette.typ`;
    version-tag colours moved to `theme/versions.json`, read by both Typst and `tools/check.py`.
  - Lua filter split into modules (`spans`, `cards`, `blocks`, `spacing`, `util`); tools share `tools/common.py`.
  - README shortened; markup reference moved to `docs/writing-guide.md`; new `docs/build-system.md`.
- Concise edition removed (10/11/2026): the former extended edition (“Detailed Guide”) is now the only manual.
  Repository reorganised: chapters in `chapters/`, all diagrams in `figures/`, project docs (writing guide,
  diagram style, correction plan, correction log, unresolved items) in `docs/`; `releases/v1/` deleted;
  `make` builds the single edition; `--edition` and the legacy “present from” tags removed from the tooling.
- Extended edition corrected against `Plasticity_Manual_Correction_Plan.md` (21/10/2026), reference version 26.2.0;
  full log in `docs/CORRECTIONS.md`, open items with their application tests in `docs/UNRESOLVED.md`. Not application-tested.
  - Version labels: *Introduced in* / *Documented in* / *Verified in* replace “present from” and the 25.1 fallback;
    every tag audited. Claim tags (unresolved, not app-tested, general advice), history and unresolved boxes,
    card sections *Older versions* and *Unresolved*.
  - Content fixes in every chapter (B-rep and NURBS terminology, continuity, snapping and units, selection modifiers,
    radius/diameter, arrays, Boolean Slice, Thicken Face date, XY/YZ/XZ, SVG limits, STL units, Plasticity Share);
    new chapter 10 *Practical workflows*; shortcut card rewritten with explicit bindings and changed defaults.
  - Tooling: `[Name]{.cmd}` links with page numbers, `tools/index.py` generates the tool index, `documented=` and
    `tested=` card attributes checked by `tools/check.py`, card endings kept together, larger body text.
    The concise edition keeps its old tags via `legacy-version-tags`.
- Extended edition started (`extended/`, `make extended`): detailed cards with Before you start / Step by step /
  Options explained / Keys / Common problems / Tips / Related, and SVG diagrams in `figures/extended/`.
  All 10 chapters written in full (113 command cards, about 45 diagrams, 105 pages); chapter 10 gains a tool index.
  Chapters 6 and 7 are split into a/b files. Every chapter fact-checked against the official docs (21/10/2026);
  open points that the docs leave unresolved are flagged in the text.
- Tooling: `tools/build.py --edition`, `tools/check.py [chapters-dir]` (also reports missing images),
  breakable cards via `card-breakable`, card titles and labels kept with the following text.

## V1 – 20/10/2026
First complete content edition of the former concise manual, covering Plasticity up to 2026.2 (removed from the repository on 10/11/2026).
Earlier entries (1.0.0–3.0.0) record the tooling history that led to it.

- Final check (20/10/2026):
  - Re-tagged to the earliest release notes: Move, Place, Box, Cylinder, Sphere, Import, Export, Export OBJ (1.3); circles (1.4); Rotate, Scale, rectangles, arcs (24.1); Alternative Duplicate back to 24.2.
  - Removed outdated items: Offset Face Shift+O (no default key), Imprint "Direction" / "X-Ray", Bridge Edge Side 1/2 (now Parameter 1/2), Bridge Curve grid/CPlane snaps.
  - Fixed: Tab for exact values (gizmo commands from 26.1), Vertex Align Studio-only since 26.1, Square Analysis tag, OBJ option versions, two-point plane, Square-only Free continuity, Create Outline has no Alt+D, Measure Distance steps, cover date.
  - Added: Tangent Circle F/Tab, Surface Align "Match tangent length ratio", Extend Sheet skew, Square Create Constraints.
- Updated to Plasticity 2026.2 (19/10/2026), new 26.2 version tag:
  - Align renamed Edge Align: cards now "Surface Align (Edge Align)" and "Vertex Align (Edge Align)", both Studio-only, with Collinear solver, Skew boundary, Symmetry, partial-alignment gizmo and B/P/C keys.
  - New: Project Align card and Constraint System note (Studio), Select All Constraints, Viewport: Home View / Toggle Images / Meshes / Constraints, Assets packs, Curvature shader, Section and YZ/XZ snaps, File tab menu, edge colours.
  - Changed commands: Move (start on selection, Preferences › Commands), Rotate, Duplicate, Deform, Offset Vertex, Extend Sheet, Boolean/Hollow/Thicken failure highlight, Square, Slide CV, PolySplines, Remove Nominal Surface, Bridge Curve (Sense option removed).
  - Materials now listed in their own Materials section; .plasticity import brings meshes, images and instances; Studio-only list updated.
- Second review pass: README tag rule includes 1.3/1.4; "Rebuild Face/Edge" corrected; shader names Topography / Face direction; Offset Face Tab note clarified; cover shows the check date.
- Content checked against the official manual and release notes (19/10/2026):
  - New 1.3+ and 1.4+ version tags. Commands present in those releases or in 2024.1 are re-tagged: Tangent Circle, Tangent Arc (now its own card), Measure, Dimension, Offset Vertex, arrays, Copy/Paste with Placement, Project/Create Outline, Rebuild Curve, Regular Polygon, Rebuild Face, Toggle Points, Raise Surface Degree, Extend Sheet, Remove Nominal Surface.
  - Keys corrected: Delete (Shift+Backspace) vs Dissolve (X/Backspace); Space for Midplane and the two-point plane; Tab switches Spline ↔ Control Point Curve; Fillet Curve D/C; knife mode K.
  - Option names updated: transform orientation/pivot, Proportional "All", Mirror options, Rebuild Curve methods, Measure Continuity "Show maxes", Offset Face "Angle Adjacent", OBJ Edge/Face Angle Tolerance, Curve Array "Extent", Hidden Line "Dash Gap".
  - Export SAT marked Studio-only; Publish to Plasticity Share must be enabled in Preferences; other behaviour fixes (Duplicate, Place, Deform Curve, Text, Measure Radius, Draft Face, Pipe, Isoparam).
- Build timestamp shown on the cover and added to the PDF file name.
- Layout matched to the original ReportLab edition: exact font sizes and baseline spacing, table and card paddings,
  header/footer and cover positions, ReportLab-style contents page, full-width figures, original spacers restored.
- Diagrams replaced with exports of the original ReportLab drawings.
- Unnumbered headings (`{-}`) supported; "Sources and accuracy notes" is unnumbered again.

## 3.0.0 – 19/10/2026
- Sources moved to Markdown, built with Pandoc + Typst (no LaTeX needed).
- Lua filter for keys, version tags, command cards, note boxes and tables; Typst template reproducing the previous layout.
- Diagrams converted to SVG; `tools/build.py` (with `--watch`) and `tools/check.py`.

## 2.0.0 – 19/10/2026
- LaTeX edition.

## 1.0.0 – 19/10/2026
- First version (YAML + ReportLab): chapters 1–10 covering Plasticity up to 2026.1.
