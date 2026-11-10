# Correction log

Corrections made on 21/10/2026 to `build/Plasticity_Manual_Extended_20261021-111155.pdf`, following
`correction-plan.md`. Reference version: Plasticity 26.2.0. Evidence: the official manual
(https://doc.plasticity.xyz) and its source repository at revision `570fdda9d764df8381118316cb98c6d3d6689890`
(20/10/2026), accessed 21/10/2026. **No change was tested in the application**; open items are in `unresolved.md`.
Page numbers below are pages of the old PDF unless stated.

## Whole book (plan §1, §13, §14, §15)

- **Version labels:** the “present from” tag (with 25.1 as the fallback for unknown dates) is replaced by *Introduced in* (release notes confirm the introduction), *Documented in* (available, introduction unknown) and *Verified in* (application-tested; not used, nothing was tested). Every card and inline tag was audited chapter by chapter (details below). The concise edition keeps its old tags (`legacy-version-tags` in `metadata.yaml`).
- **Claim labels:** new `UNRESOLVED`, `NOT APP-TESTED` and `GENERAL ADVICE` tags, amber *unresolved* and grey *history* boxes, and card sections *Older versions* and *Unresolved*. Their meaning is explained in chapter 1 (*How to read this guide*) and in *Sources and accuracy notes*.
- **Cover and front matter:** removed “every option explained” and “tagged with the version they are present from”; the cover names the reference version and says the guide is not application-tested.
- **Layout:** body text 8.8 → 9.4 pt, card text 8.2 → 8.8 pt, table text 7.6 → 8 pt. The last section of every card, together with short closing sections (Older versions, Unresolved, Related) and the item before them, is kept on one page, so a card no longer ends with a detached “Related” line (old p48).
- **Tool index:** generated from the cards (`tools/index.py`, run by the build); each entry links to its card and shows its page number.
- **Shortcut card (chapter 11):** rewritten with explicit bindings (no slash notation; “O, then O” for sequences), split into current defaults, *Keys inside a running command* (context) and *Changed defaults* (history: Tab → 5 and Tab → S in 26.1). New documentation conflict found: the official list gives X to both Delete and Dissolve.
- **Sources:** clickable links to the specific official pages, release notes and the repository revision, with access date; label legend; statement that the guide is not fully verified.
- **New chapter 10, Practical workflows:** direct modelling and persistence, a first complete project, a geometry-failure workflow, a surface-quality tutorial and a compatibility matrix from the official pages. The shortcut card becomes chapter 11.
- **Repetitive confirmation steps** removed from cards in favour of chapter 3, *Confirming, cancelling and repeating commands*.
- **Cross-chapter reconciliation:** Alternative Duplicate is *Documented in 24.2* in chapters 5 and 6; G0/G1/G2 Scale has the same unresolved wording in chapters 4, 7.4 and 10; material-list clean-up has the same wording in chapters 1 and 5; chapter 1’s in-command selection modifiers now match chapter 3; chapter 3’s group example no longer presents X as Dissolve.

## Chapter 1 Core concepts and entities
Files: `01-core-concepts-and-entities.md` · old pages 1–11

### Corrections

- p1 / "How to read this guide" – "Options explained (every option…)" completeness promise and "version tag = present from; 25.1 = unknown" → describes options "the official docs describe", explains Introduced in / Documented in / Verified in (none in this edition), claim labels (documented / Tips = advice / UNRESOLVED), new Older versions and Unresolved card sections; points to *Sources and accuracy notes* — plan §1.
- p1 / How to read – "Two default keys changed in 26.1" paragraph → moved into a `.history` box under Selection modes (with Tab→5, Tab→S, Selection Mode page still shows Tab, how to rebind) — https://doc.plasticity.xyz/migration-26.1.
- p2 / What Plasticity is – "NURBS-based CAD modeller from Plastic Software (Nick Kallen), first released 2023, 'CAD for artists'" (not in docs; implies NURBS-only) → "CAD modeller for artists and designers … exact curves, surfaces and solids" — plan §2; undocumented company/date claims dropped.
- p2 / What Plasticity is – "Supported platforms (unchanged in 26.2): Windows 10+, Ubuntu 22.04+, macOS 12.0+" (no source in docs) → installers exist for Windows, macOS, Linux; points to *Compatibility* in chapter 10 (which says minimum OS versions are not documented) — https://doc.plasticity.xyz/getting-started/download-and-install.
- p2 / Release table – rows used `.ver` badges as row labels and "for first-version tags" wording → plain release names; 1.3 row now lists what its notes call new (adds Thicken Face, radial menus) vs "mentioned as existing" — release notes 1.3, 1.4.
- p2 / added one sentence: docs describe no feature history; chapter 10 *Practical workflows* explains direct modelling, editability and persistence (no duplication).
- p3 / NURBS in a nutshell – new "Geometry, topology and B-rep": B-rep, topology vs geometry, analytic vs spline geometry (removes "every curve, face and solid is NURBS-based"), surface vs trimmed face, faces vs valid solid — general theory + 24.1 notes (Raise Surface Degree converts analytic to spline; STEP option converting analytic surfaces to NURBS), 25.3 notes (Move preserves analytical geometry).
- p3 / new "Exact shape, tolerance and display": mathematical geometry vs numerical precision (26.1: 8-decimal copy) vs modelling tolerance (values not published; 25.2 FOV note on "very small scene tolerances") vs viewport tessellation (24.1 Ultra faceting; 25.3 faceting without restart) — general theory + release notes.
- p3 / table Degree – "Order of the blending polynomial … higher = smoother" → "Degree = highest power; Order = degree + 1 = CVs per span" — https://doc.plasticity.xyz/cad-essentials/nurbs-overview.
- p3 / added bullet "Degree is not smoothness" (flexibility, C^(d−1) at simple knots, cost) — general theory + NURBS Overview.
- p3 / table Span/knot – "More spans = … heavier, less smooth data" → spans add control/data; knot spacing/multiplicity sets joins; bullet "More spans are not less smooth" — general theory.
- p3 / added bullet: knot insertion and degree elevation can preserve shape (theory); whether Plasticity's Insert Knot/Raise Degree do so exactly → relabelled unresolved.
- p3 / table Weight – "How strongly a CV pulls … Rebuild Curve explicit control has a Weight option" (conflated) → rational CV weight vs Rebuild Curve's fitting **Weight** (lower loosens, higher keeps shape, default 0.5) as separate bullets — nurbs-overview; https://doc.plasticity.xyz/sketch/rebuild-curve; 25.2 notes (Selection panel shows rational).
- p3 / CV row – "hull lines show their order" (ambiguous with order = degree+1) → "sequence of CVs".
- p4 / continuity – G2 includes G1 and G0; G0 allows but does not require a corner; G0–G3 for curves, G0–G2 for surfaces — continuity page + general theory.
- p4 / diagram – `figures/continuity.svg` ("G0 … visible crease", "G1 … highlight jumps") replaced in ch1 by new `c01-continuity.svg`.
- p5 / Entities table Solid – "Closed body … with no holes (watertight)" → closed boundary enclosing a volume; through-holes and cavities allowed; docs' "without any holes" read as no openings — general theory; Object Types page quoted.
- p5 / Entities table Face – "Each planar or curved surface patch" → bounded piece of one surface, analytic or spline.
- p5 / Edge auto-start – "Fillet / Extend Sheet" slash → "Fillet (shared edge) or Extend Sheet (open edge)".
- p6 / Selection modes – "[Tab] (up to 25.3) / [5]" slash/history in normal text → "[5] all modes [26.1]"; "[Shift+1…4]" → "[Shift+1] to [Shift+4]"; step 3 adds "[5] does not cycle" (migration guide); history moved to box.
- p6 / Smart commands – confirm step merged and points to chapter 3 *Confirming, cancelling and repeating commands*; duplicate 26.2 tag on Preferences paragraph removed.
- p7 / Construction planes – new "Origin and orientation" (what each method sets; Ctrl+Space origin = world origin, Ctrl+Shift+Space origin = clicked point; face+edge) — construction-plane page; origin/in-plane axes for face/region/point planes → relabelled unresolved.
- p7 / CPlane table – "at a picked depth" → "with its origin at a point you click" (docs: "Click on the origin of the construction plane"); Midplane row gets [24.2]{.ver}; "Space / Shift+Space" slash → "or".
- p8 / new "Drawing on the plane and snapping off it" – active plane vs off-plane object snaps; 2D Snapping projects picks and drags onto the plane (26.1); behaviour with 2D Snapping off → relabelled unresolved — construction-plane page, 26.1 notes.
- p8 / Snaps at a glance – duplicate Ctrl lines removed (now in Ctrl section); "X / Y / Z" slash → "X, Y or Z"; "new Control-point snap" → "Control-point snap" (tagged 25.1).
- p8 / new Object vs grid snapping table — snap page, grid-and-units page, 24.2 notes (incremental gizmo snapping), 25.3 notes (Scale gizmo).
- p8 / new "What Ctrl does with snapping" (drawing curves: not needed; moving points: enables object snap; dragging with grid snap: disables grid snap; in-command Ctrl+click; Sweep twist 5° steps) — snap, sketching-essentials, grid-and-units pages, 26.1 notes; interaction of both → unresolved.
- p9 / new "Typing values": lengths/distances (Move XYZ = amount of movement), angles (Rotate Angle; unit not stated; Sweep degrees 26.1), scale factors (Scale XYZ, unitless), absolute coordinates (not documented); arithmetic, π, units (25.2 examples) — move/rotate/scale pages, 25.2 notes.
- p9 / Grid and units – added "Display unit or real size?" paragraph; whether changing Length rescales geometry → unresolved.
- p9 / new "Checking imported dimensions" procedure (check Length unit, OBJ/STL unit prompt 24.1, Measure Distance Ctrl+=, Measure Radius, Selection panel parallel-face distance 25.2, ratio check 10/25.4/1000/12 = arithmetic, fix by re-import or Scale) — 24.1/25.2 notes, https://doc.plasticity.xyz/tool/measure; STEP/CAD unit handling → unresolved.
- p9 / new "Exercise: an inclined construction plane" (box rotated 30° about X, Shift+Space on top face, save, rename "Incline 30", reuse via Added Planes, draw/extrude, reopen file) — construction-plane page; persistence of saved planes and origin placement → unresolved.
- p10 / Anatomy – "from 25.1, includes an icon" kept tag; step 4 now points to chapter 3 section.
- p10 / Materials bullet & Applying materials – "it disappears when no object uses it any more" (contradicted docs) → docs wording (disappears only after every referencing object has been deleted); Remove Material resets objects to default; sufficiency of removing references → unresolved; Fork Material moved into Set/Remove list; confirm step 4 removed — https://doc.plasticity.xyz/plasticity-essentials/plasticity-interface/materials, https://doc.plasticity.xyz/common/remove-material.
- p11 / Licences – "free 30-day trial (no commercial use, low-resolution OBJ/STL export)" not in docs → "a free trial also exists, but the docs do not describe its terms"; "current Studio page also lists expanded CAD translation" → Import/Export page's Studio list (IGES/SAT import+export, Rhino import, DXF/DWG import Windows only); points to chapter 10 Compatibility — license-types-and-features, import-export.

### Version labels

- Audited every tag (≈70). All remaining `.ver` tags match their release notes (all 25.1 tags are announced in the 2025.1 notes: region deletion, selection conversion, Tan/Tan, Control-point snap, two-point CPlane, Rebuild Weight, docs icon, Select All With This Material, recent-files drag, update notice, Shift+F, view cube toggle). No 25.1 fallback tags existed in this chapter.
- Changed: Preferences › Commands per-command switches `[26.2]{.ver}` → `[26.2]{.doc}` (26.2 notes only announce the Move switch); the second copy of that tag removed.
- Removed: 9 `.ver` badges used as row labels in the release table (now plain release names); "Tab (up to 25.3)" in-text history (moved to history box).
- Added (each announced in the cited notes): Midplane `[24.2]`, faceting Ultra `[24.1]`, faceting without restart `[25.3]`, 8-decimal copy `[26.1]`, Selection panel rational `[25.2]`, grid gizmo increments `[24.2]`, Scale gizmo increments `[25.3]`, Sweep degrees / Ctrl 5° `[26.1]`, OBJ/STL unit prompt `[24.1]`, parallel-face distance `[25.2]`, π/units in fields `[25.2]` (reworded).
- Note: the 1.3 release notes list Thicken Face under "New Commands" (relevant to the Thicken Face date on old p69).

### Diagrams

- Added `figures/c01-continuity.svg` (G0–G3; captions "ends meet; a corner is allowed", "G0 + same direction", "G1 + same curvature", "G2 + same curvature change"); rendered and checked. Used in ch1 instead of `figures/continuity.svg`.
- `figures/continuity.svg` left untouched (still used by ch6a).
- Kept unchanged (checked, correct): entity-hierarchy, c01-selection-modes, c01-cplane, c01-snapping, command-anatomy, modelling-workflow, c01-left-sidebar, c01-ui-layout.

## Chapter 2–3 Navigation, interface, files; selection and editing
Files: `02-…, 03-…` · old pages 12–17

### Corrections

- p15 / ch3 overview table — slash notation for different bindings (Select All / Invert, Group / Ungroup, Hide row, Delete / Dissolve, Delete Face, Shift+1…4, Ctrl+1…5) → separate rows and explicit "[A] or [B]" / "[Shift+1] to [Shift+4]" bindings — https://doc.plasticity.xyz/plasticity-essentials/general, /selecting-objects.
- p15 / ch3 table "All selection modes: Tab (up to 25.3) / 5" → current [5] [26.1]{.ver} in the table; history moved to an "Older versions" history box, which also records that the Selection Mode page still shows Tab — https://doc.plasticity.xyz/migration-26.1, /plasticity-essentials/plasticity-interface/selection-mode, /all-commands/plasticity-essentials.
- p15 / ch3 table Delete — listed only Shift+Backspace → Shift+Backspace, Shift+X or Shift+Delete (General Functions page) — /plasticity-essentials/general.
- p15 / ch3 table Delete Face — "a solid becomes a sheet" (not documented) → removed; "deleting edges joins fractured edges" moved to the Delete or Dissolve section — /solid/delete-face, release notes 2024.2.
- p15 / ch3 table Deselect All — no context → "outside a command; inside some commands Esc ends the command" — /selecting-objects, /common/place.
- p15 / ch3 "Clicking and box selection" — paragraph on add/remove modifiers merged into new subsection "Viewport, command and Outliner selection": table of add / remove / replace per context (viewport: unresolved; Loft, Sweep, Draft Face: Shift+click / Ctrl+click; Fillet Shell: Ctrl+click and Ctrl+click again; Outliner: hold Shift, from the Rename section; others unresolved). Old text attributed Ctrl+click to "Fillet"; the page is Fillet Shell — /solid/loft, /solid/sweep, /solid/draft-face, /solid/fillet-shell, /plasticity-essentials/plasticity-interface/outliner.
- p15–16 / new: Outliner selection (Select all on section label and on group, Alt+click on folder, / and . over the Outliner) — /outliner.
- p16 / loops table — combined "Curve / Region" and "Face / cylindrical face" rows split; "Cylindercal" spelling fixed — /selecting-objects.
- p16 / "Select by type" — "also across groups" (not in docs) → "every item of that type in the visible viewport" — /selecting-objects.
- new ch3 subsection `### Confirming, cancelling and repeating commands {-}` — start (auto-start, key, Command Palette with arrow keys/wheel + Enter, Shift+R repeat); confirm (OK or right-click; Line/CP Curve/Spline: right-click after last point; circle/arc/rectangle: one click or Enter [24.1]; cursor-sized primitives: click; Dimension: Tab, value, Enter); Tab numeric input (drawing tools, gizmo commands [26.1]); undo/redo and Ctrl+Z "cancels the last click" in Line/CP Curve/Spline; repeated placement (Place: click per copy, Esc to exit; Paste with Placement: right-click per copy, Esc to exit); cancel = unresolved; Esc behaviour; table "Keys that depend on context" (Esc, X, Shift+X, Ctrl, /, .) — /common/place, /common/copy-with-placement, /common/paste-with-placement, /tool/line, /common/dimension, /command-palette, /snap, /outliner, release notes 2024.1 and 2026.1.
- p17 / Delete or Dissolve — keys follow General Functions; added Faces example (Delete Face keys; Dissolve Face and Delete Redundant Topology for redundant faces), Edges example (24.2: Rebuild Edge replaced by deleting edges with X, Shift+X, Delete, Shift+Delete to join fractured edges), Regions line kept; the 24.2 "children move to parent" note and key conflicts moved to an amber unresolved box — /general, /all-commands/plasticity-essentials, /solid/delete-face, /solid/delete-redundant-topology, release notes 2024.2, 2025.1.
- p12 / ch2 navigation table — slash rows "Zoom (steps / continuous)" and "Front / Right / Top … add Ctrl" → separate rows with explicit [Ctrl+Num 1] etc. — /operating-the-3d-viewport.
- p12 / ch2 "Other changes" paragraph mixed current and old behaviour → current options with tags; FOV 50 → 35 (25.2), faster wheel zoom (25.3) and SpaceMouse direction/speed changes (26.1) moved to an "Older versions" history box; keymap.json "(25.1)" → [25.1]{.ver} — release notes 2025.1, 2025.2, 2025.3, 2026.1.
- p13 / ch2 interface table — "Undo / Redo", "Copy / Paste" cells split into separate entries — /general.
- p13–14 / ch2 files table — New / New Window and Save / Save as split; Export "Exports selected/visible objects" (only documented for Export OBJ) → "Export OBJ exports the selection, or everything visible when nothing is selected" — release notes 2025.3.
- p14 / ch2 "Saving your work" — backup folders moved to the new subsection "Recovering a backup"; added 24.1 unsaved-changes dot/warning; duplicate "docs do not say where autosaved files are written" consolidated — /preferences, release notes 2024.1, 2024.2, 2026.2.
- new ch2 subsection `### Recovering a backup {-}` — locate (file tab › browse backups [26.2], or documented folders), copy out of the temp folder [ADVICE], open with Ctrl+O [UNRESOLVED: file names/format/Open support], check [ADVICE], Save as under a new name — /preferences, /file-menu, release notes 2026.2.
- p14 / ch2 appended .plasticity "(24.2)" → [24.2]{.ver}; "from 26.2" → [26.2]{.ver} — release notes 2024.2, 2026.2.

### Version labels

- Changed: 4 — keymap.json plain "(25.1)" → [25.1]{.ver}; append groups/names/materials "(24.2)" → [24.2]{.ver}; added [24.2]{.ver} to the autosave row in the files table; Export OBJ fallback [25.3]{.doc} (new; listed in 25.3 notes but not clearly announced as new). Added [24.1]{.ver} (unsaved-changes dot/warning; one-click/Enter confirm for circle/arc/rectangle tools) and [26.1]{.ver} (gizmo Tab input) — all from release notes that announce them.
- Audited and kept: all other tags in both files (25.1 orbit dot, Suggested Commands, progress indicator, thumbnails, start-up preference, Recent Files drag; 25.2 Zoom Factor, CV hull, context menu, Invert on edges/faces, Unlock All, Select All skips locked; 25.3 languages; 26.1 Arcball, Lock Horizon, unsaved prompt, key 5; 26.2 Home View, view cube orientation, edge colours, file tab menu, append meshes, Select All Constraints, Add to Isolation; 25.1 region deletion) — each is announced in that version's notes. No `25.1` fallback tags were found in these files. No cards in these chapters.

### Diagrams

- Kept c03-box-select.svg, c03-delete-dissolve.svg (moved after the steps; matches General Functions page) and c02-view-cube.svg (matches View Cube page and 26.2 notes). None added or removed.

## Chapter 4 Sketching and primitive tools
Files: `04-sketching-and-primitive-tools.md` · old pages 18–30

### Corrections

- p18 intro table / Tab row – said "fields accept arithmetic" for the live input boxes → now says numeric fields in dialogs accept arithmetic (always supported); π and unit suffixes from 25.2 – https://doc.plasticity.xyz/release-notes/whats-new-2025.2
- p18 intro – Shift+X "(24.1)" plain text → [24.1]{.ver}; the step-through behaviour is from /plasticity-essentials/plasticity-interface/snap.
- p18 intro – added one general confirm line pointing to chapter 3's *Confirming, cancelling and repeating commands*; removed the repeated "Confirm with OK in the command dialog or right-click" lines from the cards. I kept them where a card differs (Line, Polygon, Rectangle, Dimension [Enter], Measure Radius).
- p18 new amber note "Radius or diameter?" – lists, for each command and field, what the docs say. Nothing is settled → relabelled unresolved. Evidence: the command pages listed above. The English Cylinder page says "Radius: Specify the diameter", while the German and Japanese pages say "specify the radius". The 26.1 notes call the Tangent Circle inline input a radius.
- p19–20 Line – removed the duplicate Ctrl+C tip (it is already in the intro table).
- p21 Circles – removed the common problem that claimed "the official pages describe Center Circle as 'centre and diameter', while the live dimension may show a radius" (the second half is undocumented). The Tab step now says to read the label. Added an `Unresolved:` test – relabelled unresolved.
- p22 Tangent Circle – Radius option: the label says Radius but the page says "Specify the diameter" → marked [UNRESOLVED]. Added a test. The "within the allowed range" wording was dropped (the 26.1 notes only say "see and round") – /release-notes/whats-new-2026.1
- p25 Spiral – Radius and [R] marked [UNRESOLVED]. Added the general helix arithmetic (axis length = pitch × turns) as a tip, saying that Plasticity's Pitch meaning is undocumented. Added two tests.
- p26–28 Sphere, Cylinder – Radius field marked [UNRESOLVED]. For Cylinder the English page conflicts with the German and Japanese pages. Added tests. Added numerical examples: a 40 × 20 × 10 box, and an 8-wide hole through a plate 10 thick (the cylinder value depends on radius vs diameter) – plan §5 numerical examples.
- p28 Dimension – now states that it changes the geometry once and that the docs describe no lasting link → no persistent-relationship implication. Added a 40 × 20 → 50 × 20 example – /common/dimension.
- p28 new `### Dimension, measurements and constraints {-}` subsection – separates Dimension (changes a size once), measurement annotations (read only, live-updating in the Outliner) and the Constraint System (26.2, Studio, created by Square, Surface Align, Project Align, Vertex Align and the Bridge commands; currently not saved in the file) – /plasticity-essentials/constraint-system, /release-notes/whats-new-2026.2
- p28 Measure Distance – split into four procedures: one edge or curve; two points; axis-projected distance (left-click towards an axis); direct distance (right-click). Description now uses the doc wording ("size of a rectangular curve or the diameter of a cylinder"). Plain "(24.1)"-style notes are now tags – /tool/measure, 24.1, 24.2, 25.2, 25.3 and 26.1 notes.
- p29 Measure Radius – added a tip that it checks what a size field took.
- p29–30 Measure Continuity – now separates continuity combs/deviation plots from Toggle Curvature's curvature combs. The G0/G1/G2 Scale wording was rewritten (see Cross-chapter); acceptance tolerance is marked unresolved. Added the common problem "judge from the value and marker, not the comb size". The continuity-combs diagram (which shows *curvature* combs) moved to Toggle Curvature – /tool/measure-continuity, /solid/surface-align, 25.3 notes.
- p30 new `### Exercise: G0 passes, G1 fails {-}` – a procedure using box faces separated with Unjoin Faces. It gives only the theoretical expectation (about 0 for G0, about 90° for G1), no measured values, and is marked unresolved – plan §6, general theory.
- p30 Toggle Curvature – qualified "equal lines = a true arc" to planar curves (a helix has constant curvature too) – general theory. Comb scale is now described as display size only (/plasticity-essentials/plasticity-interface/curvature). Autosize is "based on the viewport zoom". The rename history moved to `Older versions:`. Added a tip that explains the G0/G1/G2 comb diagram – /sketch/toggle-curve-curvature.
- Throughout – slash key notation (X/Y/Z, Up/Down, N/B) is now written as "[X], [Y] or [Z]" and similar.

### Version labels

13 card tags changed; 9 kept.
- `version`→`documented`: Line 25.1→doc 26.1; Spline Curve 25.1→doc 26.1; Control Point Curve 25.1→doc 26.1 (earliest mention: the 26.1 Ctrl+C table); Circles 1.4→doc 1.4; Arcs 24.1→doc 24.1; Regular Polygon 24.1→doc 24.1; Rectangles 24.1→doc 24.1; Spiral 25.1→doc 26.2 (no release notes mention it); Text 24.2→doc 24.2; Sphere, Box and Cylinder 1.3→doc 1.3 (the 1.3 notes only add default names).
- Kept as `version` (the notes say added/new): Tangent Circle 1.4, Tangent Arc 1.4, Measure Distance 1.4, Dimension 1.4, Section Analysis 25.1, Measure Continuity 25.2, Toggle Curvature 25.2, Ellipse 25.3, Measure Radius 25.3.
- About 20 plain "(1.3)", "(1.4)", "(24.1)", "(24.2)", "(25.2)" parentheticals became `.ver` tags (each is announced as new or changed in those notes). Added [26.2]{.ver} for the Constraint System. All existing inline 25.x and 26.x tags were checked against the notes and are correct.

### Diagrams

- c04-curvature-comb.svg – caption "equal lines: a true arc" → "planar curve, equal lines: an arc" (rendered and checked).
- c04-continuity-combs.svg – unchanged, but moved from Measure Continuity to Toggle Curvature: it shows curvature combs across a joint, not Measure Continuity's deviation combs.
- No diagrams added or removed.

Layout note: in the stand-alone preview, Circles (p7) and Measure Continuity (p18) end with only Unresolved and Related on the next page. Final pagination will differ; check this in the full build.

## Chapter 5 Common commands (curves and bodies)
Files: `05-common-commands-curves-and-bodies.md` · old pages 31–43

### Corrections

- p31 chapter intro – none → one line pointing to *Confirming, cancelling and repeating commands* in chapter 3; repetitive "Confirm with OK in the command dialog or right-click" steps shortened to "Confirm." (kept full wording only in Place and Copy / Paste with Placement, which differ) – brief.
- p31 Shared transform options – history ("introduced in 25.1 as Local / CPlane / World …") mixed into current text → moved to a grey history note "Older versions: transform options" – https://doc.plasticity.xyz/release-notes/whats-new-2025.1.
- p32 automatic pivot alignment – stated for any new primitive or sketch object, untagged → limited to the tools the 25.3 notes list (boxes, cylinder, rectangles, circles, regular polygon), tagged [25.3] – https://doc.plasticity.xyz/release-notes/whats-new-2025.3.
- p32–35 all cards – slash key notation ([X]/[Y]/[Z], Shift+Wheel up / down, "G → F → right-click") → explicit "[X], [Y] or [Z]", "[Shift+Wheel up] adds a copy; [Shift+Wheel down] removes one", "[G], then [F], then right-click twice" – brief.
- p35 Mirror – "Union halves × Make instances" not addressed → states docs are silent, [UNRESOLVED], test under Unresolved; "Cut down mirror plane" piece question also given a test – https://doc.plasticity.xyz/common/mirror.
- p35 Mirror intro – "mirror it with both options on" → names the options (Cut down mirror plane and Union halves).
- p36 Duplicate – "name and material inherited" (not on the Duplicate page; release notes say it only for Copy and Paste and Alternative Duplicate faces) → removed from established text, moved to Unresolved with test; added "independent copy, changes to the original not passed on" (contrast "instances instead of independent copies" on Mirror/array pages) – https://doc.plasticity.xyz/common/duplicate, whats-new-2024.2.
- p36 Duplicate PolySpline CVs – added the documented rebuild when support geometry is missing [26.2] – whats-new-2026.2.
- p36–37 Alternative Duplicate (curves) – "keeps the curve's overall shape and continuity" stated universally → quoted as the official wording and qualified in a new note "What a planar projection changes": lengths shorten (100 mm at 30° → 86.6 mm), angles/curvature change, G1 can be lost where the tangent is parallel to the projection direction, degenerate cases (line along normal → point; curve in a plane containing the normal → segment) – general theory; Plasticity's behaviour on degenerate input → Unresolved with test.
- p37 Alternative Duplicate faces – "(name and material kept, 24.2)" → [24.2]{.ver} inline – whats-new-2024.2.
- p38 Place – added "dragging an asset into the viewport starts Place" [26.2]; snap conflict reworded (26.1 notes face/edge only vs 26.2 notes + Create Instance page "all snap points") – assets page, whats-new-2026.1/2026.2.
- p38 Copy / Paste with Placement – "Copies inherit name and material (24.2)" → tip saying the 24.2 notes say this of the Copy and Paste command and do not say whether it covers the with-Placement variants; key attribute "[Ctrl+Shift+C] / [Ctrl+Shift+V]" → "[Ctrl+Shift+C] (copy), [Ctrl+Shift+V] (paste)" (slash notation; bindings unchanged) – copy-with-placement page, whats-new-2024.2.
- p39 new subsection "### How array counts work {-}" – documents that Number / Number 2 = "number of duplications" and Repeat = "number of repetitions", that inclusion of the original is not documented ([UNRESOLVED]), and gives a table of pure arithmetic for reading A (count includes original) and reading B (count = new copies only): spacing, extent, grid, radial spacing and radial total examples. Arrays diagram moved below the table.
- p39 Curve Array – Number linked to the count note; Unresolved test added.
- p40 Radial Array – Number 1 / Step 1 now quoted exactly and marked [UNRESOLVED] (page does not say how Number 1 differs from Number 2 or whether Step 1 is length or angle); noted that the page says "total distance" for Total mode though the value is Degrees; two Unresolved tests – https://doc.plasticity.xyz/common/radial-array.
- p41 Rectangular Array – noted that the 24.2 notes call the Extent mode "Extend"; count/Extent end point → Unresolved test – rectangular-array page, whats-new-2024.2.
- p41 new subsection "### Duplicate, instance or asset? {-}" with comparison table (what you get, editability, dependency, source updates, breaking the link, limits) – create-solid-and-sheet-instance, create-curve-instance, realize pages, duplicate page, assets page, whats-new-2025.3/2026.2. Asset update propagation and whether placed assets are instance objects marked not documented / [UNRESOLVED].
- p41 Create Instance – added "colour for curve instances", "curve instances hide their CVs"; edge-colour preference tagged [26.2] – create-curve-instance page, whats-new-2026.2.
- p42 Set Material – "(the Assets menu in earlier versions)" history moved to "Older versions:"; added documented value anchors for Roughness/Metalness (0–1) and IOR (1.0 air, 1.5 glass, 2.4 diamond); Density placed under Advanced, mass per object in the Selection menu; drag from library tagged [25.3]; export problem reworded to "physical material properties … not kept when you export to other software" – set-material page, materials page.
- p42–43 Remove Material / material cleanup – reconciled (see Cross-chapter): Remove Material resets objects to the default material and does not delete the material; removal from the Used Materials list documented only for deletion of every referencing object; reference-removal-only case [UNRESOLVED] with test; groups via Outliner right-click › Remove material – remove-material, materials, outliner pages.
- p43 Subdivide – "Doubles the CVs … and increases degree and spans of surfaces each time" stated as fact → description now neutral ("adds control points"), docs' wording quoted per input type, surface contradiction marked [UNRESOLVED], tip "each run doubles a curve's CVs" removed; general-theory tip that "doubled" need not mean ×2 (4-CV single-span cubic + one knot per span → 5 CVs); key history moved to "Older versions:"; two Unresolved tests – https://doc.plasticity.xyz/common/subdivide, whats-new-2025.3.

### Version labels

Card labels changed (12 of 18):
- Move 1.3 → documented 1.3 (1.3 notes only enhance edge moves).
- Rotate 24.1 → documented 24.1; Scale 24.1 → documented 24.1 (24.1 notes mention move/rotate/scale refaceting only).
- Mirror version 25.1 → documented 25.3 (25.1 "mirrored transformations" are Move CV mirroring; first Mirror-command mention is 25.3).
- Duplicate 25.1 → documented 25.2 (first mention: 25.2 recursive group duplication).
- Alternative Duplicate version 24.2 → documented 24.2 (see Cross-chapter).
- Place 1.3 → documented 1.3 (1.3 notes say Copy/Paste with Placement "operate akin to the Place command", so Place already existed).
- Curve Array 25.1 → documented 25.2 (first mention 25.2 Extend Methods).
- Radial Array 1.4 → documented 1.4; Rectangular Array 1.4 → documented 1.4 (1.4 only "now remember the last used count").
- Set Material 25.1 → documented 1.3 (1.3 Outliner notes: modifying materials of multiple selected objects; 25.1 does not introduce it).
- Remove Material 25.1 → documented 26.2 (no release-note mention).
- Subdivide 25.1 → documented 25.3 (first mention: key removed).
- Complete Edge 25.1 → documented 26.2 (no release-note mention).
Kept as introduced: Copy / Paste with Placement 1.3 ("we've introduced"), Create Instance 25.3, Realize Instances 25.3, Fork Material 25.2 ("New Fork Material Command").
Inline: plain "(24.2)", "(24.1)", "(1.4)", "(25.3)", "(26.1)", "(25.1)" notes converted to [x.y]{.ver} where the notes announce the change (about 12); added [25.3] (pivot auto-orientation, library drag), [26.2] (asset → Place, instance edge colour), [24.2] (Alt Dup faces). All other inline tags checked against the notes and kept.

### Diagrams

- No diagrams added, changed or removed. Checked c05-pivot, c05-mirror, c05-place, c05-arrays, c05-curve-array, c05-instances: none draws an undocumented claim (arrays diagram shows no count). c05-arrays.svg moved below the count table.

## Chapter 6 Curve (sketch) commands
Files: `06a-…, 06b-…` · old pages 44–61

### Corrections

- p44 chapter intro: added a single general confirm line that points to *Confirming, cancelling and repeating commands* in chapter 3. I removed about 15 repeated "Confirm with OK in the command dialog or right-click" steps from both files.
- p45 Join Curves: said the end points "must coincide exactly" → now says they must meet. The docs say "perfectly aligned" (blue-green means connected, purple means not). In practice this means coinciding within Plasticity's modelling tolerance by snapping. No numeric tolerance is given. Evidence: https://doc.plasticity.xyz/sketch/join-curves. The tolerance value is unresolved.
- p46 Insert Knot: said it adds a CV "at a picked location without changing its shape" and "click where the CV should go" → now explains knot insertion at a parameter location, with neighbouring CVs moved to keep the shape (general NURBS theory). It says the new CV lies on the hull and not necessarily at the clicked point, and that the docs only say "insert a CV". Evidence: general theory and https://doc.plasticity.xyz/sketch/insert-knot. Exact shape preservation is unresolved.
- p46–47 new note box "Checklist: a closed outline shows no region" (after Cut Curve; also added to the I-want-to table). It covers open end points (docs), non-coplanar geometry (advice; the docs treat regions per plane), duplicate or overlapping segments (advice plus unresolved), self-intersections (advice) and the region-display limit of about 700 curves per plane (docs: object-types, import-export). Whether a joined curve counts as one curve is unresolved.
- p48 (old detached "Related" of Offset Curve (unified)): the preview shows every card's final section kept with the card. No orphan.
- p49 Offset Region, Individual: the old text already followed the docs ("on = combined"). Its "check the preview" is now marked [UNRESOLVED], because the docs wording contradicts the option name, and a test was added. The description now uses the docs' "individual regions or one combined region". Evidence: https://doc.plasticity.xyz/sketch/offset-region.
- Offset Planar Curve, Offset Region, Offset Vertex, Bridge Curve, Vertex Align, Unjoin Curves, Extend Curve: moved history (Tab→S, clamped offset before 26.2, the removed Sense option, Align→Edge Align, Explode→Unjoin, vertices only before 24.1) into new "Older versions:" sections.
- Extend Curve: rewrote the shape descriptions in the docs' own wording ("Reflective … symmetrical continuation"; dropped "seamless"). Added a line saying the diagram redraws the official docs figure and is not an application test. The continuity of each shape is unresolved.
- Bridge Vertex · Bridge Edge: the claim that "Parameter/Trim/Show curvature replace former Side 1/Side 2 [26.2]" has no source in the current docs or release notes, so it was moved to Unresolved. The [L] key conflict is now tagged [UNRESOLVED].
- Vertex Align: removed an unpublished note (polylines move rigidly, only G0/G1, from a commented-out MDX block) from Common problems. It is now kept under Unresolved as an unverified observation. The G0–G2 versus G0–G3 conflict is tagged [UNRESOLVED].
- Fillet Curve: added an Unresolved item for which drag direction gives a fillet and which a chamfer (the docs do not say).
- Slot: key attribute changed from `[O] [O]` to `[O]{.key}, then [O]{.key}`. This is notation only, not a binding change. In-text "press O twice" is now "[O], then [O]".
- Project Outline card: added a line saying Project Outline and Create Outline are new in 1.3, Alternative Duplicate is first mentioned in the 24.2 notes [24.2]{.doc}, and Duplicate Curve and Project is in no notes [26.2]{.doc}.
- Rebuild Curve and Toggle Points: plain-text "(1.3)", "(24.2)" and "(25.1)" became proper .ver tags.
- Offset Curve (unified): "One key for every offset" became "One key for the curve and edge offsets" (removes a completeness promise).

### Version labels

Changed 19 card labels; kept 7 .ver labels. I also converted 4 plain-text dates to .ver tags, added 2 .doc tags, and confirmed or kept all other inline .ver tags against the notes.
- version→documented: Trim 25.1 (only a 25.1 optimisation); Join Curves 26.2; Unjoin Curves 1.3 (renamed from Explode); Split Segment 26.2; Insert Knot 26.2; Cut Curve 25.2 (Extend option); Offset Curve (unified) 26.2; Offset Planar Curve 26.1 and Offset Region 26.1 (migration guide); Fillet Curve · Fillet Vertex 26.2; Extend Curve 24.1 (enhancement); Bridge Curve 24.2 and Bridge Vertex · Bridge Edge 24.2 (enhancement); Project (unified) 26.2; Project Curve-Body 25.1 (tooltips only); Project Body-Body · Curve-Curve 25.2; Raise Curve Degree 26.2 (25.1 notes cover surfaces only); Rebuild Curve 1.3; Convert Vertex 26.2 (the 25.1 note is about selection conversion); Delete Redundant Topology 24.1.
- Kept as version (introduced): Offset Vertex 1.4, Slot 26.1, Vertex Align 26.1 (curve align added), Project Outline card 1.3 (Project Outline and Create Outline are 1.3 new commands), Deform Curve 24.2, Reverse Curve 24.2, Slide Curve CV 25.1, Toggle Points 24.1.

### Diagrams

- No diagrams added or removed. I kept c06-extend-shapes.svg: it matches the official docs figure (public/img/extend-curve-shape.svg), and the card now says it is a redrawing, not a test. All other c06 and c06p diagrams were checked in the preview and kept.

## Chapter 7.1–7.3 Solids, Booleans and fillets
Files: `07a-solid-and-surface-commands.md` · old pages 62–74

### Corrections

- p62 / chapter intro – a "confirm with OK or right-click" step was repeated in every card → one intro sentence pointing to *Confirming, cancelling and repeating commands* in chapter 3; "then confirm" added to the last step of each card – brief.
- p62 / Extrude – the surface-edge support from 26.1 is kept, rewritten as "faces, regions or surface edges give solids; surface edges can be extruded directly from 26.1 [26.1]" – https://doc.plasticity.xyz/solid/extrude + whats-new-2026.1 "Edge Extrusion".
- p62 / Extrude – the Tab→S history was mixed into Options/Keys → current binding [S] in Options/Keys; history moved to "Older versions:" – https://doc.plasticity.xyz/migration-26.1.
- p62 / Extrude – Slice was described as "makes a solid where they overlap and keeps the remaining solids" → "as Boolean › Slice: the overlap and the remaining pieces become separate solids" – boolean page and image.
- p62 / Extrude – no statement on which side the Thickness wall lies → "Unresolved:" bullet added.
- p63 / Revolve – Normal/Binormal/Tangent "check in your version" → tagged [UNRESOLVED], with an "Unresolved:" test – https://doc.plasticity.xyz/solid/revolve.
- p64–65 / Loft – "(24.1)" plain text → [24.1]{.ver} (diagnostic error bodies are new in 24.1); the duplicate Tip "Simplify off preserves… (25.2)" was removed (already under Options) – whats-new-2024.1, 2025.2.
- p65 / Loft – new subsection "### Example: lofting closed profiles" (closed-profile seams and twisting): what the docs say (nothing on seams; a "Loft Closed Curves" section is commented out of the page source), general NURBS seam/twist theory labelled [ADVICE], a 4-step exercise with no measured values, plus an amber unresolved box – general theory + https://doc.plasticity.xyz/solid/loft.
- p66 / Sweep – Parallel/Normal were paraphrased as if understood → the official one-line wording is quoted, and the asymmetric-profile behaviour is marked [UNRESOLVED] with a test. No diagram drawn (the docs do not establish the behaviour) – https://doc.plasticity.xyz/solid/sweep.
- p66 / Sweep – the radians→degrees history moved to "Older versions:"; Scale tagged [24.1]{.ver} ("Added scaling options to the Pipe and Sweep commands") – whats-new-2024.1, 2026.1.
- p67 / Pipe – the official dimensional-accuracy note is kept as an "Official warning" paragraph in the card body, with its source URL https://doc.plasticity.xyz/solid/pipe and access date 21/10/2026; the Common problems entry now refers to it.
- p67 / Pipe – multiple pipes tagged [1.4]{.ver}, Scale [24.1]{.ver}; the Section Size→Diameter rename moved to "Older versions:"; the Diameter-vs-wall relation added under "Unresolved:" – whats-new-1-4, 2024.1, 2026.1.
- p68 / Patch – "(24.2)" and "(24.1)" plain text → [24.2]{.ver} (sheet from a solid's edge loop) and [24.1]{.ver} (trim sheet to hole) – whats-new-2024.1/2024.2.
- p69 / Thicken · Thicken Face – the card said version 25.1 while the text said "Thicken Face appeared in 1.3" → card documented="1.3"; "Thicken Face was added in 1.3 [1.3]{.ver}; the introduction date of Thicken for sheets is not known" – whats-new-1-3 lists Thicken Face under "New Commands".
- p69 / Thicken – "Run Thicken (or Thicken Face)" was wrong: both official pages tell you to run the **Thicken** command, and the selection decides the behaviour → corrected. Removed the "use Thicken Face instead" problem that depended on two separate commands – https://doc.plasticity.xyz/solid/thicken-face.
- p69 / Thicken – Thickness now quotes "the thickness of each of both sides" (per side). The total wall is not stated → "Unresolved:" bullets for per-side vs total and for which side is the front – https://doc.plasticity.xyz/solid/thicken.
- p69 / Thicken – Tab→S history moved to "Older versions:"; the 26.2 red highlight and the Max shader are kept as [26.2] – migration-26.1, whats-new-2026.2.
- p70 / Hollow – now also says Hollow is in the Suggested Commands menu (the official button field); Thickness is described as one value for the whole wall; Local is described only as documented; wall direction and Local added under "Unresolved:" – https://doc.plasticity.xyz/solid/hollow.
- p70 / Hollow vs Thicken – new subsection "### Hollow or Thicken?" with a table (starts from, surfaces kept, thickness values, direction, failure hint). The direction rows are [UNRESOLVED]. One [ADVICE] paragraph – thicken/hollow pages.
- p72 / Boolean – Slice: the diagram and text implied 2 pieces → the official solid/solid image shows 3 pieces (overlap, target remainder, tool remainder); text and diagram corrected – https://doc.plasticity.xyz/solid/boolean (boolean-1.png).
- p72 / Boolean – "move the tool slightly with G" was presented as a fix → it is now a diagnostic only. New subsection "### When a Boolean fails" covers: documented facts; general B-rep advice for overlapping, touching, tangent, nearly coincident and disconnected inputs (labelled [ADVICE]); a 5-step diagnose/fix workflow that keeps the intended dimensions (run through-cut tools past the far side, sink Union tools into the target, snap faces to exact coincidence, Delete Redundant Topology, fillet after the Boolean, split into single-tool Booleans); and an amber unresolved test box – boolean page + general theory.
- p73 / Cut – the E/Tab conflict "check which applies" → [UNRESOLVED] with an "Unresolved:" test – cut and cut-curve pages.
- p73–74 / Fillet Shell – "(1.3)" and "(Full Round, 24.1)" → [1.3]{.ver} and [24.1]{.ver} ("the 24.1 release notes call it *Full Round*") – whats-new-1-3, 2024.1.
- p73–74 / Fillet Shell – new paragraph "Circular fillets and other blends": the docs never say which shape is constant-radius circular. It notes the Distance vs radius wording, then general geometry labelled [ADVICE] (a circle is a special conic; G2 next to a flat face cannot be a single arc; a circular section with a constant chord needs a varying radius) and an "Unresolved:" test – fillet-shell page + general theory.
- p74 / Fillet Shell – the Fillet Order of Operations page is now described as what it is: a summary of reference videos made in other CAD programs – https://doc.plasticity.xyz/cad-essentials/fillet-order-of-operations.
- Throughout – "A / B" slash key notation replaced with "[A] or [B]" / "adds and … removes" wording; no completeness promises remain in this file.

### Version labels

Card labels changed: 13 of 15 (PolySplines `version="26.1"` was kept, because it is a new command in the 26.1 notes; Thicken changed from version 25.1 to documented 1.3).
- Extrude 25.1 → documented 1.3 (first mentioned in the 1.3 notes, gizmo thickness enhancement).
- Revolve 25.1 → documented 26.1 (first mentioned in the 26.1 notes).
- Loft 25.1 → documented 24.1; Sweep 25.1 → documented 24.1; Pipe 25.1 → documented 1.4.
- Patch version 24.1 → documented 24.1 (the 24.1 notes describe an enhancement, not a new command).
- Thicken · Thicken Face 25.1 → documented 1.3. **Thicken Face date resolved:** introduced in 1.3 (whats-new-1-3, "New Commands › Thicken Face"); inline [1.3]{.ver}. Thicken for sheets: no release notes announce it (first mentioned in migration-26.1 / 26.1 notes) → "introduction date not known". The card uses documented="1.3" because it is the earliest mention covering the card.
- Hollow 25.1 → documented 26.1; Constrained Surface 25.1 → documented 26.2 (in no release notes); Remove Fillets from Shell 25.1 → documented 26.2.
- Boolean 25.1 → documented 25.2; Cut 25.1 → documented 25.2; Fillet Shell 25.1 → documented 1.3.

Inline tags: 8 plain-text dates converted to `.ver` ([24.1] ×4: Loft and Sweep diagnostic bodies, Patch trim, Full; [24.2] Patch; [1.3] Chordal and Thicken Face; [1.4] multiple pipes); 2 new [24.1]{.ver} for Scale (Sweep, Pipe). All remaining 25.2–26.2 `.ver` tags were checked against the notes and kept.

### Diagrams

- Changed `figures/c07-boolean-ops.svg`: the Slice panel now shows three separate pieces (target remainder, overlap, tool remainder), labelled "3 separate solids" with the caption "overlap and both remainders", to match the official solid/solid image. Rendered and checked.
- Changed `figures/c07-thicken-hollow.svg`: Thicken labels are now "side 1 thickness"/"side 2 thickness" with the caption "one thickness value per side"; both Hollow panels carry "schematic: wall side not documented"; the SVG comment records the sources. Rendered and checked in the preview.
- Kept unchanged (still correct): c07-extrude-boolean, c07-revolve, c07-loft-sweep-pipe, c07-cut, c07-fillet-shapes.
- Not added: a Sweep Parallel/Normal asymmetric-profile diagram (the docs do not establish the behaviour) and a Loft seam diagram (seam behaviour is undocumented).

## Chapter 7.4 Surfacing
Files: `07b-surfacing.md` · old pages 75–86

### Corrections

- p75 / section intro – no shared confirm/cancel guidance → one line pointing to *Confirming, cancelling and repeating commands* in chapter 3; the repeated "Confirm with OK… or right-click" steps are removed from all cards (Bridge Surface, Square, XNurbs, Surface Align, Project Align, Extend Sheet, Deform, Rebuild Face, Slide Surface CV) – brief.
- p76 / Square intro – "high-quality", "clean, predictable CV layout", "more flexible" → neutral wording ("you decide the CV layout", "an alternative to") – plan 10 (remove quality claims); https://doc.plasticity.xyz/solid/square.
- p77 / Square Free – now says Free trades G0 precision, so the edges may not touch the boundary exactly – 2025.1 notes https://doc.plasticity.xyz/release-notes/whats-new-2025.1.
- p77 / Square Flatness – "higher = higher quality" given as plain fact → given as what the docs say, with the geometric effect/trade-off marked UNRESOLVED – https://doc.plasticity.xyz/solid/square, /solid/xnurbs; relabelled unresolved.
- p77 / Square Weight – now called a fitting weight; explains that lowering it trades boundary adherence/accuracy for smoother reflections, and says to measure the edges afterwards; new paragraph "Fitting Weight versus CV weights" separates it from rational CV weights – /solid/square ("…to produce the desired surface accuracy"); /cad-essentials/nurbs-overview (CV weight); general theory.
- p77 / Square Common problems – "Poor reflections → lower Weight" without caveat → says the fit to the boundary gets looser and to check G0/G1 with Analysis or Measure Continuity – plan 10.
- p77 / Square Common problems – new: CV count = degree + spans per direction for a clamped B-spline with single knots (degree 3, 4 spans → 7), to be counted with Toggle Points – general theory (arithmetic only).
- p76 / Square sheet input – the history "Before 26.2 this input caused an error" is moved to *Older versions:* – 2026.2 notes.
- p77 / Square Create Constraints – adds "Constraints last only for the current session" – /plasticity-essentials/constraint-system.
- p77 / Square – new *Unresolved:* section (Flatness, Weight edge drift).
- p78 / XNurbs intro – "high-quality surface" → "a surface" – plan 10.
- p78 / XNurbs Flatness – as for Square: docs' wording quoted, trade-off UNRESOLVED; the documented 0.95–1.00 range for Quad sided is kept – /solid/xnurbs.
- p78 / XNurbs Quality – the documented cost (more splines) is now stated as the trade-off – /solid/xnurbs.
- p79 / Surface Align "Both surfaces must be B-spline" → "The docs say surfaces must be B-spline surfaces to use Align effectively" – /solid/surface-align (Note callout).
- p79 / Surface Align G0/G1/G2 Scale – "set the tolerance scale of each check" as plain fact → both documented descriptions given, conflict marked UNRESOLVED, with test – /solid/surface-align, /tool/measure-continuity, 2025.3 notes.
- p80 / Surface Align Common problems – "fails → one of the surfaces is not a B-spline" (single cause) → non-B-spline is the documented cause "but not the only possible one"; list now also: wrong edge picked on joined sheets (documented), Skew needs G1 (documented), Symmetric moves reference (documented), Degree/Spans/Blend extra rows too low ([ADVICE]), trimmed target ([ADVICE], with note that only Project Align documents the untrimmed requirement) – plan 10.
- p79 / Surface Align and p81 Project Align – "Constraints last only for the current session" repeated in the Create Constraints bullet / constraint paragraph – constraint-system page, 2026.2 notes.
- p80 / Surface Align – new *Unresolved:* (G-Scale meaning).
- p82 / Constraint System note – session-only limitation moved from the last line to the opening, bold, citing docs and 26.2 notes; new paragraph "Constraint versus geometry" separating persistence of the produced geometry from the (unsaved) constraint; post-reopen behaviour marked UNTESTED; closing advice "Before you close the file" – https://doc.plasticity.xyz/plasticity-essentials/constraint-system, https://doc.plasticity.xyz/release-notes/whats-new-2026.2.
- new / amber box "Constraints after save and reopen" with the application test.
- new `### Surfacing exercises {-}` (after the Constraint note): Exercise 1 (Square vs XNurbs on a box with its top face deleted: inputs, continuity/fitting settings, CV count, Analysis markers, Measure Continuity G0/G1, zebra shading, Join Sheets result) and Exercise 2 (Edge Align on two faces of an unjoined box: G0 pass / G1 ≈ 90° fail from geometry, attempt on planar faces, rebuild, re-align, Blend extra rows, measurement, join). Blank record tables; no measured values – plan 10 worked examples, brief.
- p83 / Join Sheets – new Common problem: after Square Free/low Weight the edges may have moved off the boundary; check G0 – follows from /solid/square, 2025.1 notes.
- p83 / Unjoin – new *Older versions:* Explode renamed to Unjoin in 1.3 – 1.3 notes.
- p84 / Deform – "from 26.2, curves" history moved to *Older versions:* – 2026.2 notes.
- p85 / Rebuild Face Tolerance – "and so the quality" → CV count direction kept, "the docs say this determines the output quality", trade-off stated as general theory; new tip: Rebuild Face has no fitting Weight (Square and Rebuild Curve do) – /solid/rebuild-face, /sketch/rebuild-curve.
- p86 / Remove Nominal Surface – intro "This command reveals those hidden spans" stated as fact → "acts on those hidden spans; the official sources disagree"; the old tip about displays/removes replaced by an *Unresolved:* bullet quoting all three descriptions (command page "displays"/"reveal hidden CVs"; 24.1 New Commands "Remove hidden surface CVs"; 24.1 Nominal Face "in case it needs to be removed") with a before/after CV-inspection test; notes that the "only after Raise Surface Degree" restriction of 24.1 now also extends to PolySpline faces (26.2) – /solid/remove-nominal-surface, 2024.1 and 2026.2 notes, /solid/polyspline.
- p86 / Slide Surface CV keys – slash notation "[U] / [Shift+U] positive / negative U" → explicit bindings; "Measure Curvature before 25.3" moved to *Older versions:* – brief; 2025.3 notes.
- all cards – plain-text "(25.1)", "(24.2)", "(24.1)" introduction notes converted to `[x.y]{.ver}` tags (all are additions in those release notes); "From 26.2 …" / "From 25.2 …" prose replaced by the tag alone where it described current behaviour.

### Version labels

Card labels changed: 6.
- Bridge Surface `version="25.1"` → `documented="25.1"` (25.1 notes only add Tension).
- Extend Sheet `version="24.1"` → `documented="24.1"` (24.1 lists it under New Commands but the body text says "a new behavior for the Extend Sheet Command", so the command already existed; decision: documented).
- Join Sheets `version="25.1"` → `documented="24.1"` (24.1 notes: one-sheet prompt).
- Unjoin Faces · Unjoin Shells `version="25.1"` → `documented="1.3"` (1.3: Explode renamed to Unjoin).
- Untrim `version="24.1"` → `documented="24.1"` (24.1: "has been enhanced").
- Find Boundary Edges `version="25.1"` → `documented="26.2"` (no release notes mention it).
Kept as introduced: Square 24.2, XNurbs 24.1, Surface Align 25.2 ("New Align Command"), Project Align 26.2, Deform 24.2, Raise Surface Degree 24.1, Rebuild Face 24.1, Reverse Sheet 24.2, Remove Nominal Surface 24.1, Slide Surface CV 25.1 ("New Slide Command").
Inline: about 14 plain-text version notes converted to `.ver` tags (25.1: Tension ×2, Free, Adjacent ×2, Refit, Natural, Tab, surface CV ×2; 24.2: Match-CVs, Next, warning ×2, Explicit Control; 24.1: Join one sheet, Extend in Rebuild, nominal surface, Untrim holes, Extend Sheet to target). Existing `[25.2]`, `[25.3]`, `[26.2]` tags checked against the notes; all correct.

### Diagrams

None added, changed or removed. All five c07s-*.svg rendered and checked; they show only documented behaviour.

## Chapter 8 Face and edge commands
Files: `08-face-and-edge-commands.md` · old pages 87–92

### Corrections

- p87 / chapter intro – added one general confirm line pointing to *Confirming, cancelling and repeating commands* in chapter 3; removed the repeated "Confirm with OK… or right-click" step from every card (kept only Isoparam's "Confirm with right-click", which differs). "Flatten a face into a flat sheet" row → "Get a flat sheet from a face, as a reference for Deform". – plan 14.
- p87 / Offset Face (Push Face) – "the neighbouring faces stretch or shrink so the body stays closed" stated unconditionally, for solids and sheets → restricted to a successful edit of a solid; sheets explained separately (stay open, free boundary edges; how neighbours/open edges follow is undocumented, marked UNRESOLVED; command page does not mention sheets). "select faces of a solid or sheet" → "select one or more faces". – https://doc.plasticity.xyz/solid/offset-face; sheet part relabelled unresolved.
- p87 / Offset Face – auto-start note "(the docs date only the Move toggle, to 26.2)" removed → "controlled by Auto-invoke commands and Push-face under Preferences › Commands (both on by default)". – https://doc.plasticity.xyz/plasticity-essentials/preferences
- p88 / Offset Face Keys – Tab said "switches Grow mode… check which applies" → explicit [UNRESOLVED] documentation conflict (command page: Tab = Grow mode; 26.1 notes: Tab = gizmo distance entry for Push Face [26.1]), with a workaround (set Grow in the dialog, type Distance). Added Older versions (Tab gizmo entry added in 26.1; pre-26.1 Tab/Grow binding not documented) and Unresolved bullets. – https://doc.plasticity.xyz/solid/offset-face, https://doc.plasticity.xyz/release-notes/whats-new-2026.1 (Gizmo Distance Input table); migration guide https://doc.plasticity.xyz/migration-26.1 does not list Push Face.
- p88 / Offset Face Loop and Offset Edge – "Lock distances ([S]; [Tab] up to 25.3)" history inline → current key only in Options; history moved to "Older versions:" ("Up to 25.3 the default key for Lock distances was Tab; from 26.1 it is S"). – https://doc.plasticity.xyz/migration-26.1
- p89 / Offset Edge – gizmo "(24.2)" plain text → [24.2]{.ver}. – whats-new-2024.2 Minor Changes.
- p89 / Draft Face – Ctrl add/remove and gizmo reference-plane move tagged [24.2]{.ver}; tip "24.1 added a draft-angle analysis shader" → tagged [24.1]{.ver}; "official limitation" → "documented limitation". – whats-new-2024.2 "Draft Command", whats-new-2024.1.
- p90 / Delete Face – key attribute and keys used slash notation → "[Shift+X] or [Shift+Delete] or [Shift+Backspace]" (confirmed by Plasticity Essentials › General shortcut table); edge keys sourced to 2024.2 notes; "(24.2)" → [24.2]{.ver}; added Older versions: Rebuild Edge removed in 24.2, replaced by deleting edges. – https://doc.plasticity.xyz/plasticity-essentials/general, whats-new-2024.2 "Removed Commands". Note: the command page's own shortcut string "Shift + X / Delete / Backspace" is ambiguous; I followed the General table.
- p90 / Unwrap Face – "Flattens a face… so that geometry can be wrapped accurately" with no limits → creates a flat sheet from a face of a solid [24.2] for use as a Deform reference ("correctly mapped surface", quoted from the Deform pages); added "Not a manufacturing flat pattern" paragraph: docs do not state the mapping or promise lengths/angles/areas are preserved; developable vs doubly curved faces; Gaussian curvature / Theorema Egregium – doubly curved faces cannot be flattened keeping all lengths and angles; real flat-pattern tools distribute distortion and add allowances, docs do not describe Unwrap doing either. Added a tip to measure, and an Unresolved measurement exercise (only the arithmetic 2π×10/4 = 15.708 mm given). – https://doc.plasticity.xyz/solid/unwrap-face, https://doc.plasticity.xyz/solid/deform-solid-and-sheet, general theory.
- p90–91 / new `### Project, Imprint or Cut? {-}` subsection (before Imprint Curve-Body) – new diagram + 4-row table: Project = separate new curve, body unchanged; Imprint = new edges, same body, faces divided; Cut = cutting surface from the curve, body cut into pieces that are separate bodies; body-body variants (Project Body-Body curve, Imprint Body-Body edges, Cut with face cutter / Boolean). – https://doc.plasticity.xyz/sketch/project-curve-body, https://doc.plasticity.xyz/solid/imprint-curve-body, https://doc.plasticity.xyz/solid/cut, https://doc.plasticity.xyz/sketch/project-body-body, https://doc.plasticity.xyz/solid/imprint-body-body. "Separate bodies" for Cut matches chapter 7's c07-cut diagram; the Cut page itself only says "cut" (see Unresolved).
- p91 / Imprint Curve-Body – Tip now points to the comparison; Related adds Cut.
- p92 / Isoparam – slash notation "[Shift+Wheel up] / [Shift+Wheel down]" → "or" / separate key descriptions; Subdivide tag position kept [25.2]{.ver}.

### Version labels

All 10 card tags changed from `version=` to `documented=` (none of the release notes announce these commands as new):
- Offset Face (Push Face) 24.1 → documented 24.1 (24.1 notes add dependent offset to an existing command; inline [24.1]{.ver} for dependent offset kept).
- Offset Face Loop 25.1 → documented 26.1 (no release-note mention before the 26.1 migration guide).
- Offset Edge 24.2 → documented 24.2 (gizmo [24.2]{.ver}).
- Draft Face 24.2 → documented 24.2 (24.1 mentions only the draft-angle shader).
- Match Face 25.1 → documented 26.2 (no release-note mention).
- Delete Face 25.1 → documented 26.2 (faces never mentioned in notes; edge deletion [24.2]{.ver}).
- Unwrap Face 24.2 → documented 24.2 (24.2 "Improved features": "now generates a flat sheet…", tagged inline [24.2]{.ver}).
- Imprint Curve-Body 25.1 → documented 25.1 (25.1 notes list only tooltips).
- Imprint Body-Body 25.1 → documented 25.2 (first mention: 25.2 "Imprint and Project Body", multiple tools [25.2]{.ver}).
- Isoparam 25.1 → documented 25.2 (first mention: 25.2 Subdivide [25.2]{.ver}).
Inline tags added: [24.2]{.ver} ×4 (Offset Edge gizmo, Draft Ctrl, Draft gizmo, Unwrap), [24.1]{.ver} ×1 (Draft shader); kept [26.1] ×3, [25.2] ×2, [24.1] ×1.

### Diagrams

- Added figures/c08-project-imprint-cut.svg (3 panels, top view: Project = separate curve on unchanged box; Imprint = green edge dividing top face, one body; Cut = two separate pieces, drawn apart). Rendered and checked.
- Kept push-face.svg (side view of a solid; consistent with the restricted "successful solid edit" text), gap-fill.svg, draft-face.svg, imprint-projection.svg, isoparam.svg – unchanged, still correct.

## Chapter 9 Import, export and sharing
Files: `09-import-export-and-sharing.md` · old pages 93–100

### Corrections

- p93 / format table, SVG row — "stops that region being displayed" → "that region's overlay is not displayed" — import-export page.
- p93 / format table, STL row — added "Unit asked on import; unit override on export" — 24.1 and 26.1 release notes.
- p93 / Import / Append, Before you start — "XY, YX or XZ plane (as the official page lists them)" → "XY, YZ or XZ plane", with a note that the official page prints "YX" — importing-reference-images page (typo there) + general theory.
- p93–94 / Import / Append, Options (SVG) — added that the docs describe suppression of the region overlay, not missing curves — import-export page; curve completeness relabelled unresolved.
- p94 / Import / Append, Common problems (SVG) — removed "split it into several files" as a fix → reduce curves on that plane (delete unneeded paths, join segments); splitting stated as not guaranteed because files may land on the same plane; added "first check whether the curves are there" — general advice + relabelled unresolved.
- p94 / Import / Append, Options — new "STL units" bullet: STL has no standard encoded length unit (general file-format fact), hence the unit prompt — 24.1 release notes.
- p94 / Import / Append, Common problems (mesh size) — added round-factor hint (10/25.4/1000) — general theory.
- p94 / Import / Append — DXF/DWG Windows-vs-Linux history moved into `Older versions:` — 1.4 release notes vs import-export page.
- p94 / Import / Append — Parasolid instances sentence moved to `Unresolved:` — 24.2 release notes.
- p94 / Import / Append, Tips — added "measure a known dimension after STL import" — advice.
- p95 / Export, intro — "exports the selected objects, or all visible objects when nothing is selected" (stated for every format) → documented for OBJ only (export-obj page, 25.3 notes); other formats stated as undocumented, unresolved.
- p95 / Export, Options (STL) — added that the receiver must still use the same unit, since STL has no unit field — general file-format fact.
- p95 / Export, Common problems — selection problem now says "check selection and visibility, then re-import"; STL slicer line adds "check the slicer's import unit" — advice.
- p95 / Export, Tips — new pre-send checklist: selection, visibility, instances (Realize Instances), unit/up axis, round trip — advice; pointer to the new round-trip section.
- p95 / Export — new `Unresolved:` (STL default unit, STL/3MF tessellation settings, empty selection/hidden/instances for non-OBJ formats).
- p96 / Export OBJ, Max Width — added that Max Width is a size limit, distinct from the deviation tolerance (on flat faces any polygon size meets a deviation tolerance) — export-obj page + general theory.
- p96 / Export OBJ, Face Plane Tolerance — conflicting recommendation (high poly 0.0001 vs "below 0.001 decrease Max Width") now flagged `[UNRESOLVED]` with an amber note box after the card — export-obj page (conflict within docs).
- p96 / Export OBJ, Tips — "exports empties" → "exports mesh objects (notes call them 'empty meshes'; before 24.2 the Outliner listed meshes as empties)" — 2025.3 and 2024.2 release notes.
- p97 / Export OBJ, Tips — new tip: tessellation appearance (shading/normals) vs dimensional accuracy — general theory.
- p97 / Export OBJ, Tips — new tip: CAD surface U/V parameters vs production texture UV layout; docs do not describe the exported layout — general theory; layout relabelled unresolved.
- p96 / c09-obj-density.svg caption — "Face Plane Tolerance 0.0001" → "lower Face Plane Tolerance" (no longer shows a disputed value).
- p99–100 / Publish to Plasticity Share, intro — "cannot download or edit it" → the docs say the Plasticity Share viewer offers no download or editing; added paragraph distinguishing the published mesh from the original NURBS/CAD model — publish-to-plasticity-share page + general theory.
- p100 / Share, Tips — new: "no download" is viewer functionality, not data protection; mesh reaches the browser and may be captured (general web fact); old "Do not publish confidential designs" folded into this. New: thumbnail page shows the local folder path — share page.
- p100 / Share, Common problems — recipient wants file → send STEP/Parasolid for editable/exact geometry — advice.
- p100 / Share — new `Unresolved:` (what is uploaded: selection vs document; tessellation used; whether republish keeps the link).
- New section at chapter end `### Checking an export: a round-trip exercise {-}` — procedure only, no measured values; general expectations phrased qualitatively — advice/general theory.

### Version labels

- 3 card tags changed: Import / Append, Export, Export OBJ `version="1.3"` → `documented="1.3"` (1.3 notes mention STL import and parallel OBJ/STL export, not the commands as new).
- Kept: Export SVG `version="25.3"` (25.3: "now possible to export SVG"), Export Hidden Line `version="26.1"` (new command), Publish to Plasticity Share `version="25.3"` (new command).
- All inline tags checked against the notes and kept as `.ver` (each is an announced addition): 26.2 (.plasticity meshes/images/instances, Toggle Images/Meshes, mesh-snap wireframe), 25.1 (Recent Files drag, tooltips), 24.1 (unit prompt, file naming, Rhino 8, last file name, STEP dialog, matcap/wireframe, Inflexion), 24.2 (groups/names/materials, Outliner sections, STEP colours/assemblies, Parasolid, SVG import, 3MF, snapping, UV+MTL), 1.3 (STL import, Blender Bridge), 1.4 (FBX, Save As separate), 25.2 (Export STEP/SAT commands), 25.3 (OBJ options, export of meshes/instances), 26.1 (PolySplines, Scale/Up Axis, STL unit override).

### Diagrams

- Changed: `figures/c09-obj-density.svg` — high-poly caption "Face Plane Tolerance 0.0001" → "lower Face Plane Tolerance" (disputed value removed). Rendered and checked.
- Kept unchanged: `c09-hidden-line-types.svg`, `c09-hatching.svg` (checked in preview).
- None added or removed.

## Chapter 10 Practical workflows (new chapter)
Files: `09p-practical-workflows.md` · old pages new

### Corrections

(New chapter, so there are no old-page corrections. Sources used for each section:)

- 10.1 Direct modelling – the docs contain no "direct modeller" wording and no feature tree. The chapter says so and puts the history-based vs direct contrast in a paragraph labelled general information. Facts and sources: undo, redo and repeat (https://doc.plasticity.xyz/plasticity-essentials/general). Instances are read-only and the master's changes show in all instances; Realize breaks the link (https://doc.plasticity.xyz/solid/create-solid-and-sheet-instance). Constraints are Studio only, enforced during the session and not saved (https://doc.plasticity.xyz/plasticity-essentials/constraint-system; 26.2 notes). Autosave (24.2 notes), Backup (Preferences), file-tab backups and revert (26.2 notes), Quick save version (all-commands). .plasticity import of meshes, images and instances (26.2 notes).
- 10.2 First project – an 80 × 50 × 30 tray. Commands used: Corner Rectangle (Tab dimensions), region auto-starts Extrude, Fillet (Distance; Ctrl+click adds edges), Hollow (open hollow from a selected face; Thickness), Extrude with W Difference and S Lock distances, Alt+click edge loop, Measure Distance, Ctrl+S, Export. Sources: the official pages for each command, Object Types, Grid and Units, Selecting Objects and Fillet Order of Operations.
- 10.3 When geometry fails – red failure highlight for Boolean, Hollow and Thicken (26.2 notes); Loft red dot (25.2 notes). Join Sheets needs perfectly aligned edges; Find Boundary Edges note; Face direction shader; Max curvature mode for offset self-intersection (shader-mode page); about 700 curves per plane for regions (object-types, import-export); support Discord (support page). Moving the tool is presented as a diagnostic only. The repair is "make the tool overshoot, keep target dimensions, re-measure" ([ADVICE]).
- 10.4 Surface quality – continuity definitions (cad-essentials/continuity-curve-and-surface). Curvature comb (solid/toggle-surface-curvature; Comb scale default 0.1, autosize – plasticity-interface/curvature). Measure Continuity units, markers and Show maxes (tool/measure-continuity). Zebra and Isophote shaders, Curvature shader modes (shader-mode). "G0 allows but does not require a kink" is stated as general theory. The docs page itself says G0 = "sharp kink", so this needs aligning with chapter 4.
- 10.5 Compatibility – Licence and OS matrices from getting-started/download-and-install, getting-started/license-types-and-features, plasticity-essentials/import-export, preferences (SpaceMouse), blender/introduction-blender-bridge (Blender 4.1+, all three OSes) and the 1.4 notes. Anything not stated is "not documented". Prices are deliberately not reproduced; the chapter points to the licence page.

### Version labels

- New tags only: [24.2] autosave, [25.2] Measure Continuity and Loft red dot, [26.1] STL unit, [26.2] constraints, file-tab backups, .plasticity import, failure highlight and Curvature shader. All are `.ver` and are announced as new in those release notes.

### Diagrams

- None added. The tables and step lists were enough, and a failure flowchart would show no documented behaviour beyond the list.

## Application tests

### 10/11/2026 – Center Circle size input (Plasticity 25.1.9)

Test: new file, Length = Millimeter; Center Circle at the origin, [Tab], typed 10, confirmed; measured centre to rim.
Result: the inline input has **no label**; its guide line runs rim to rim through the centre; the measured radius is
**5.0 mm**, so the value is the **diameter**. Screenshots supplied by the maintainer. Tested in 25.1.9, which is
older than the reference version 26.2.0: tagged `[25.1.9]{.tested}`, and a re-check in 26.2.0 stays open in
`unresolved.md`. Two-Point and Three-Point Circle were not tested.

- Ch 4, Center Circle card, step 3 – "Read the label of the input box first: the docs do not say whether it is a
  radius or a diameter" → Center Circle takes the diameter, the input has no label; the other two variants are
  still unknown.
- Ch 4, Center Circle card, Common problems – "twice or half the expected size" → half the size: a radius was typed,
  type double the value.
- Ch 10, project step 5.1 – "check whether the field asks for radius or diameter" → type 10, the value is the diameter.
- `unresolved.md`: chapter 4 circle item narrowed to the 26.2.0 re-check and the two other variants; chapter 10
  item "10.2 Circle Tab field" removed.
