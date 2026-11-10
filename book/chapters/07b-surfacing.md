## Surfacing

The commands in this section confirm and cancel in the usual way (see *Confirming, cancelling and repeating commands* in chapter 3). The cards mention it only where a command behaves differently.

::: {.command name="Bridge Surface" documented="25.1"}
Creates a blend surface that connects two sheets, whether they are separated or intersect each other. The blend can be smooth (G2) or chamfered, and the surfaces behind the bridge (the "walls") can be trimmed away in the same step. Use it when you want a controlled transition between two surfaces without drawing the profiles yourself.

Before you start:

- You need two sheets. They can be apart, or they can cross each other.
- Bridge Surface has no default key: run it from the Command Palette or the Suggested Commands menu.

Step by step:

1. Run **Bridge Surface**.
2. Select the two sheets to connect.
3. In the command dialog, set **Width**, **Tension** and **Shape**, and choose how **Trim walls** should trim (see below).
4. Optionally press [A]{.key} to add a left/right wall pair.

**Intersecting surfaces:** run Bridge Surface, then select the first and the second surface. If the bridge runs the wrong way, switch **Sense 1** or **Sense 2** to flip its direction. The other options work as for separated surfaces.

Options explained:

- **Width** – the width of the bridge.
- **Tension** [25.1]{.ver} – how the curvature changes across the blend. The XNurbs page describes its own Tension as similar to the one in Loft and Bridge Surface.
- **Shape** – the profile of the bridge:
  - **G2** – the bridge is G2 (curvature) continuous with the surfaces it connects.
  - **Chamfer** – the bridge is chamfered instead of rounded.
- **Trim walls** – trims the surfaces behind the bridge:
  - **Both** – trims both sides of the bridge surface.
  - **Short** – trims the shorter side.
  - **Long** – trims the longer side.
  - **None** – nothing is trimmed.
- **Sense 1**, **Sense 2** (intersecting surfaces) – each reverses the direction of the bridge. The docs give the same description for both; try each and watch the preview.

Keys:

- [A]{.key} adds a left/right wall pair: an additional blend based on the current wall selections.

Common problems:

- The bridge runs the wrong way between two intersecting surfaces → switch **Sense 1** or **Sense 2**.
- Unwanted pieces of the walls remain, or too much is cut away → change **Trim walls**. The docs do not define which side counts as "short" or "long", so compare the options.

Tips:

- The official page links Bridge Surface to Join and Unjoin: use **Join Sheets** ([J]{.key}) to combine sheets whose edges match exactly, and **Unjoin** ([Alt+J]{.key}) to take them apart again.

Related:

Bridge Curve, Join Sheets, Unjoin Faces · Unjoin Shells, XNurbs, Loft.
:::

::: {.command name="Square" version="24.2" studio="true"}
Builds a four-sided (quad) surface from boundary edges, using the xNURBS solver. Unlike Patch or XNurbs, you set the surface's U and V degree and number of spans yourself, so you decide the CV layout. Square is also an alternative to Loft (two non-touching edges), Sweep (two or three touching edges) and Patch (a four-sided hole), and it can refit trimmed faces so that their spline flow follows the face.

![](book/figures/c07s-square-xnurbs.svg)

Before you start:

- Square needs a Studio licence.
- Select the boundary edges ([2]{.key} for Edge mode): four edges around a four-sided area, two non-touching edges for a loft, or two or three touching edges for a sweep-like surface.
- Square also accepts a sheet with a single rectangular face; in Sheet and Body selection mode it then applies **Refit Surface** automatically [26.2]{.ver}.
- Square has no default key: run it from the Command Palette or the Suggested Commands menu. As with XNurbs, you can also start Square first and then pick boundary edges, curves and surfaces one by one, with a live preview of the surface.

Step by step:

1. Select the boundary edges, or start Square first and pick them afterwards.
2. Type *Square* in the Command Palette and run it.
3. Set **Continuity**, **Degree** and **Spans**, then the other options in the command dialog.
4. Turn on **Analysis** to check the continuity at the edges before you confirm.

Options explained:

- **Continuity** – how the new surface meets the surfaces along its boundary:
  - **Free** [25.1]{.ver} – ignores boundary continuity for better surface quality; the 25.1 notes say it trades G0 (position) precision for quality, so the edges may no longer touch the boundary exactly. Meant for preliminary surfaces that you refine later.
  - **G0 / G1 / G2** – position, tangent or curvature continuity (see the continuity diagram under *NURBS in a nutshell* in chapter 1).
- **Flatness** – the docs say it affects the flatness and quality of the surface, as in XNurbs, and that higher values give higher-quality surfaces. They do not describe the geometric change or its cost.
- **Tension** [25.1]{.ver} – how the curvature changes across the surface. You can set a separate tension for each edge constraint [25.2]{.ver}; the docs do not show where.
- **Degree** – the U and V degree of the surface.
- **Spans** – the number of spans in U and V.
- **Boundary condition** – the direction of the UV flow (the surface's isocurves):
  - **Natural** – no requirement for the UV flow.
  - **Normal** – keeps the U and V isocurves perpendicular to each other.
  - **Next** – a perpendicular UV flow where the boundary conditions are relatively flat.
  - **Adjacent** [25.1]{.ver} – aligns the V isocurves with the adjacent curves, using adjacent trimmed edges for a smoother transition.
- **Weight** – a fitting weight: how strictly the solver applies the input constraints (the boundary curves and edges). A lower value loosens them, for better surface quality and reflections; a higher value enforces them, so the UV flow follows your Degree and Spans and the surface keeps the accuracy you asked for. Lowering it is therefore a trade-off: smoother reflections in exchange for a looser fit to the boundary. The docs do not say how far the edges may move; measure it (see Common problems). This is **not** the weight of a rational CV (see below).
- **Match-CVs** [24.2]{.ver} – an option for higher-quality surfaces, according to the 24.2 release notes. The current command page does not list it; check in your version.
- **Analysis** – checks the continuity at the surface edges: G0 (position), G1 (tangent), G2 (curvature).
- **Create Constraints** [26.2]{.ver} – keeps the new surface tied to its boundaries. Square remembers the last setting. **Constraints last only for the current session** (see the Constraint System note below).

**Fitting Weight versus CV weights.** In NURBS theory every CV has a weight: a CV with a higher weight pulls the surface more strongly towards itself, and rational (weighted) CVs let a surface describe exact circles and conics. Square's **Weight** is something else: a solver setting that balances the fit to the boundary against surface smoothness. The docs do not say whether Square's result is rational; the Selection panel shows whether a selected surface is rational or nominal [25.2]{.ver}.

Common problems:

- A selected sheet is not accepted → it must have a single rectangular face [26.2]{.ver}.
- Poor reflections or ripples → lowering **Weight** or using **Free** can help, but both loosen the fit to the boundary. Afterwards check the joins with **Analysis** or [Measure Continuity]{.cmd} (G0 deviation, G1 angle) and raise Weight again if the edges drift too far.
- The result has more or fewer CVs than you expected → check **Degree** and **Spans**. For a clamped B-spline with single knots, each direction has degree + spans CVs (for example degree 3 and 4 spans give 7), but count them in your result with Toggle Points.

Tips:

- **Loft with more control:** select two non-touching edges. Unlike a standard Loft, you can set degree, spans, boundary conditions, flatness and weight.
- **Sweep-like surfaces:** select two or three touching edges. The result is comparable to Sweep, with more control.
- **Fill a four-sided hole:** select its four boundary edges, as you would for Patch.
- **Refit a trimmed face** [25.1]{.ver}: Square can rebuild any four-sided trimmed surface with the Degree, Spans and Continuity you choose. It refits the face and its adjacent surfaces so that the spline orientation follows the natural flow of the surface. Rebuild Face does not align the spline orientation.
- Square (Refit) is one of the two documented ways to turn a face into a B-spline surface before Surface Align.
- To practise, work through *Exercise 1* after the Constraint System note.

Older versions:

- Before 26.2 a sheet was not valid input for Square and caused an error.

Related:

XNurbs, Patch, Loft, Sweep, Rebuild Face, Surface Align (Edge Align), Measure Continuity.
:::

::: {.command name="XNurbs" version="24.1" studio="true"}
Fills an area bounded by edges or curves with a surface, using the xNURBS solver. Unlike Square, the boundary can have any number of sides (N-sided), so XNurbs can bridge gaps and close complex holes; with four boundary edges it can also make an untrimmed quad-sided surface. Use it where Patch struggles with complex surfaces, or as a starting point that you refine later.

Before you start:

- XNurbs needs a Studio licence. The 24.1 release notes add that it is available only on PC and Mac.
- Select the boundary edges ([2]{.key} for Edge mode) or curves that frame the surface.
- XNurbs has no default key: run it from the Command Palette. You can also start it first and then pick boundary edges, curves and surfaces with a live preview (the Square page notes this works in both commands).

Step by step:

1. Select the boundary edges.
2. Run **XNurbs** from the Command Palette.
3. Set **Continuity** and, for a four-sided boundary, **Quad sided**; then the other options.
4. If a warning indicator appears, the inputs conflict [24.2]{.ver}: check the boundary and the options.

Options explained:

- **Continuity** – G0, G1 or G2 with the surrounding surfaces.
- **Quad sided** – creates an untrimmed quad-sided spline surface inside a four-edged boundary, with the correct spline orientation.
- **Flatness** – the docs say it adjusts the flatness and quality of the surface and that higher values give higher-quality surfaces; they do not describe the geometric trade-off. With **Quad sided** on a four-sided area, the docs give 0.95 to 1.00 for optimum results.
- **Tension** [25.1]{.ver} – the curvature strength, when **Quad sided** is on. 0.1 gives a more relaxed surface; 1.0 tightens the transition towards the centre of the blend. The default is 0.5. The docs call it similar to Tension in Loft and Bridge Surface.
- **Boundary** – the UV flow:
  - **Natural** – no requirement for the UV flow.
  - **Normal** – keeps the U and V isocurves perpendicular.
  - **Next** [24.2]{.ver} – a perpendicular UV flow where the boundary is relatively flat; needs **Quad sided**.
  - **Adjacent** [25.1]{.ver} – aligns the V isocurves with the adjacent curves; needs **Quad sided** (with Quad sided off, the result is similar to **Normal**).
- **Quality** – **Auto** (default), **High** or **Max**. Higher settings give higher quality but create more splines, so the surface is heavier to edit.
- **Satisfy tolerances** – the tolerance of the generated surface; on by default. The docs recommend the default tolerance values for general surfacing.

Common problems:

- A warning indicator appears [24.2]{.ver} → the inputs conflict. Check the boundary edges and curves.
- The surface quality is low → with Quad sided, keep **Flatness** within 0.95 to 1.00, or set **Quality** to High or Max (at the cost of more splines).
- The result is poor even though XNurbs filled the gap → XNurbs can bridge gaps even with bad inputs, but a high-quality surface still needs proper boundaries and continuity settings.

Tips:

- **Profile guides:** unlike Loft and Patch, XNurbs can use open profile guides that do not touch the boundary, to shape the surface more freely.
- For a four-sided area where you want to set the degree and spans yourself, use Square. *Exercise 1* compares the two on the same opening.

Related:

Square, Patch, Loft, Rebuild Face, Raise Surface Degree.
:::

::: {.command name="Surface Align (Edge Align)" version="25.2" studio="true"}
Reshapes a sheet so that one of its edges (the target) meets the edge of another surface (the reference) with G0, G1 or G2 continuity. It is the surface mode of the **Edge Align** command, called Align until 26.2: with two surface edges selected, Edge Align runs Surface Align; with two vertices or curves it runs Vertex Align. It is built on xNURBS, and you can rebuild the target's degree and spans while you align.

![](book/figures/c07s-surface-align.svg)

Before you start:

- Surface Align needs a Studio licence.
- The docs say surfaces must be B-spline surfaces to use Align effectively. If needed, convert them first with Rebuild Face (Explicit Control) or Square (Refit).
- Select the **target** edge (the one that moves) first, then the **reference** edge. You do not need to click the exact edge: in Face, or Sheet and Solid, selection mode you can click anywhere near the boundary edges of the two sheets and they are paired correctly [26.2]{.ver}.
- Edge Align has no default key: run it from the Command Palette.

Step by step:

1. Select the target edge, then the reference edge.
2. Type *Edge Align* in the Command Palette and run it. With two surface edges selected, Surface Align runs.
3. Choose the **Solver** and the **Continuity**. To set the continuity individually, click the black circles on the surface; [Tab]{.key} cycles the continuity.
4. Adjust blending, partial alignment ([P]{.key}) and boundary ([B]{.key}) as needed.
5. Hold [Ctrl]{.key} to compare with the original, or turn on **Analysis** to check the continuity.
6. Optionally turn on **Create Constraints** ([C]{.key}) [26.2]{.ver}.

Options explained:

- **Solver**:
  - **XNurbs** – uses the xNURBS solver.
  - **Collinear** [26.2]{.ver} – a solver for Class A style modelling. It adjusts the CV hulls of both surfaces to form a clean, organised grid along the shared boundary edge.
- **Continuity** – G0, G1 or G2, for the whole edge or individually via the black circles.
- **Blending**:
  - **Blend extra rows** – how many rows of CVs blend into the alignment. 0 means no blending; higher values blend more rows for a smoother connection. A value as high as the total number of rows makes the whole surface adjust.
  - **Input shape influence** – how much the original shape affects the result. Only takes effect when **Blend extra rows** is used.
- **Tension** – how the curvature changes across the surface.
- **Partial Alignment** – **Partial start** and **Partial end** set how much of the surface's start and end blend with the target. A sliding gizmo along the edge sets how far the alignment extends, and [P]{.key} toggles partial alignment [26.2]{.ver}.
- **Boundary** – the condition of the UV flow:
  - **Natural**, **Normal**, **Next**, **Adjacent** – as in Square (no requirement / perpendicular isocurves / perpendicular flow where flat / V isocurves follow adjacent curves).
  - **Skew** [26.2]{.ver} – in an expandable section; tilts the boundary edges of the result. Set the skew angle with the gizmo handles in the viewport or with the **Start** and **End** values. Needs at least G1 continuity.
- **Surface Rebuild** – **Degree** and **Spans** (U and V) of the target, for a better alignment.
- **Symmetry** [26.2]{.ver} – how the two surfaces influence each other:
  - **Symmetric** – both surfaces adjust towards each other. CVs on each side move so the shared edge stays collinear and the G1 row stays tangent on both sides.
  - **Asymmetric** (default) – only the driven (target) surface adjusts; the reference stays unchanged.
  - **Match tangent length ratio** – the driven surface takes on the tangent length ratio of the reference, so its CV spacing follows the same proportions.
  - The 26.2 release notes present Symmetric and Asymmetric as part of the Collinear solver.
- **Analysis** – temporarily analyses the continuity of the selected edges (G0, G1, G2).
  - **G0 Scale / G1 Scale / G2 Scale** – the Edge Align page says they "adjust tolerance scales for respective continuity checks". The Measure Continuity page and the 25.3 notes describe the G0/G1/G2 Scale controls in the Curvature panel only as the visual size of the combs and deviation plots. Whether these fields change the pass/fail tolerance or only the display is not documented.
- **Create Constraints** [26.2]{.ver} – keeps the chosen continuity afterwards and lets you adjust it later. **Constraints last only for the current session** (see the Constraint System note below).

Keys:

- [Tab]{.key} cycles the continuity; hold [Ctrl]{.key} to show the original.
- [P]{.key} toggles partial alignment; [B]{.key} toggles boundary alignment (the command page: boundary skew start and end); [C]{.key} toggles constraint creation [26.2]{.ver}.

Common problems:

The alignment fails or looks wrong. A non-B-spline surface is the documented cause, but not the only possible one. Check these in turn:

- One of the surfaces is not a B-spline (for example an analytic plane or cylinder) → rebuild it with Rebuild Face (Explicit Control) or Square (Refit) first. The Selection panel helps you see what kind of surface you have.
- The wrong edge is picked where two sheets are already joined → the official page points to the Selection Context Menu: hold [Ctrl+Shift]{.key} and click to open a menu that lets you choose among overlapping objects.
- **Skew** has no effect → it needs at least G1 continuity.
- The reference surface changes too → **Symmetry** is set to Symmetric; choose Asymmetric.
- The target cannot follow the reference smoothly, or the change is squeezed into the edge rows → [ADVICE]{.advice} raise the target's **Degree** or **Spans** under **Surface Rebuild**, or raise **Blend extra rows**. The docs say only that these options help the alignment, not when it fails.
- The target is trimmed → [ADVICE]{.advice} Project Align documents that its target must be untrimmed and single-patch; the Surface Align page does not say this, but an untrimmed, single-patch target (Untrim, Rebuild Face) removes one more variable.

Tips:

- Raise **Blend extra rows** when the change should spread further into the target, so the transition is smoother.
- *Exercise 2* after the Constraint System note shows a G0 pass with a G1 failure, and the fix.

Related:

Vertex Align (Edge Align), Project Align, Square, Rebuild Face, Measure Continuity; *Surface quality* (chapter 10).
:::

::: {.command name="Project Align" version="26.2" studio="true"}
Aligns the CVs along an edge of a target surface to a reference surface, by projecting them along a direction you set: a vector or the surface normal. With the default Constrained solver the CVs move only along that direction, CV movement is kept to a minimum, and the result updates in real time as you change the direction.

![](book/figures/c07s-project-align.svg)

Before you start:

- Project Align needs a Studio licence.
- The **target** surface must be untrimmed, a single patch and a B-spline. Otherwise the command will not work as expected.
- Optionally prepare a **reference curve** to guide the alignment. The XNurbs solver needs one.
- Project Align has no default key: run it from the Command Palette. It then asks for the selections.

Step by step:

1. Type *Project Align* in the Command Palette and run it.
2. Select the target edge to align.
3. Select the reference surface to align to. Optionally select a reference curve.
4. Set the projection direction with the gizmo handles, or press [S]{.key} to set it in screen space.
5. Set the options in the command dialog.

A small icon near the alignment handle shows the type of operation and the continuity in use. Project Align always creates a constraint; click the icon once to change its continuity and behaviour. **The constraint lasts only for the current session** (see the Constraint System note below).

Options explained:

- **Solver**:
  - **Constrained** (default) – faster, and needs no reference curve. CVs move only along the projection direction, so their movement is kept small; the tolerances are looser.
  - **XNurbs** – the most accurate, with tighter tolerances, but it can move CVs more dramatically. Needs a reference curve.
- **Continuity** – G0, G1 or G2, for the whole edge or per point by clicking the black circles on the surface.
- **Perpendicular** – makes the surface perpendicular to the reference: the first row of CVs points straight up from the reference surface, and the rest of the surface adjusts to stay smooth.
- **Blend extra rows** – the docs describe it as controlling how the new surface blends at its start and end. In Surface Align the same option sets how many CV rows are blended.
- **Projection**:
  - **Normal** – projects along the target surface's normal direction.
  - **Vector** – projects along a direction you set with the gizmo.

Keys:

- [S]{.key} sets the direction in screen space; hold [Ctrl]{.key} to show the original; [Tab]{.key} cycles the continuity.

Common problems:

- The result is wrong or nothing happens → the target is trimmed, has several patches or is not a B-spline.
- The XNurbs solver gives no result → it needs a reference curve.
- CVs move more than you want → use the Constrained solver.

Related:

Surface Align (Edge Align), Vertex Align (Edge Align), Untrim, Rebuild Face.
:::

::: {.note title="Constraint System (Studio only)"}
[26.2]{.ver} [STUDIO]{.studio} **Constraints are not saved with the file. In 26.2 they are active only during the current session.** The docs and the 26.2 release notes both state this.

A constraint keeps a surface or curve tied to the command that shaped it. The commands build a network of relationships between the geometry: constraints stay enforced automatically as you transform the geometry, so connected objects update together.

**Constraint versus geometry.** Two things persist differently. The *geometry* a constrained command produced (the aligned sheet, the bridge curve) is ordinary geometry in your model. The *constraint* (the live link that re-solves it when you move its neighbours) is what is not saved. The docs do not describe what you see after reopening; expect the shape as you saved it but no live link. Treat constraints as a modelling aid within one session, not as a parametric history.

**Which commands create constraints**

- **Surfaces:** Square and Surface Align offer **Create Constraints** as an option; Project Align creates constraints automatically. Constraint Options: continuity (G0, G1, G2 or Free), partial alignment, boundary and analysis settings.
- **Curves:** Vertex Align, Bridge Curve, Bridge Vertex and Bridge Edge offer **Create Constraints**. Constraint Options: continuity G0 to G3.
- Square and the three Bridge curve commands remember the last Create Constraints setting.

**Working with constraints**

1. In the command dialog, turn on **Create Constraints** (in Edge Align also [C]{.key}) and confirm the command. Project Align does this for you.
2. The constraint appears as an icon in the viewport.
3. Move or reshape the connected geometry: the constraint keeps the continuity you chose.
4. To change it, click the icon once. The **Constraint Options** menu opens with the settings listed above.
5. **Select All Constraints** (Command Palette) selects every constraint in the scene; **Viewport: Toggle Constraints** shows or hides them.

**Before you close the file:** get the shape right while the session is open. When you reopen the file, re-run the command with **Create Constraints** on if you need the live link again.
:::

### Surfacing exercises {-}

These exercises are procedures to try in your own copy of Plasticity (Studio). They give no expected values: the manual has not measured them. Write down what you see in the tables, and change one setting at a time so that you can tell what caused each difference.

**Exercise 1 – Square and XNurbs on the same opening**

1. Create a box ([Corner · Center · Three-Point Box]{.cmd}). In Face mode ([3]{.key}) delete its top face with [Delete Face]{.cmd}: the box becomes a sheet with a four-sided opening.
2. In Body mode ([4]{.key}) select the sheet and run [Find Boundary Edges]{.cmd}. The four edges around the opening are selected.
3. Run [Square]{.cmd}. Set **Continuity** to G0, then choose a **Degree** and **Spans** in U and V and note them. Turn on **Analysis** and note the marker on each edge.
4. Switch **Continuity** to G1, then change only **Weight** down and up. Note the markers and how the preview changes. Confirm with the Weight you prefer.
5. Turn on [Toggle Points]{.cmd} and count the CVs in U and V. Compare with degree + spans (see Square, Common problems).
6. Select the box sheet and the new surface and run [Join Sheets]{.cmd} ([J]{.key}). Note whether the result is a solid or still a sheet.
7. Run [Measure Continuity]{.cmd} on one edge pair between a side and the new surface, with **Show maxes** on. Note the G0 deviation and the G1 angle.
8. Switch to a zebra shader (Horizontal or Vertical Zebra Reflection) and note whether the stripes run on across the edge or break.
9. Undo back to step 2 and run [XNurbs]{.cmd} instead, with **Quad sided** on, **Flatness** between 0.95 and 1.00 and the same continuity. Repeat steps 5 to 8.

| What to record | Square | XNurbs |
|---|---|---|
| Continuity, Degree, Spans, Weight / Flatness used | | |
| Analysis markers (four edges) | | |
| CVs in U × V | | |
| G0 deviation and G1 angle (one edge) | | |
| Zebra stripes across the edge | | |
| Join Sheets result: solid or sheet | | |

**Exercise 2 – Edge Align: G0 passes, G1 fails, then fix it**

1. Create a box and run [Unjoin Faces · Unjoin Shells]{.cmd} on it in Body mode ([Alt+J]{.key}): every face becomes its own sheet. Keep the top face and one side face; hide or delete the others.
2. Select the two touching edges and run [Measure Continuity]{.cmd} with **Show maxes** on. Note the G0 result, then press [Tab]{.key} for G1 and note the angle. The faces are perpendicular, so by geometry you should see a pass at G0 and an angle of about 90 degrees, a failure, at G1.
3. Select the side face's edge (target) and then the top face's edge (reference) and run **Edge Align** with **Continuity** G1. Box faces are planes, not B-spline surfaces; note what happens.
4. Cancel. Rebuild the side face with [Rebuild Face]{.cmd} (**Explicit control**; note the Degree and Spans), or refit it with Square.
5. Run Edge Align again: G1, **Symmetry** Asymmetric, **Blend extra rows** 0. Note the markers in **Analysis**. Then raise Blend extra rows and compare the shape and the zebra stripes.
6. Confirm and run Measure Continuity again. Note the G0 deviation and G1 angle, then run Join Sheets and note the result.

| What to record | Before (step 2) | Edge Align on planes (step 3) | After rebuild (steps 5 and 6) |
|---|---|---|---|
| G0 deviation and marker | | | |
| G1 angle and marker | | | |
| Target Degree and Spans, CVs in U × V | | | |
| Blend extra rows used, zebra stripes | | | |
| Join Sheets result | | | |

::: {.command name="Extend Sheet" documented="24.1"}
Extends one or more outside (boundary) edges of a sheet by a distance, so the surface grows past its current edge. You choose the shape of the extension, and you can extend the sheet up to a target body. Use it to overbuild a surface so that it can be trimmed or intersected cleanly later.

![](book/figures/c07s-extend-sheet.svg)

Before you start:

- Edge mode ([2]{.key}). Select one or more outside edges of a sheet.
- Selecting an outside edge starts the default command, **Extend**, automatically. Extend is a unified command: with curves selected it runs Extend Curve, with outside edges of a sheet it runs Extend Sheet. It is also in the Suggested Commands menu.

Step by step:

1. Select the outside edges. Extend starts and a yellow dot appears.
2. Drag the yellow dot to set the distance, or press [D]{.key}; type an exact value in the **Distance** field.
3. Choose the **Shape** ([Tab]{.key} cycles through them) and the other options.

Options explained:

- **Shape** – the shape and curvature of the extension:
  - **Natural** [25.1]{.ver} – continues the curvature that the surface has near the boundary edge.
  - **Linear** – continues in a straight line from the boundary edge, keeping the tangent direction.
  - **Soft** – blends the extension smoothly with the surface, keeping tangent and curvature continuity (G2).
  - **Reflective** – mirrors the surface's curvature and tangency across the boundary; useful for keeping two surfaces symmetrical.
- **Distance** – how far the edges are extended.
- **Limit** [25.2]{.ver} – extends the sheet towards a target body, until it reaches the inside or outside of the body:
  - **Minimal** – the sheet reaches the target's outer boundary.
  - **Outside** – the sheet reaches the target's inner boundary.
  - **Inside** – the sheet reaches the target's outer boundary; if the sheet is partly inside the body, the inside intersection is ignored and only the outside part is affected.
  - These are the official descriptions, but they are hard to tell apart (and *Outside* is said to reach the *inner* boundary). The docs also do not say how to pick the target body. Check the preview.
- **Modify** – when on, the result is a single sheet. The docs do not describe the result with Modify off. Natural and skew extensions of an untrimmed sheet also offer modify / unmodify; with modify, a surface line marks where the new surface begins [26.2]{.ver}. The command page does not describe a skew extension.

Keys:

- [D]{.key} distance; [Tab]{.key} cycles the Shape options [25.1]{.ver}.

Common problems:

- Extend does not start → the edge is not an outside edge of a sheet.
- The extension bends the wrong way → try another **Shape**: Linear for a straight continuation, Natural or Soft to follow the curvature.

Tips:

- Extend Sheet can extend a sheet up to, and intersecting, a target body [24.1]{.ver}. A sheet that fully reaches a body is a cleaner tool for cutting or trimming than one that stops just short of it.

Related:

Extend Curve, Untrim, Rebuild Face, Cut.
:::

::: {.command name="Join Sheets" key="[J]{.key}" documented="24.1"}
Joins sheets with matching edges into one body. If the joined sheets enclose a volume, the result is a solid. Use it after building a shape from separate surfaces, for example after Bridge Surface, Square or XNurbs.

Before you start:

- Body mode ([4]{.key}). Select the sheets to join.
- The edges must be perfectly aligned.
- [J]{.key} is a unified Join key: with curves selected it runs Join Curves, with sheets it runs Join Sheets. It is also in the Suggested Commands menu.

Step by step:

1. Select the sheets. You can also select just one: Join Sheets then asks for the second sheet [24.1]{.ver}.
2. Press [J]{.key}. The sheets are joined.

You can also join several sheets in the Outliner: select them there and press [J]{.key}.

Common problems:

- The sheets do not join → their edges do not line up exactly. Close the gap first, then try again. After Square with **Free** continuity or a low **Weight**, the edges may have moved off the boundary: check the G0 deviation with Measure Continuity.
- The result is a sheet, not a solid → some edges are still unconnected. **Find Boundary Edges** shows them.

Related:

Unjoin Faces · Unjoin Shells, Find Boundary Edges, Bridge Surface, Join Curves; *When geometry fails* (chapter 10).
:::

::: {.command name="Unjoin Faces · Unjoin Shells" key="[Alt+J]{.key}" documented="1.3"}
Separates faces into sheets. **Unjoin Faces** separates the selected faces from a solid or sheet. **Unjoin Shells** separates every face of the selected solids or sheets into individual faces. Unjoin Faces works on several bodies at once [25.2]{.ver}.

Before you start:

- For Unjoin Faces: Face mode ([3]{.key}), select the faces. For Unjoin Shells: Body mode ([4]{.key}), select the solids or sheets.
- [Alt+J]{.key} is a unified Unjoin key: curves → Unjoin Curves, faces → Unjoin Faces, solids or sheets → Unjoin Shells. It is also in the Suggested Commands menu.

Step by step:

1. Select the faces, or the bodies.
2. Press [Alt+J]{.key}. The faces or bodies are separated.

Older versions:

- The 1.3 release notes say Explode was renamed to Unjoin in that version.

Related:

Join Sheets, Delete Face, Bridge Surface, Unjoin Curves.
:::

::: {.command name="Untrim" key="[Alt+T]{.key}" documented="24.1"}
Creates a new sheet from the full underlying surface of a face: the original shape of the surface before its edges trimmed it. Use it when you want to rework a surface, reuse it as a tool, or need an untrimmed surface for a command such as Project Align. Untrim can also create holes instead of only duplicating [24.1]{.ver}; the release note does not explain this further.

![](book/figures/c07s-untrim.svg)

Before you start:

- Face mode ([3]{.key}). Select the face to untrim.
- Untrim is also in the Suggested Commands menu.

Step by step:

1. Select the face.
2. Press [Alt+T]{.key}.
3. A sheet based on the original shape of the surface is created. Press [Tab]{.key} or use **Keep edges** in the command dialog to keep the trimmed outline as edges.

Options explained:

- **Keep edges** [25.2]{.ver} – inserts imprinted lines on the new sheet that preserve the edges of the trimmed face.

Keys:

- [Tab]{.key} toggles **Keep edges**.

Tips:

- **Keep edges** is useful when you rework the full surface but still need the old outline, for example to trim or split it again later.

Related:

Extend Sheet, Rebuild Face, Project Align, Imprint Curve-Body.
:::

::: {.command name="Find Boundary Edges" documented="26.2"}
Selects the boundary edges of an opening in a sheet: the edges that are not connected to another face. Unconnected edges are one of the reasons a model is not a solid when you expect it to be, and this command finds them for you.

Before you start:

- Body mode ([4]{.key}). Select the sheet.
- Find Boundary Edges has no default key: run it from the Command Palette or the Suggested Commands menu.

Step by step:

1. Select the sheet.
2. Type *Find Boundary Edges* in the Command Palette and click it.
3. The edges around the opening are selected.

Common problems:

- Join Sheets gives a sheet instead of a solid → run Find Boundary Edges to see which edges are still open.

Tips:

- With the boundary edges selected, **Patch** can close the opening, or Square and XNurbs (see *Exercise 1*).

Related:

Patch, Join Sheets, Delete Face; *When geometry fails* (chapter 10).
:::

::: {.command name="Deform (Solid and Sheet)" version="24.2"}
Wraps solids and sheets onto a regular or irregular surface, for example a pattern or a logo onto a curved face. You choose a reference (the neutral plane the objects sit on now) and a target (where they should go). Reference and target can be faces or curves; a curve target needs a curve reference [26.2]{.ver}. The options are the same as in Deform Curve, plus **Reblend**, which recalculates fillets.

Before you start:

- Select the solids or sheets to wrap.
- You need a **reference**: a face, best a flat sheet made with Unwrap Face, or a curve, best a straight line.
- You need a **target**: a face, or a curve when the reference is a curve.
- Deform has no default key: type *Deform* in the Command Palette.

Step by step:

1. Select the objects to wrap.
2. Type *Deform* in the Command Palette and run it.
3. Select the reference face or curve.
4. Select the target face, or a target curve if the reference is a curve.
5. Set the options in the command dialog.

Options explained:

- **Scale** – scale in U, V and N.
- **Offset** – offset in U, V and N. Scale and Offset use the UVN coordinate system of the target surface instead of XYZ, so you set the orientation of the objects at a point relative to that surface.
- **Flip**:
  - **Mirror** – mirrors the deformed objects horizontally relative to the surface.
  - **UV** – swaps the U and V orientation of the deformed objects.
  - **Normal** – flips the normal of the deformed objects.
- **Reblend** – recalculates the fillets of the objects and applies them again, removing unwanted deformations.
- **Keep Tools** – deforms while keeping the tool objects intact.

Common problems:

- The objects land in the wrong place or are distorted → use **Unwrap Face** on the target face and use the flat result as the reference face. This gives a correctly mapped reference, but only on open surfaces, not periodic (closed) ones.
- Bad results on a closed surface such as a full cylinder → the wrapped geometry meets itself and causes joining and continuity problems. Split the surface, or the object being wrapped, first.
- Fillets look stretched → turn on **Reblend**.
- A curve reference gives unwanted deformation or errors → make the reference curve a straight line.

Older versions:

- Before 26.2 reference and target had to be faces.

Related:

Unwrap Face, Deform Curve, Copy / Paste with Placement.
:::

::: {.command name="Raise Surface Degree" key="[Shift+S]{.key}" version="24.1"}
Converts analytic surfaces (exact shapes such as planes and cylinders) to spline surfaces and adds degree and CVs, so you can reshape a face by moving its surface CVs. The palette and the Suggested Commands menu call it *Raise Degree*. It also runs when a surface CV is selected [25.1]{.ver}.

Before you start:

- Select a face or a solid, or a surface CV [25.1]{.ver}.

Step by step:

1. Select the face or solid.
2. Press [Shift+S]{.key}. The surface gets more CVs.
3. Edit the surface by moving or sliding its CVs.

Common problems:

- The surface has too many CVs → simplify it with **Rebuild Face**.

Tips:

- To hide the surface CVs again, use **Toggle Points** from the Command Palette.
- To select a whole row of CVs, press [Alt]{.key}.
- Faces with visible CVs get a nominal surface that makes direct editing easier [24.1]{.ver}; see Remove Nominal Surface.

Related:

Rebuild Face, Remove Nominal Surface, Slide Surface CV, Toggle Points, Raise Curve Degree.
:::

::: {.command name="Rebuild Face" version="24.1"}
Rebuilds the surface of a face with a new spline layout: spline count, degree, spans and CV layout. Use it to simplify a surface with too many CVs, to overbuild a surface with **Extend** [24.1]{.ver}, or to turn a face into a B-spline for Surface Align. **Explicit Control** (degree and spans) is Studio-only [24.2]{.ver}.

Before you start:

- Face mode ([3]{.key}). Select the face or faces.
- The command is called *Rebuild*: run it from the Command Palette or the Suggested Commands menu.

Step by step:

1. Select the faces.
2. Run **Rebuild** from the Command Palette.
3. Choose the **Method** and set its values.

Options explained:

- **Method**:
  - **Explicit control** (Studio only) – **Degree** (U and V), **Spans** (U and V), **Extend** (U and V) and **Shrink**.
  - **Tolerance** – **Tolerance**, **Extend** and **Shrink**.
- **Tolerance** – sets how many surface CVs the rebuilt surface gets: a lower value gives many CVs, a higher value fewer. The docs say this determines the output quality. In general, more CVs can follow the original shape more closely but make the surface heavier to edit and smooth; fewer CVs are lighter but may drift from the original.
- **Extend** – extends the surface in U and V, so it is larger than the face (overbuilding).
- **Shrink** – pulls rows and columns of CVs that stick out in closer to the boundary edges of the trimmed surface.

Tips:

- Rebuild does not align the spline orientation with the face. To refit a four-sided face so its splines follow the surface flow, use **Square** (Refit).
- After **Remove Nominal Surface**, use Rebuild to remove spans you do not need.
- Rebuild Face has no fitting **Weight** option; that option belongs to Square (surfaces) and Rebuild Curve (curves).

Related:

Square, Raise Surface Degree, Remove Nominal Surface, Rebuild Curve.
:::

::: {.command name="Reverse Sheet" version="24.2"}
Flips the normal direction of a sheet, so its front and back swap. It works on several sheets at once [25.2]{.ver}. The effect is easiest to see with the Face direction shader or in Blender (see Tips).

Before you start:

- Body mode ([4]{.key}). Select the sheet or sheets.
- The command is called *Reverse*: with curves selected it reverses the curve direction (Reverse Curve), with sheets it reverses the normal. It is in the Command Palette and the Suggested Commands menu.

Step by step:

1. Select the sheets.
2. Type *Reverse* in the Command Palette and run it.
3. The normal direction of the sheets is reversed.

Tips:

- Pair it with the Face direction shader (Normal Checker) [25.2]{.ver}: surfaces facing outward are shown blue, inward red.
- The official page also suggests the Blender Bridge add-on, with its live link, to see the effect.

Related:

Reverse Curve, Join Sheets.
:::

::: {.command name="Remove Nominal Surface" version="24.1"}
When a face shows its surface CVs (for example after Raise Surface Degree), it gets a nominal surface: extra spans, generated and kept hidden, that heal holes in the surface so that direct editing stays easy. Remove Nominal Surface acts on those hidden spans. The official sources disagree on what exactly it does to them.

Before you start:

- Select a face.
- Run *Remove Nominal Surface* from the Command Palette.
- The 24.1 release notes say it only applies after you have raised the surface degree (Raise Surface Degree); from 26.2 it also works on PolySpline faces (below).
- The Selection panel shows whether the selected surface is rational or nominal [25.2]{.ver}. Check it before and after.
- On a PolySpline face the command removes the PolySpline CVs, baking the surface. This is destructive, so check the selection first [26.2]{.ver}.

Step by step:

1. Select the face.
2. Run **Remove Nominal Surface** from the Command Palette.

Common problems:

- PolySpline CVs have gone → the command was run on a PolySpline face, which bakes the surface. Undo ([Ctrl+Z]{.key}) straight away if that was not intended.

Tips:

- Follow with Rebuild (Rebuild Face) to remove spans you do not need.

Related:

Raise Surface Degree, Rebuild Face, PolySplines.
:::

::: {.command name="Slide Surface CV" key="[Shift+G]{.key}" version="25.1"}
Slides surface CVs along the hull direction (the tangent of the CV hull), so the surface keeps its flow while the points move. With several CVs you can move their neighbours proportionally for smooth transitions, and mirror the slide across the active construction plane. The palette calls it *Slide*.

Before you start:

- Control Point mode ([1]{.key}). Select one or more CVs on a surface.
- To pick a whole CV row first, hold [Alt]{.key} over the hull [25.2]{.ver}.
- [Shift+G]{.key} is a unified Slide key: CVs on curves → Slide Curve CV, CVs on solids → Slide Surface CV.

Step by step:

1. Select the CVs.
2. Press [Shift+G]{.key}. Gizmo handles with direction controls appear.
3. Drag a handle, or use the keys below to slide along U, V or the normal.
4. Type an exact **Distance** if needed, and set the **Advanced** options.
5. Hold [Ctrl]{.key} to switch between the preview and the original, to compare.

Options explained:

- **Distance** – how far the CVs move.
- **Advanced**:
  - **Proportional** [26.2]{.ver} – how the slide affects the surrounding CVs:
    - **None** – no influence on the surrounding CVs.
    - **All** – all surrounding CVs move proportionally, according to **Falloff U** and **Falloff V**.
    - **Selected** – only the selected CVs are affected; the last selected CV carries the Slide gizmo handle.
  - **Falloff U / Falloff V** [26.2]{.ver} – how far the effect reaches in the U and V directions.
  - **Mirror** – mirrors the slide relative to the active construction plane (the global one or a custom one): **None**, or **X**, **Y** or **Z**.
- Sliding CVs on several surfaces at once harmonises their UV directions [26.2]{.ver}.

Keys:

- [U]{.key} slides in positive U and [Shift+U]{.key} in negative U; [V]{.key} slides in positive V and [Shift+V]{.key} in negative V; [N]{.key} slides along the normal.
- Hold [Ctrl]{.key} to compare with the original; [Ctrl+Z]{.key} undoes the last step.

Tips:

- Toggle Curvature gives live feedback while you work with Slide, which makes it easier to optimise the curvature of the surface [25.3]{.ver}.

Older versions:

- Toggle Curvature was called Measure Curvature before 25.3.

Related:

Slide Curve CV, Raise Surface Degree, Move, Toggle Curvature (Measure Curvature).
:::
