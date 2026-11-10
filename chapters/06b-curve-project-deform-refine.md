## Project, deform and refine

::: {.command name="Project (unified)" key="[I]{.key}" documented="26.2"}
[I]{.key} is one key for three projection tools. Plasticity looks at the selection and runs the matching tool: two curves → Project Curve-Curve; two bodies (solids or sheets) → Project Body-Body; otherwise Project Curve-Body. All three create a new curve.

Before you start:

- Select the objects for the tool you want:
  - two curves → **Project Curve-Curve**;
  - two solids or sheets → **Project Body-Body**;
  - anything else, for example one solid or sheet → **Project Curve-Body**.

Step by step:

1. Select the objects.
2. Press [I]{.key}, or click the Project button in the Suggested Commands menu.
3. Carry on as described on the card of the tool that runs.

Tips:

- The unified Imprint key [Shift+I]{.key} works the same way, but it splits the faces of the body (new edges) instead of creating separate curves. See Imprint Curve-Body and Imprint Body-Body.

Related:

Project Curve-Body, Project Body-Body · Project Curve-Curve, Imprint Curve-Body.
:::

::: {.command name="Project Curve-Body" key="[I]{.key}" documented="25.1"}
Creates a new curve by projecting a curve onto a solid or sheet. The new curve lies on the faces of the body; the faces themselves are not split. Use it when you need a curve that follows the surface of a body, for example as a path or boundary for later modelling. If you want new edges on the body instead, use Imprint Curve-Body.

Before you start:

- You need the curve and the solid or sheet to project onto.
- Place the curve so that it faces the body in the projection direction. With **Method: Normal** the projection runs along the positive Z axis of the construction plane.
- With one body selected, the unified Project key [I]{.key} runs Project Curve-Body. The command is also in the Suggested Commands menu.

Step by step:

1. Select the target solid or sheet.
2. Press [I]{.key}, or click the Project button in the Suggested Commands menu.
3. Click the curve to project.
4. Set the options in the command dialog, or press [S]{.key} for Screen space. Confirm.

Options explained:

- **Method** – the projection direction:
  - **Normal** – projects along the positive Z axis of the construction plane (the CPlane's Z).
  - **Vector** – projects in one straight (linear) direction and makes **Bidirectional** and **Hide occluded** available. The docs do not say how the direction is chosen; check the preview.
- **Bidirectional** – also projects in the negative direction of the axis, so faces on both sides of the curve get a curve.
- **Hide occluded** – skips hidden faces: nothing is projected onto faces that lie behind other faces in the positive direction of the axis. The command page also calls it *Hide occlusion*; it is the same option.
- **Screen space** ([S]{.key}) – projects the curve using the current camera view.

The options work like those of Imprint Curve-Body, whose diagram shows Bidirectional and Hide occlusion side by side.

Keys:

- [I]{.key} start; [S]{.key} Screen space.

Common problems:

- No curve appears → with Method Normal the projection only goes in the positive Z direction of the construction plane. Move the curve to the other side of the body, change the construction plane, or use Vector with Bidirectional.
- Curves also appear on faces at the back of the body → set Method to Vector and turn on **Hide occluded**.
- Bidirectional and Hide occluded cannot be set → they are only available with Method Vector.

Tips:

- For Screen space, orbit to the view you want to project from before you press [S]{.key}.

Related:

Project (unified), Imprint Curve-Body, Project Body-Body · Project Curve-Curve, Project Outline · Create Outline · Duplicate Curve and Project, Alternative Duplicate.
:::

::: {.command name="Project Body-Body · Project Curve-Curve" key="[I]{.key}" documented="25.2"}
Two projection tools that build a curve from an intersection.

**Project Body-Body** creates a new curve along the line where two solids or sheets intersect. It can also handle several tool bodies at once, instead of only pairs [25.2]{.ver}.

**Project Curve-Curve** creates a new curve from the intersection of the surfaces implied by two curves. According to the docs, the projection "follows the normal behaviour of each input curve", so each curve acts like a surface extruded along its normal. The result inherits the shape of both curves, which makes it a quick way to build a 3D curve from two views: draw one curve as seen from above and the other as seen from the front.

![](figures/c06p-project-curve-curve.svg)

Before you start:

- **Project Body-Body:** two solids or sheets that actually intersect.
- **Project Curve-Curve:** two curves, each drawn in the view whose direction it should keep, for example one on the Top plane and one on the Front plane.
- With two bodies or two curves selected, the unified Project key [I]{.key} runs the matching tool. Both are also in the Suggested Commands menu.

Step by step:

**Project Body-Body:**

1. Select the two solids or sheets.
2. Press [I]{.key}, or click the Project button in the Suggested Commands menu.
3. The intersection curve is created.

**Project Curve-Curve:**

1. Select the two curves.
2. Press [I]{.key}, or click the Project button.
3. The projected intersection curve is created.

Keys:

- [I]{.key} runs either tool, depending on the selection.

Common problems:

- Project Body-Body creates nothing → the bodies must intersect; there is no intersection line otherwise.
- Project Curve-Curve gives an unexpected result or an error → according to the docs this is often because the normal direction is not set correctly. Extrude each curve yourself along its intended direction, then imprint the line where the two extrusions meet with **Imprint Body-Body**. The docs say this is usually more reliable in complex cases.

Tips:

- **Project Body-Body** on the two extrusions gives the same line as a separate curve rather than as edges on a body.
- Keep the two source curves until you are happy with the 3D curve. You can adjust them and project again.
- Several tool bodies [25.2]{.ver}: the docs do not say how to select the target and the tool bodies when there are more than two, so check the result.

Related:

Project (unified), Project Curve-Body, Imprint Body-Body, Extrude.
:::

::: {.command name="Project Outline · Create Outline · Duplicate Curve and Project" key="[Alt+D]{.key} (via Alternative Duplicate)" version="1.3"}
Three tools that make new curves by projecting along the normal of the active construction plane (CPlane):

- **Project Outline** projects the outline (silhouette) of solids or sheets onto the CPlane. The result is flat (2D) curves on the plane, for example a footprint or a side profile.
- **Create Outline** finds the outline in the same way but creates a 3D curve: the curves sit exactly on the object's original boundary instead of being flattened onto the plane. It is in the Command Palette only – [Alt+D]{.key} does not run it.
- **Duplicate Curve and Project** copies curves or edges and projects the copies onto the CPlane, so you get a flat copy of a 3D curve. It works the same as Alternative Duplicate on curves.

Project Outline and Create Outline are new in 1.3 (the card's label). Alternative Duplicate, the [Alt+D]{.key} command, is first mentioned in the 24.2 release notes [24.2]{.doc}; Duplicate Curve and Project is in no release notes [26.2]{.doc}.

![](figures/c06p-outline.svg)

Before you start:

- Set the construction plane to project onto. All three tools project along its normal, so the plane decides the direction as well as where the flat results end up.
- Select solids or sheets for Project Outline and Create Outline; curves or edges for Duplicate Curve and Project.
- [Alt+D]{.key} runs Alternative Duplicate, which picks the tool from the selection: solids or sheets → Project Outline; curves or edges → Duplicate Curve and Project.

Step by step:

1. Set the construction plane.
2. Select the objects.
3. Run the tool:
   - Project Outline or Duplicate Curve and Project: press [Alt+D]{.key}, or type *Alternative Duplicate* in the Command Palette.
   - Create Outline: type *Create Outline* in the Command Palette.
4. The new curves are created. If needed, drag the Move gizmo to move them, then confirm.

Keys:

- [Alt+D]{.key} Alternative Duplicate: Project Outline (solids, sheets) or Duplicate Curve and Project (curves, edges).

Common problems:

- You wanted the outline on the object, not flat on the plane → run Create Outline from the Command Palette. [Alt+D]{.key} on a body always gives Project Outline's flat curves.
- The curves are on the wrong plane, or the outline is not the view you wanted → set the construction plane first; the projection follows its normal.
- [Alt+D]{.key} copied faces out as a new body → faces were selected. With faces, Alternative Duplicate copies them instead of projecting (see Alternative Duplicate). Select the whole solid or sheet in Body mode ([4]{.key}).

Tips:

- Project Outline gives a quick footprint that you can extrude, or offset with Offset Curve to add an even margin.
- Duplicate Curve and Project is a quick way to turn a 3D curve or an edge into a flat sketch that you can trim and extrude.

Related:

Alternative Duplicate, Project Curve-Body, Offset Curve, Project Body-Body · Project Curve-Curve.
:::

::: {.command name="Deform Curve" version="24.2"}
Wraps curves onto another surface. You pick a **reference** and a **target**: the curves are mapped from the reference onto the target, so a design drawn flat ends up following a curved face. The docs suggest it for engraving paths, parting lines and guide curves. The reference and the target can also be curves [26.2]{.ver}.

![](figures/c06p-deform-curve.svg)

Before you start:

- You need the curves to wrap, a **reference** (a face, or a curve [26.2]{.ver}) and a **target** (a face, or a curve [26.2]{.ver}). A curve target needs a curve reference.
- Deform has no default key. Type *Deform* in the Command Palette: with curves selected, the unified Deform command runs Deform Curve; with solids or sheets it runs Deform (Solid and Sheet).
- For accurate placement on a curved face, make the reference with Unwrap Face first (see below).

Step by step:

1. Select the curves you want to wrap.
2. Type *Deform* in the Command Palette and run it.
3. Select the reference: a face, or a curve [26.2]{.ver}. For a reference curve the docs advise a straight line, to avoid unwanted deformation and errors later on.
4. Select the target: a face, or a curve [26.2]{.ver}. A curve target is only possible when the reference is a curve.
5. Set Scale, Offset, Flip and Keep Tools in the command dialog, then confirm.

**Accurate wrapping with Unwrap Face:** run Unwrap Face (palette: *Unwrap*) on the target face. It creates a correctly mapped flat sheet. Place the curves on that sheet, then use it as the reference face in Deform.

Options explained:

- **Scale** – scales the result in **U**, **V** and **N**.
- **Offset** – moves the result in **U**, **V** and **N**.
- Scale and Offset use the surface's UVN coordinate system, not XYZ: U and V run along the surface, N is the surface normal.
- **Flip**:
  - **Mirror** – mirrors the deformed curves in the Z axis. The docs do not say whether this is the world Z axis or the surface's own.
  - **UV** – flips the U and V orientation of the deformed curves.
  - **Normal** – flips the normal of the deformed curves.
- **Keep Tools** – deforms while keeping the tool objects intact. The docs do not say which objects count as tools here; check the result.

Common problems:

- A curve cannot be picked as the target → a curve target only works with a curve reference [26.2]{.ver}.
- The curves come out distorted, or the command fails, with a curve reference → make the reference curve a straight line.
- The curves do not land where you expected on the target → build the reference with Unwrap Face, so that it is correctly mapped.
- Bad results on a closed face such as a full cylinder → for solids and sheets, the Deform (Solid and Sheet) page says unwrapping works on open, non-periodic surfaces, and that closed surfaces should be fragmented or the wrapped object split first. The docs do not say the same for curves, so check in your version.

Tips:

- An Offset in **N** moves the wrapped curves along the surface normal, away from the face or into it.
- Deform (Solid and Sheet) wraps solids and sheets in the same way.

Related:

Deform (Solid and Sheet), Unwrap Face, Project Curve-Body.
:::

::: {.command name="Raise Curve Degree" key="[Shift+S]{.key}" documented="26.2"}
Raises the degree of the selected curves by one. This adds CVs while keeping the shape, so you get more control points to reshape the curve without changing it first. Depending on how complex the curve is, the docs say it may also add extra spans.

![](figures/c06p-raise-rebuild.svg)

Before you start:

- Select one or more curves.
- [Shift+S]{.key} is the unified Raise Degree key: with curves selected it raises the curve degree; for surfaces see Raise Surface Degree. The command is also in the Suggested Commands menu.

Step by step:

1. Select the curves.
2. Press [Shift+S]{.key}, or click Raise Degree in the Suggested Commands menu.
3. Each curve gains one degree. The new CVs are selected automatically, so you can move them straight away.

Keys:

- [Shift+S]{.key} raise degree.

Common problems:

- Too many CVs to see or pick → hide the curve's control points with Toggle Points (the docs' tip for densely packed CVs), or use Rebuild Curve to set an exact number of CVs or a degree.

Tips:

- Raise the degree only as far as you need: every extra CV is one more point to keep smooth.

Related:

Rebuild Curve, Subdivide, Toggle Points, Raise Surface Degree.
:::

::: {.command name="Rebuild Curve" documented="1.3"}
Rebuilds a curve by repositioning its CVs to give an optimised layout, while keeping the original shape as closely as possible. Use it to clean up a curve with too many or unevenly spaced CVs before you build surfaces from it. You choose how: within a tolerance, with a set number of CVs, or with an explicit degree and number of spans. The right-hand pair in the Raise Curve Degree diagram shows the Points method.

Before you start:

- Select one or more curves.
- Rebuild has no default key: type *Rebuild* in the Command Palette, or use the button in the Suggested Commands menu.

Step by step:

1. Select the curves.
2. Type *Rebuild* in the Command Palette and run it.
3. Choose the **Method** and set its values in the command dialog, then confirm.

Options explained:

- **Method**:
  - **Refit** – rebuilds within a tolerance.
    - **Tolerance** – the tolerance to keep to.
    - **Keep corners** [1.3]{.ver} – when on, the corners of the curve are not changed.
  - **Points** – rebuilds with the number of CVs you set in **Points**.
  - **Explicit Control** [24.2]{.ver} (both licences: Indie and Studio) – rebuilds with the **Degree** and the number of **Spans** you set.
    - **Weight** [25.1]{.ver} – adjusts the position of the CVs, based on the Degree and Spans settings. A lower value loosens the curve's shape, which the docs say improves quality for surface work; a higher value keeps the curve closer to its original shape. The default is 0.5; the docs do not give the range.

Common problems:

- Refit rounds off sharp corners → turn on **Keep corners**.
- The rebuilt curve drifts too far from the original → with Explicit Control raise **Weight**; otherwise use more Points or Spans, or a smaller Tolerance with Refit.

Tips:

- To remove only unnecessary points without changing the shape at all, try Delete Redundant Topology first.
- Fewer, evenly spaced CVs and fewer spans usually give cleaner surfaces.
- If the CV layout is too dense to see, hide it with Toggle Points.

Related:

Raise Curve Degree, Delete Redundant Topology, Rebuild Face, Toggle Points.
:::

::: {.command name="Reverse Curve" version="24.2"}
Reverses the direction of a curve; its shape stays the same. Direction matters for tools that work along a curve: for example, it decides which end Pipe scales from (24.2 release notes). Reverse can also handle several bodies at once [25.2]{.ver}: curves have their direction reversed and sheets have their normal flipped.

Before you start:

- Select the curve, or several curves [25.2]{.ver}.
- Reverse has no default key: type *Reverse* in the Command Palette. With sheets selected it flips the normal instead (see Reverse Sheet).

Step by step:

1. Select the curves.
2. Type *Reverse* in the Command Palette and run it.
3. The direction of the curves is reversed.

Common problems:

- Pipe's Scale option tapers the wrong end → reverse the path curve. The 24.2 release notes describe this use.
- A Loft twists or its sections do not line up → the docs do not say whether Loft depends on curve direction, but as a general check, make the section curves run the same way and reverse the odd one out.

Related:

Reverse Sheet, Pipe, Sweep, Loft.
:::

::: {.command name="Slide Curve CV" key="[Shift+G]{.key}" version="25.1"}
Slides control vertices (CVs) of a spline curve along the direction of the control hull, for precise shaping without distorting the CV layout. With several CVs you can make proportional adjustments that blend smoothly along the curve, and mirror the change relative to the active construction plane. Only spline curves can be changed this way, not regular lines.

Before you start:

- Control Point mode ([1]{.key}). Select one or more CVs of a spline curve.
- [Shift+G]{.key} is the unified Slide key: with curve CVs selected it runs Slide Curve CV; with surface CVs it runs Slide Surface CV.

Step by step:

1. Select the CVs.
2. Press [Shift+G]{.key}. Gizmo handles with direction controls appear.
3. Drag a handle to slide the CVs, or type a **Distance** in the command dialog. You can also use the keys below.
4. If needed, set **Proportional**, **Falloff** and **Mirror** in the command dialog.
5. Hold [Ctrl]{.key} to switch between the preview and the active state, so you can compare before and after. Confirm.

Options explained:

- **Distance** – how far the CVs move.
- **Advanced** – additional options for more precise control over the slide.
- **Proportional** [26.2]{.ver} – how the slide affects the surrounding CVs:
  - **None** – the surrounding CVs are not affected.
  - **All** – all surrounding CVs move proportionally, according to the Falloff U/V settings.
  - **Selected** – only the selected CVs are affected; the last CV you selected gets the Slide gizmo handle.
- **Falloff U** / **Falloff V** [26.2]{.ver} – the falloff amount in the U and V directions. The command page lists both for curves; it does not say whether Falloff V has any effect on a curve.
- **Mirror** – mirrors the slide relative to the active construction plane. The mirror axes follow the global construction plane or a custom one.
  - **None** – no mirror plane.
  - **X / Y / Z** – mirror in that axis. The docs' wording ("either X, Y, and Z") leaves open whether axes can be combined.

Keys:

- [Shift+G]{.key} start.
- [U]{.key} slide in the positive U direction; [Shift+U]{.key} in the negative U direction; [N]{.key} in the normal direction.
- Hold [Ctrl]{.key} to switch between preview and active mode.
- [Ctrl+Z]{.key} undoes the last command execution.

Common problems:

- Slide does nothing on a curve → only spline curves can be manipulated, not regular lines.
- CVs you did not select move as well → **Proportional** is set to All. Set it to None or Selected.

Tips:

- Turn on Toggle Curvature while you slide: curves and edges update in real time while it is active, which makes it easier to optimise the curvature with Slide [25.3]{.ver}.

Related:

Slide Surface CV, Move (Move Control Point), Toggle Curvature (Measure Curvature), Toggle Points.
:::

::: {.command name="Convert Vertex" documented="26.2"}
Converts standard vertices into control vertices (CVs). In Plasticity a vertex is an end point of a curve, while a CV is a smaller point that shapes the curve and is linked to its neighbours by hull lines (see Core concepts and entities). The docs do not describe how the curve's shape changes after the conversion, so check the result.

Before you start:

- Control Point mode ([1]{.key}). Select the vertices to convert.
- Convert Vertex has no default key: run it from the Command Palette, or double-click a vertex.

Step by step:

1. Select the vertices.
2. Run *Convert Vertex* from the Command Palette.
3. The vertices are now control vertices.

You can also convert a single vertex by double-clicking it.

Tips:

- Do not confuse it with converting a selection ([Ctrl+1]{.key} to [Ctrl+5]{.key}), which changes what is selected, not the geometry.

Related:

Toggle Points, Slide Curve CV, Insert Knot (Insert CV at Point).
:::

::: {.command name="Delete Redundant Topology" documented="24.1"}
Removes surplus points from curves (and surplus edges from bodies). On a curve it analyses each vertex and deletes only the ones that are unnecessary, so the shape and accuracy of the curve do not change. With solids or sheets selected, the same command removes their redundant topology instead.

Before you start:

- Select the curves, or the solids or sheets, to clean up. The command picks the curve or body version from the selection.
- Delete Redundant Topology has no default key: run it from the Command Palette.

Step by step:

1. Select the curves (or solids or sheets).
2. Run *Delete Redundant Topology* from the Command Palette.
3. The redundant points (on bodies, the redundant topology) are deleted.

Common problems:

- A duplicated face still shows extra surface lines → from 26.2, duplicating faces that have surface lines keeps the raw surface information instead of deleting redundant topology. Run Delete Redundant Topology on the copy to remove the unnecessary lines [26.2]{.ver}.

Tips:

- Rebuild Curve repositions the CVs and keeps the shape only as closely as possible. Delete Redundant Topology does not alter the shape, so try it first when you only want fewer points.

Related:

Rebuild Curve, Delete Face, Duplicate.
:::

::: {.command name="Toggle Points" version="24.1"}
Shows or hides points: the CV and vertex points of curves, and the CV points of faces (sheets) and bodies (solids). Hide them when a dense CV layout gets in the way, for example after Raise Curve Degree, and show them again when you want to edit. It also runs with a curve CV selected [25.1]{.ver}.

Before you start:

- Select what to toggle:
  - **Curves** – the curve, or one of its CV points.
  - **Sheets** – the face, or a CV point.
  - **Solids** – a face or a CV point to toggle that face only, or the whole solid to toggle all its faces.
- Toggle Points has no default key: run it from the Command Palette. You can assign your own shortcut (see Tips).

Step by step:

1. Select the curve, face, solid or CV point.
2. Type *Toggle Points* in the Command Palette and click it.
3. The points are hidden or shown.
4. To show them again, select the curve, the faces or the solid and run Toggle Points again.

Common problems:

- The CVs of a curve or face have disappeared → they were hidden with Toggle Points. Select the curve, face or solid and run it again.

Tips:

- For quicker access, assign a shortcut: right-click *Toggle Points* in the Command Palette, choose **Assign Shortcut**, then press the keys you want.

Related:

Raise Curve Degree, Rebuild Curve, Rebuild Face, Raise Surface Degree.
:::
