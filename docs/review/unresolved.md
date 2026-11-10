# Unresolved items

Claims the official sources do not settle, or that the plan asks to verify in the application. Each item says
what is unknown and the test that would settle it. Run every test in **Plasticity 26.2.0**, record the build, the
exact field labels and the measured values, then update the card (use `[26.2.0]{.tested}` / `tested="26.2.0"`)
and remove the item here. Until then the manual must not be described as fully verified.

## Whole book

- **Delete vs Dissolve on X** — the official shortcut list gives X to both Delete and Dissolve. Test: select a face of a box and a group in turn, press X, and record whether the result is Delete (removed with contents) or Dissolve.
- **Push Face and Tab** — the command page says Tab switches Grow mode; the 26.1 notes say Tab types an exact gizmo distance. Test: select a face, let Push Face start, press Tab, record what happens.
- **Ordinary add/remove/replace selection in the viewport** — not documented. Test: with no command running, click with Shift, Ctrl and Ctrl+Shift held on a second object; record the result.
- **Application screenshots** (plan §14) — none could be made; screenshots are needed wherever an Unresolved item concerns interaction or option behaviour. Use your own screenshots, not images from the official docs.
- **Verified compatibility matrix** (plan §14) — chapter 10 lists only what the official pages state; versions, licences and operating systems still need checking against the installers.

## Chapter 1 Core concepts and entities

- NURBS / Insert Knot, Raise Degree – do they keep the shape exactly? – docs say only that CVs (and maybe spans) are added – Test (26.2.0): draw a Spline Curve with 5 CVs; Duplicate it; run Raise Degree ([Shift+S]) on the copy and, on a second copy, Insert Knot at mid-length; with Toggle Curvature on both, compare combs and use Measure Distance between matching snap points (e.g. Middle, 1/4) of original and copy; record the distances shown.
- Origin and orientation – where the origin and in-plane X/Y axes of a plane made from a face, region or points go – not documented – Test: box 40×20×10 mm off the world origin; select top face, [Shift+Space]; record where the grid centre/axis lines appear (face centre, a vertex, projection of world origin) and the X-axis direction relative to the longest edge; repeat with 3 selected points and with a region.
- Drawing on the plane / 2D Snapping off – does a snapped off-plane point keep its 3D position? – not documented per tool – Test: XY plane active, 2D Snapping off; box with top at Z = 10 mm; draw a Line from a grid point to the box's top corner (End snap); select the line's end vertex and read its Z in the Selection panel / Measure Distance; repeat with 2D Snapping on.
- What Ctrl does – object snapping and grid snapping both on, holding Ctrl while dragging an object – which rule wins – Test: Grid size 10 mm, Snap to grid on, object snaps on; drag a box with the Move gizmo holding [Ctrl] near another box's vertex; record whether the move snaps to the vertex, to the grid, or both.
- Grid and units – does changing **Length** rescale existing geometry? – not documented – Test: Length = Millimeter, Corner Box 10×10×10 mm; switch Length to Centimeter; Measure Distance one edge; record value (1 cm = display only; 10 cm = rescaled); switch back and measure again.
- Checking imported dimensions – how STEP and other CAD formats bring in units – not documented – Test: export a 100 mm cube as STEP from Plasticity with Length = mm; new file with Length = Inch; import; Measure Distance one edge; record value and whether any unit prompt appears.
- Exercise / Saving planes – are saved construction planes stored in the .plasticity file? – not documented – Test: create, save and rename a custom plane; Ctrl+S; close and reopen; record whether it is listed under Planes and in Added Planes.
- Exercise step 2 / Rotate – unit of the Angle field – Rotate page does not name it – Test: Rotate a box, Axis X, type 30; check with Measure Distance (angle between two edges in the Measurements panel) whether it is 30°.
- Applying materials / Cleaning up the list – does a material leave **Used Materials** once no object references it (after Remove Material [Alt+M] or reassigning) without deleting objects? – Materials page says only "after every object that references them has been deleted" – Test: two boxes; Set Material red on box A; note Used Materials; Remove Material on A; record whether red is still listed; repeat by assigning blue to A instead; then repeat after saving and reopening the file.

## Chapter 2–3 Navigation, interface, files; selection and editing

- ch3 Viewport, command and Outliner selection — what a plain click does to an existing viewport selection (add or replace) and which modifier adds/removes — Selecting Objects page silent — build 26.2.0: select a box (Body mode), click a second box; record whether the first stays selected; repeat with Shift+click, Ctrl+click, Ctrl+Shift+click (expect context menu) on a selected and an unselected box; also Shift/Ctrl while box-dragging.
- ch3 Outliner selection — remove/replace modifiers, range selection — only "hold Shift while selecting" (Rename section) is documented — 26.2.0: in the Outliner click Box.000, then Shift+click, Ctrl+click Cylinder.000, and Ctrl+click a selected item; record the resulting selection in the viewport.
- ch1/ch3 command selection — whether "Ctrl+click adds/removes" applies to "most commands" (chapter 1 says so) — documented only for Fillet Shell; Loft, Sweep, Draft Face use Shift/Ctrl — 26.2.0: in Extrude, Offset Face, Move with a selection, try Shift+click and Ctrl+click on another face/object; record whether it is added/removed.
- ch3 Confirming… — how to cancel a running command without applying it — docs silent — 26.2.0: start Extrude on a region, drag, press Esc; record whether the extrusion is discarded and whether the selection remains; repeat with right-click before any drag, and with Box tool mid-drag.
- ch3 Confirming… — Esc in other commands and in Place with an unconfirmed copy — docs silent — 26.2.0: Place (Ctrl+D) a box, confirm one copy, move to a second destination, press Esc; count the boxes in the Outliner.
- ch3 Delete or Dissolve — Dissolve (X) on faces vs Delete Face; body type after deleting a face of a solid — docs silent — 26.2.0: Box, Face mode, select top face, press X; undo; press Shift+X; record the Outliner section (Solids/Sheets) and whether the face is gone in each case.
- ch3 Delete or Dissolve — nested groups: do children go to the parent on Dissolve and on Delete (24.2 note vs General Functions) — 26.2.0: group A containing group B with two boxes; select B, press X; undo; press Shift+Backspace; record where the boxes are in the Outliner.
- ch3 Delete or Dissolve — key conflicts: All Commands lists X for Delete; Delete Face page "Shift + X / Delete / Backspace" (Delete/Backspace without Shift?) — 26.2.0: Command Palette, search Delete, Dissolve, Delete Face; record the bindings shown; test plain Delete key on a selected face.
- ch3 Delete or Dissolve — edge deletion keys/results (24.2: X, Shift+X, Delete, Shift+Delete) — 26.2.0: Box, split a face with Imprint/line, select the new edge, press X; record whether the edge is removed and faces merge; repeat with Shift+X.
- ch2 Recovering a backup — backup file names, format, whether Open reads them, retention; autosave location and relation to backups — docs silent — 26.2.0: enable autosave (1 min), edit an unsaved and a saved document, wait; list files in the documented folder for the OS and via file tab › browse backups; record names/extensions; open one with Ctrl+O and record whether it loads.

## Chapter 4 Sketching and primitive tools

- Center Circle – **settled in 25.1.9** (diameter, unlabelled input; see corrections log, 10/11/2026). Still open: (a) confirm in 26.2.0 – 26.1 changed Tab and inline inputs in several tools – Center Circle, Tab, type 10, Measure Radius, record R; (b) Two-Point and Three-Point Circle – is the Tab value a radius or a diameter? – type 10 in each, confirm, run Measure Radius, and record the input label and the R value.
- Tangent Circle – field labelled "Radius", described as "Specify the diameter" – test: two parallel lines 20 apart, Tangent Circle on both, type 10. Record whether a circle is created, the field label, and the Measure Radius R value.
- Spiral – field "Radius", described as diameter, [R] "diameter" – test: spiral along Z, Radius 10, then Measure Distance along X between the two points of one turn farthest apart. Record the label and the distance (10 means a diameter, 20 a radius).
- Spiral – what Pitch means (rise per turn?), and which value changes when Turns changes – test: 5 turns, axis 10. Record Pitch and Angle, set Turns to 10, and record what changes.
- Sphere – field "Radius", described as diameter – test: Radius 10, then Dimension or Measure Distance top to bottom. Record the label and the size across.
- Cylinder – EN says diameter, DE/JA say radius – test: Radius 10, Height 20, then Measure Radius on the top edge. Record the label and the R value.
- Measure Distance – does a single edge or curve report the end-point distance or the arc length? – test: Center-Point Arc R 10, 90°. Measure it and compare with the chord 14.142 and the arc length 15.708.
- Measure Distance – how the second point is picked in the two-point case – test: click two box corners and record the click or key sequence.
- Measure Continuity – the tolerance values, and whether G0/G1/G2 Scale (Curvature panel) or Surface Align's Analysis G0/G1/G2 Scale changes pass or fail – test: on a G1 joint with a small deviation, record the value and marker, change G1 Scale ×10, record again, then repeat in Surface Align › Analysis.
- G0-pass/G1-fail exercise – does Unjoin Faces on a box give two pieces that Measure Continuity accepts? Record the G0 and G1 values, the markers, the effect of the scale, and screenshots of the combs and zebra stripes.

## Chapter 5 Common commands (curves and bodies)

- Mirror – Union halves + Make instances – docs silent – 26.2.0: 10 mm box touching the YZ plane, Mirror in X with both on; record object count in Outliner, whether new half has grey instance edges; push one face of the original 5 mm and record whether the other half follows.
- Mirror – Cut down mirror plane, which piece is mirrored – docs silent – box −5…+15 mm in X, Mirror in X with option on; record the X extent of the result.
- Duplicate – name/material inheritance – not on Duplicate page – name a box, give it a material, Shift+D, confirm; record copy's name and material dot in Outliner.
- Alternative Duplicate – degenerate projections – docs silent – line along Z and circle in the XZ plane, Alt+D onto XY plane; record error / point / line / nothing.
- Array counts (all three) – "number of duplications" does not say whether the original counts – Rectangular: 10 mm box at origin, Spacing, Distance 1 = 20 mm along X, Number = 3; then Extent 100 mm, Number = 5; then direction 2, Repeat = 2; record Outliner object count and X of last copy. Curve Array: 5 mm sphere at the start of a 100 mm line, Number = 3, Ratio 1.00; record count and each copy's pivot X. Radial: 10 mm box 50 mm from origin, Total 360°, Number 2 = 4; record count and neighbour angle (and whether the last copy lands on the original).
- Radial Array – Number 1 / Step 1 – page does not explain them – same radial set-up, then Number 1 = 2, Step 1 = 20; record where new items appear (ring / radial / axial), unit shown next to Step 1, object count.
- Assets – whether changes to the pack reach placed assets, whether Reload Asset picks up a re-exported pack, and whether placed assets are instance objects – undocumented – mark a box as asset, export pack, place it twice; edit the source and re-export; run Reload Asset on one; record which copies change and whether placed copies show instance (grey) edges.
- Remove Material – whether removing all references (no deletion) removes the material from Used Materials – docs only cover deletion – two boxes with a new material; Alt+M on both; record whether listed; save/reopen and record; delete boxes and record.
- Subdivide curves – exact CV count, degree change, shape change – docs say "doubled" only – Rebuild Curve, Explicit Control, Degree 3, Spans 1 (4 CVs); Subdivide once and twice; count CVs in Control Point mode; record whether the shape moved.
- Subdivide surfaces – doubling vs "one more" (page contradicts itself) – Rebuild Face degree 3, 1 span U and V (4 × 4 CVs); Subdivide once and twice; record CV counts in U and V and degree/spans if shown.
- (carried over) Place on instances: 26.1 notes "face and edge snaps only" vs 26.2 "all snap points" – stated as documented change, no test added.

## Chapter 6 Curve (sketch) commands

- Join Curves – maximum end-point gap that still joins – docs say only "perfectly aligned" – 26.2.0: lines with gaps of 0.1, 0.01, 0.001 and 0.0001 mm; press J; record which join (blue-green) and which stay purple.
- Insert Knot – exact shape preservation and the new CV's position – docs silent – 26.2.0: 4-CV spline, duplicate it, insert near the middle on the copy; compare by overlay or Measure Distance; record the CV count and the new and moved CV positions.
- Offset Region – which Individual state gives separate regions – docs say "on = combined", which contradicts the name – 26.2.0: two 10 mm squares 2 mm apart, offset 2 mm outwards; record the number of resulting regions with Individual off and on.
- Region checklist – effect of duplicate or overlapping segments and of self-intersections on region forming; whether a joined curve counts as one toward the ~700 limit – undocumented – 26.2.0: draw a square with one side doubled, and a figure-8 curve; record the regions shown. Fill a plane with about 700 joined and unjoined curves and record when regions disappear.
- Extend Curve – continuity at the join for each Shape; Soft compared with Natural and Reflective – docs give only wording – 26.2.0: extend one spline end by 20 mm with each shape; record the G level (Measure Continuity) and any jump in the comb. A tested illustration (plan §8) needs this.
- Fillet Curve – drag direction for fillet versus chamfer – docs silent – 26.2.0: L of two 20 mm lines, drag inwards and outwards; record which gives the arc.
- Bridge Vertex – what L does – only one docs page lists it, and L is Loft elsewhere – 26.2.0: two vertices selected, press L; record the command dialog name.
- Bridge Edge – former Side 1/Side 2 options – no source – record the dialog labels in 25.3 and 26.2.0.
- Vertex Align – G3 for curves (page says G0–G2, notes say G0–G3) – 26.2.0: Tab through the continuity values; record them. Polyline rigid behaviour (unpublished note) – align a 3-segment polyline to a spline; record the length and shape change and the continuity values offered.

## Chapter 7.1–7.3 Solids, Booleans and fillets

- Extrude – which side of the profile the Thickness wall goes – not documented – 26.2.0: extrude a 20 × 20 mm square region 10 mm with Thickness 2; Measure Distance across the outer faces; record 20/22/24 mm.
- Revolve – Normal/Binormal/Tangent options – named in the description but not explained – 26.2.0: revolve a region and look for these labels in the dialog; record the label and its effect.
- Loft – seam alignment and start point for closed profiles – not documented (the section is commented out of the source) – 26.2.0: circle r20 + 30 × 30 Center Rectangle 40 mm above; loft, then rotate the rectangle 45° and loft again, then loft with a snapped guide; record seam position and twist yes/no for each.
- Sweep – Parallel vs Normal on an asymmetric profile – only one-line wording – 26.2.0: L-shaped region 10 × 10 mm (leg 2 mm) at the start of a planar 90° arc; sweep with each Alignment; record whether the section turns with the path and which side of the bend the long leg ends up on.
- Pipe – whether Diameter is outer or inner with Thickness set, and wall direction – not documented – 26.2.0: 50 mm line, Vertex count 0, Diameter 10, Thickness 1; Measure Radius on the outer and inner faces.
- Thicken – per-side vs total wall; total with Lock distances – docs give per-side values only – 26.2.0: flat 50 × 50 mm sheet, Thickness 1 and 2; again with Lock distances at 2; Measure Distance between the faces (expect a sum if per side; record the actual value).
- Thicken – which value is the sheet's normal side – not documented – repeat after Reverse Sheet; record whether the sides swap.
- Hollow – wall inside or outside the original faces – not documented – 26.2.0: 20 mm cube, hollow the top face with Thickness 2; record the outer and inner sizes (Measure Distance).
- Hollow – Local when on – only "disable when hollowing a Solid" – repeat the test with Local on/off; record the difference.
- Boolean – disconnected/touching/edge-touching/tangent inputs – not documented – 26.2.0: two 10 mm cubes (a) 5 mm apart (b) sharing a face (c) sharing an edge, (d) 10 mm cylinder lying on a cube face; run Union/Difference/Intersect/Slice; record success, body count in the outliner, red highlight.
- Cut – Extend key E (Cut page) vs Tab (Cut Curve page) – docs conflict – 26.2.0: Cut with a short curve cutter, press E then Tab, record which toggles Extend; repeat in Cut Curve.
- Fillet Shell – which shapes give a constant-radius circular section; effect of Tension – not documented – 26.2.0: 20 mm cube, one 90° edge, Distance 2 with Conic (default Tension), Conic (other Tension), Chordal, G2; record the Measure Radius readout on the fillet face (or "none").

## Chapter 7.4 Surfacing

- Square / XNurbs Flatness – what it changes geometrically and what it costs – docs say only "higher = higher quality" – 26.2.0: fill the same four-sided opening twice changing only Flatness; record CV count (Toggle Points), G0 deviation and G1 angle from Measure Continuity (Show maxes) on one edge, zebra appearance; field label "Flatness".
- Square Weight – how far the edges move as Weight falls – not documented – 26.2.0: same opening, change only "Weight"; record the value and the G0 deviation on each edge.
- Surface Align Analysis "G0 Scale / G1 Scale / G2 Scale" – tolerance vs display – Edge Align page says "tolerance scales", Measure Continuity page and 25.3 notes say visual comb/deviation-plot scale – 26.2.0: align two sheets at G1, Analysis on, note markers, multiply "G1 Scale" by 10; record whether markers change (tolerance) or only comb size (display).
- Constraint System – state after save and reopen – docs say only that constraints are not saved – 26.2.0: Edge Align at G1 with Create Constraints on, record G0/G1 from Measure Continuity, save/close/reopen; record whether values are unchanged, whether Select All Constraints selects anything, whether moving the reference still updates the target.
- Remove Nominal Surface – reveals or removes hidden spans – command page vs 24.1 notes (two wordings) – 26.2.0: box, Raise Surface Degree on one face, Toggle Points, count CVs U×V and Selection panel status (rational/nominal); run the command; recount, status, Measure Continuity on one edge before/after, zebra comparison.
- Exercise 1 and Exercise 2 – all recorded values (markers, CV counts, G0 deviation, G1 angle, zebra, join result) – no application available – run the procedures in 26.2.0 and fill the tables; Exercise 2 step 3 also records what Edge Align does on planar (non-B-spline) faces.
- Surface Align – whether a trimmed target or too few spans cause failure (labelled ADVICE) – not documented for Surface Align – 26.2.0: align a trimmed vs an untrimmed target, and Spans 1 vs 4, record success/markers.

## Chapter 8 Face and edge commands

- Offset Face (Push Face) – what Tab does – command page says Grow mode, 26.1 notes say gizmo distance entry – test in 26.2.0: select top face of a box so Push Face starts, press Tab, record whether the **Grow** field changes or a distance entry opens; if distance entry, record the key shown for Grow in the running command's key list.
- Offset Face – behaviour on sheets and on failure – command page does not mention sheets or failure – test in 26.2.0: box with one face deleted (open sheet), push a side face ±5 mm, record how neighbouring faces and the open boundary follow; also push a face until it would self-intersect and record whether the command errors, refuses, or produces an invalid body.
- Unwrap Face – whether lengths are preserved – mapping undocumented – test in 26.2.0: 90° segment of a cylinder r = 10 mm, h = 20 mm; unwrap; measure flat sheet edges against 15.708 mm and 20 mm; repeat on a sphere patch and record edge lengths and area.
- Project/Imprint/Cut comparison – Cut "pieces are separate bodies" – Cut page says only "cut"; consistent with chapter 7 – test in 26.2.0: box 40×20×10, curve fully across top face, Cut [C], record the number of objects in the Outliner.
- Delete Face – exact binding string on command page ("Shift + X / Delete / Backspace") vs General table – used General table; test: select a face, press plain Delete, record whether the face is removed.

## Chapter 9 Import, export and sharing

- Import / Append — SVG over 700 curves per plane: curves all imported, only overlay suppressed? Does moving curves to another plane restore regions? — docs mention only the overlay. Test 26.2.0: import SVG with >700 closed paths on one plane; count curves in Outliner; note region display; move half to a parallel plane; note regions.
- Import / Append — Parasolid instances still unsupported? — only 24.2 notes mention it. Test: import .x_t with instanced parts; check Outliner for instances vs separate bodies.
- Import / Append — DXF/DWG on Linux — 1.4 notes say Windows+Linux, current page Windows only. Test on Linux 26.2.0 Studio: is DXF/DWG offered in the import dialog.
- Export — STL default unit when not overridden — undocumented. Test: export a 100 mm cube, override untouched; read an ASCII vertex or import with a known unit; record the vertex value and the unit field shown in the STL dialog.
- Export — STL/3MF tessellation source — undocumented. Test: export the same cylinder as OBJ at two Density values and as STL/3MF; compare triangle counts.
- Export — empty selection, hidden objects, unrealised instances for STEP/Parasolid/STL/3MF/IGES/SAT — undocumented. Test: document with selected, unselected-visible, hidden body and an unrealised instance; export each format with and without selection; re-import; count bodies.
- Export OBJ — Face Plane Tolerance conflict (0.0001 recommended vs "below 0.001 decrease Max Width") — docs conflict. Test: same filleted part at (a) FPT 0.0001 default Max Width, (b) FPT 0.001 with Max Width reduced to similar polygon count; record polygon counts and maximum deviation from the CAD surface (inspection tool).
- Export OBJ — exported UV layout (per-face, overlapping, packed?) — undocumented. Test: export box with filleted edge, open in a UV editor, record overlap and scale of islands.
- Publish to Plasticity Share — selection vs whole document uploaded — docs say ".plasticity file" and "mesh only" and "select the object". Test: publish with one of two bodies selected; record what the viewer shows.
- Publish to Plasticity Share — tessellation settings for the published mesh — undocumented. Test: publish a sphere, inspect wireframe in viewer.
- Publish to Plasticity Share — republishing keeps the same URL? — undocumented. Test: publish, edit, publish again, compare URLs and the revision indicator.
- Round-trip section — all measured values (dimensions, hole diameters, polygon counts for STEP/STL/OBJ) — no application available; procedure given as an exercise.

## Chapter 10 Practical workflows (new chapter)

- 10.1 Curves – does a body update when its source curve is edited after Extrude? Not documented. Test (26.2.0): extrude a rectangle region by 30, move one curve CV, and record whether the body changes.
- 10.1 Persistence – are measurements (Measure Distance, Continuity, Curvature entries in the Outliner) saved in the .plasticity file? Test: create one of each, save, reopen, and check the Outliner › Measurements.
- 10.2 Hollow direction – is the wall added inside or outside the selected solid's faces? Test: Hollow an 80 × 50 × 30 box (top face selected, Thickness 2), then measure the outer length (80 or 84).
- 10.4 Acceptance tolerances behind the Measure Continuity markers are undocumented. G0/G1/G2 Scale conflicts: the Measure Continuity page says "visual scale of combs and deviation plots"; Edge Align says "tolerance scales for respective continuity checks". Test: Pair A (two extruded lines at 30°) and Pair B (Conic vs G2 fillet on a box). Record the deviation and marker per level, change G1 Scale and G2 Scale to two values, and record whether any marker changes.
- 10.4 Does Measure Continuity accept the single shared edge of a solid, or does it need two sheet edges? Test: run it on a filleted box edge without unjoining, and record whether it is accepted.
- 10.4 Exercise expected results (Pair A G0 pass/G1 fail; Conic G1 pass/G2 fail; G2 fillet G2 pass) are theory only; record the actual values and markers.
- 10.5 DXF/DWG import on Linux – the 1.4 notes say "Windows and Linux"; the import-export page says "Windows only". Test: Studio 26.2.0 on Linux, import a 2D DXF.
- 10.5 Trial terms (duration, commercial use, export limits, Stable/Beta) and minimum OS versions are not in the docs snapshot.

