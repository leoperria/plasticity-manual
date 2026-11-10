# Face and edge commands

These tools change existing solids and sheets through their faces and edges: move or tilt a face, add edges you can use in later operations, replace or remove faces. Most of them start from a selection in Face mode ([3]{.key}) or Edge mode ([2]{.key}). Unless a card says otherwise, you confirm with right-click or OK in the command dialog (see *Confirming, cancelling and repeating commands* in chapter 3).

| I want to… | Use |
|--------------------------------|------------------|
| Move a face in or out, with its neighbours following | Offset Face (Push Face) |
| Add new edges parallel to a face's outline | Offset Face Loop |
| Add new edges parallel to selected edges | Offset Edge |
| Tilt faces by a draft angle, e.g. for moulded parts | Draft Face |
| Make a face follow another surface | Match Face |
| Remove faces, or edges that split a face | Delete Face |
| Get a flat sheet from a face, as a reference for Deform | Unwrap Face |
| Split faces where curves project onto them | Imprint Curve-Body |
| Split faces where two bodies intersect | Imprint Body-Body |
| Split a face along its own U or V direction | Isoparam |

::: {.command name="Offset Face (Push Face)" documented="24.1"}
Moves the selected faces in or out by a distance. Use it to change a feature without rebuilding it: make a wall thicker, a pocket deeper or a boss taller. It can also set an angle for the adjacent faces, and match the moved face to another face (dependent offset).

**On a solid**, when the offset succeeds, the neighbouring faces stretch or shrink to follow the moved face, so the result is still a closed solid (diagram). This describes a successful edit only: the docs do not say what happens when the neighbours cannot follow, so check the result. **On a sheet** there is no closed volume to keep: the sheet stays open, with free boundary edges. The command page does not mention sheets, so how a sheet's neighbouring faces and open edges follow is not documented.

![](book/figures/c08-push-face.svg)

Before you start:

- Switch to Face mode ([3]{.key}) and select one or more faces.
- Selecting a face starts the command (the palette calls it *Push Face*). This auto-start is controlled by **Auto-invoke commands** and **Push-face** under **Preferences › Commands** (both on by default).

Step by step:

1. Select the face or faces. A yellow dot appears on the selection.
2. Drag the yellow dot to set the distance, or press [D]{.key} and move the cursor.
3. For an exact value, type it in the **Distance** field of the command dialog.
4. If needed, set **Angle Adjacent** and **Grow** (see below), then confirm.

**Matching another face (dependent offset)** [24.1]{.ver}: select the faces so Push Face starts, then, while offsetting, click a second face to match. The moved faces change distance and size to meet and intersect that face.

Options explained:

- **Distance** – how far the selected faces move.
- **Angle Adjacent** – an angle for the adjacent faces as they follow the moved face. [A]{.key} sets it by moving the cursor.
- **Grow** – what happens when you push a concave inner face (for example the wall of a notch) far enough to reach the body's outer wall:
  - **Moving** – the outer wall moves with it.
  - **Fixed** – the face stops at the outer wall.
  - **None** – the face carries on by itself, neither affecting the outer wall nor being affected by it.

Keys:

- [D]{.key} distance by moving the cursor; [A]{.key} adjacent angle by moving the cursor.
- [Tab]{.key} – the docs disagree. The command page lists [Tab]{.key} for switching the Grow mode; the 26.1 release notes list Push Face among the gizmo commands where [Tab]{.key} enters an exact distance [26.1]{.ver}. Until this is settled, set Grow in the command dialog and type exact distances in the **Distance** field.

Common problems:

- Selecting a face does not start Push Face → the auto-start is off. Turn on *Auto-invoke commands* and *Push-face* under Preferences › Commands, or run Push Face from the Command Palette.
- The face will not go past another wall → this is the **Grow** setting. Try *Moving* or *None* instead of *Fixed*.

Tips:

- Pushing faces is usually easiest before fillets are added; a common practice is to leave fillets until late (see chapter 1, Typical modelling workflow).

Older versions:

- The [Tab]{.key} gizmo-distance entry was added in 26.1. The docs do not say whether [Tab]{.key} switched the Grow mode before 26.1, or which key does so in 26.2.

Related:

Draft Face, Match Face, Delete Face; Offset Face Loop to add edges without moving the face.
:::

::: {.command name="Offset Face Loop" key="[O]{.key}" documented="26.1"}
Creates new edges on the body, parallel to the outline of the selected faces. The shape does not change; the faces are split so that you can push, extrude or fillet the new strip separately. With several faces selected you can offset each outline on its own or their combined outline.

Before you start:

- Face mode ([3]{.key}). Select one or more faces.
- Press [O]{.key}. The unified Offset command picks the variant from the selection: faces → Offset Face Loop, edges → Offset Edge, curves → Offset Planar Curve, regions → Offset Region. The command is also in the Suggested Commands menu.

Step by step:

1. Select the faces and press [O]{.key}. A preview of the new outline follows the mouse.
2. Move the mouse to set the distance, or press [D]{.key}; type an exact value in the **Distance** field.
3. Choose the corner style with [V]{.key} (gap fill) and, with several faces, [I]{.key} for individual or combined outlines. Confirm.

Options explained:

- **Distance** – how far the new edges are from the face outline.
- **Gap fill** ([V]{.key} cycles) – how convex corners are filled:
  - **Round** – with a rounded curve.
  - **Linear** – with straight lines, but the resulting edges may be split into several pieces.
  - **Natural** – with straight lines, keeping the edges continuous.
- **Individual** ([I]{.key}) – with several faces selected, switches between one outline per face and one combined outline. The docs say that turning it on offsets the faces in a combined form, which is counter-intuitive for the name, so check the preview.
- **Lock distances** ([S]{.key}) [26.1]{.ver} – offsets by the same distance on both sides.

![](book/figures/c08-gap-fill.svg)

Keys:

- [O]{.key} start; [D]{.key} distance by mouse; [V]{.key} gap fill; [I]{.key} individual; [S]{.key} lock distances.

Tips:

- Use Natural when you will fillet or offset the new edges again. Continuous edges are easier to select and give cleaner results than the split edges Linear can produce.

Older versions:

- Up to 25.3 the default key for Lock distances was [Tab]{.key}; from 26.1 it is [S]{.key} (26.1 migration guide).

Related:

Offset Edge, Offset Curve, Isoparam, Imprint Curve-Body.
:::

::: {.command name="Offset Edge" key="[O]{.key}" documented="24.2"}
Creates new edges parallel to the selected edges, running across the neighbouring faces. Use it to mark where a band, a chamfer or a change of shape should start. A two-sided gizmo, like the fillet gizmo, lets you offset to either side [24.2]{.ver}.

Before you start:

- Edge mode ([2]{.key}). Select one or more edges of a solid or sheet.
- Press [O]{.key}. With edges selected, the unified Offset command runs Offset Edge.

Step by step:

1. Select the edges and press [O]{.key}.
2. Move the mouse left or right to choose the side and the distance, or press [D]{.key}; type an exact value in the **Distance** field.
3. Press [V]{.key} to choose the gap fill, and [S]{.key} to offset by the same distance on both sides. Confirm.

Options explained:

- **Distance** – how far the new edges are from the selected ones.
- **Gap fill** ([V]{.key}) – Round, Linear or Natural, as in Offset Face Loop (diagram above).
- **Lock distances** ([S]{.key}) [26.1]{.ver} – the same distance on both sides of the edge.

Keys:

- [O]{.key} start; [D]{.key} distance by mouse; [V]{.key} gap fill; [S]{.key} lock distances.

Older versions:

- Up to 25.3 the default key for Lock distances was [Tab]{.key}; from 26.1 it is [S]{.key} (26.1 migration guide).

Related:

Offset Face Loop, Offset Curve, Isoparam, Imprint Curve-Body.
:::

::: {.command name="Draft Face" documented="24.2"}
Tilts faces by a draft angle relative to a reference face. Moulded and cast parts need draft so that they release from the mould; it is also a quick way to taper any wall.

![](book/figures/c08-draft-face.svg)

Before you start:

- Face mode ([3]{.key}). You need a **reference face** (the neutral plane, often the base or the parting face) and the **faces to draft**.
- Draft Face has no default key: run it from the Command Palette or the Suggested Commands menu.

Step by step:

1. Select the reference face.
2. Add the faces to draft: hold [Shift]{.key} to add faces and [Ctrl]{.key} to deselect them. Once the command is running, its key list gives [Ctrl]{.key} for adding or removing draft faces [24.2]{.ver}.
3. Search for *Draft Face* in the Command Palette and run it.
4. Drag the white circle to set the draft angle, or drag the gizmo to move the reference plane [24.2]{.ver}.
5. Set the options and confirm.

Options explained:

- **Degrees** – the draft angle.
- **Taper Method** – how the angle is applied:
  - **Isocline** – a constant angle along one pull direction, so the whole face has the same draft whatever its curvature.
  - **Curve** – a selected curve is the pivot of the taper.
  - **Surface** – the faces tilt relative to the orientation of a second reference surface.
  - **Offset** – the pivot is moved away from the reference plane with the yellow handle.
  - **Normal** – the angle is applied perpendicular to the reference face's starting surface.
- **Grow** – when a drafted concave inner face reaches the outer wall: **Moving** extends the outer wall, **Fixed** stops at it, **None** carries on independently.

Keys:

- [A]{.key} draft angle by moving the cursor; [D]{.key} moves the neutral (reference) face; [Ctrl]{.key} adds or removes draft faces.

Common problems:

- The reference plane cannot be moved → the face is a non-uniform surface. You can still set the draft angle, but not move the reference plane (documented limitation, 24.2).

Tips:

- A draft-angle analysis shader [24.1]{.ver} lets you check the draft on a model.

Related:

Offset Face, Match Face, Delete Face.
:::

::: {.command name="Match Face" documented="26.2"}
Replaces the selected faces with another surface, so that the body follows it. For example, a flat top can take on the curve of a sheet, or a face can be brought onto the face of another body.

Before you start:

- Face mode ([3]{.key}). Select the faces to replace.
- You need the surface to match, for example a face of another solid or sheet.
- No default key: run *Match Face* from the Command Palette or the Suggested Commands menu.

Step by step:

1. Select the faces to match.
2. Search for *Match Face* in the Command Palette and run it.
3. Click the surface to replace them with.
4. Set the options and confirm.

Options explained:

- **Grow** – Moving, Fixed or None, as in Offset Face: what happens when the face reaches the outer wall.
- **Side › Front** – when on, the face is matched to the front of the selected surface. The docs do not define “front”; if the result faces the wrong way, toggle it.

Related:

Offset Face, Draft Face, Delete Face.
:::

::: {.command name="Delete Face" key="[Shift+X]{.key} or [Shift+Delete]{.key} or [Shift+Backspace]{.key}" documented="26.2"}
Deletes the selected faces. Removing a face from a solid leaves an open body (a sheet). Deleting **edges** joins fractured edges [24.2]{.ver}.

Before you start:

- Face mode ([3]{.key}) for faces, Edge mode ([2]{.key}) for edges.

Step by step:

1. Select the faces.
2. Press [Shift+X]{.key}, [Shift+Delete]{.key} or [Shift+Backspace]{.key}. The faces are deleted at once; there is no dialog.

Keys:

- Faces: [Shift+X]{.key}, [Shift+Delete]{.key} or [Shift+Backspace]{.key} (Plasticity Essentials shortcut list).
- Edges: [X]{.key}, [Shift+X]{.key}, [Delete]{.key} or [Shift+Delete]{.key} (2024.2 release notes).

Common problems:

- Deleted too much → [Ctrl+Z]{.key} undoes it.

Tips:

- To close the opening again, select its boundary and use **Patch**. **Find Boundary Edges** selects the edges around an opening.

Older versions:

- In 24.2 the Rebuild Edge command was removed; deleting edges with the keys above replaced it.

Related:

Patch, Find Boundary Edges, Join Sheets, Delete Redundant Topology.
:::

::: {.command name="Unwrap Face" documented="24.2"}
Creates a flat sheet from the selected face of a solid [24.2]{.ver}. Its documented use is as the reference face for **Deform**: the official Deform pages say the unwrapped sheet is a “correctly mapped surface” that avoids unwanted deformation when geometry is wrapped onto the face. The Command Palette lists it as *Unwrap*.

**Not a manufacturing flat pattern.** The docs do not say how the face is mapped to the plane, and do not promise that lengths, angles or areas on the flat sheet match the 3D face. Do not use the sheet as a cutting pattern for sheet metal, fabric or leather without measuring it. This is also a geometric limit, not only a documentation gap (general theory):

- A **developable** face (a plane, or a face curved in one direction only, like part of a cylinder or cone) can in principle be rolled flat without stretching.
- A **doubly curved** face (part of a sphere, a saddle, most freeform car-body surfaces) has non-zero Gaussian curvature. By Gauss's *Theorema Egregium*, it cannot be flattened while keeping all lengths and angles; any flat version stretches, shrinks or tears somewhere. Real flat-pattern tools spread that distortion on purpose and add material allowances; the docs do not describe Unwrap doing either.

Before you start:

- Face mode ([3]{.key}). Select one face.

Step by step:

1. Select the face.
2. Type *Unwrap* in the Command Palette and run it.
3. The flat sheet is created at the world origin.

Common problems:

- The sheet is not where you expected → the result is always placed at the centre of the world origin; move it afterwards.
- Deform gives bad results on a closed face such as a full cylinder → unwrapping for Deform works on open faces only, not periodic (closed) ones. Split the surface, or the object being wrapped, first.

Tips:

- Wrapping a design onto a curved face: run Unwrap on the target face, draw or place the design on the flat sheet, then use the sheet as the reference face in Deform. The official Deform page recommends this for accurate placement.
- If you need real dimensions, measure the sheet against the 3D face first.

Related:

Deform (Solid and Sheet), Deform Curve.
:::

### Project, Imprint or Cut? {-}

Three tools take a curve and a body, and are easy to confuse. They differ in what they leave behind (official command pages for Project Curve Body, Imprint Curve Body and Cut):

![](book/figures/c08-project-imprint-cut.svg)

| | Project Curve-Body ([I]{.key}) | Imprint Curve-Body ([Shift+I]{.key}) | Cut ([C]{.key}) |
|---|---|---|---|
| Creates | a **new curve**, a separate object lying on the body | **new edges** on the body | a cutting surface from the curve, used to cut the body |
| The body | unchanged | same body and shape; its faces are **divided** along the new edges | **cut into pieces**; the pieces are separate bodies |
| Typical next step | use the curve as a path or profile | push, offset or fillet the new face strip | move, delete or keep the pieces |
| Body-body variant | Project Body-Body: a curve along the intersection | Imprint Body-Body: edges where the bodies intersect | Cut with a face as the cutter; Boolean to subtract a solid |

Cut and Boolean are described in chapter 7, Project in chapter 6.

::: {.command name="Imprint Curve-Body" key="[Shift+I]{.key}" documented="25.1"}
Projects curves onto a solid or sheet and splits its faces along them, creating new edges. Use it to add panel lines, logo outlines or cut boundaries that you then extrude, push, offset or fillet. The body's shape does not change.

![](book/figures/c08-imprint-projection.svg)

Before you start:

- [Shift+I]{.key} is a unified Imprint key: with curves, one body or nothing selected it runs Imprint Curve-Body; with two bodies selected it runs Imprint Body-Body.
- Position the curves so that they face the body in the direction you will project.

Step by step:

1. Press [Shift+I]{.key} in any of three ways:
   - with the **curves** selected, then click the solid or sheet;
   - with the **body** selected, then click the curves;
   - with **nothing** selected, then click the body, then the curves.
2. Set the options in the command dialog and confirm.

Options explained:

- **Method** – **Normal** projects in the standard way; **Vector** projects in one straight direction and makes the next two options available.
- **Bidirectional** – also projects in the opposite direction, so faces on both sides of the curve are imprinted.
- **Hide occlusion** – does not project onto surfaces behind the object.
- **Completion** – extends the new edges: **None** leaves them as projected; **Edge** extends them until they meet existing edges; **Boundary** extends them to meet other edges and connects them.

Common problems:

- Edges appear on the back of the body too → turn on **Hide occlusion**.
- Nothing appears on one side → turn on **Bidirectional**, or move the curve.
- The new edges stop short of the face boundary → set **Completion** to Edge or Boundary.

Tips:

- **Project Curve-Body** ([I]{.key}) uses the same projection but creates new curves instead of edges (see *Project, Imprint or Cut?* above).

Related:

Imprint Body-Body, Project Curve-Body, Cut, Isoparam, Offset Curve.
:::

::: {.command name="Imprint Body-Body" key="[Shift+I]{.key}" documented="25.2"}
Creates edges on a target body where another body (the tool) intersects it, without cutting anything. Optionally the tool is imprinted too. Use it, for example, to mark where a boss meets a wall before filleting just that line. Several tool bodies can be used at once [25.2]{.ver}.

Before you start:

- Body mode ([4]{.key}). The **target** is the body that gets the new edges; the **tool** is the body that intersects it.

Step by step:

1. Select the target solid or sheet first, then the tool.
2. Press [Shift+I]{.key}. With two bodies selected, the unified Imprint key runs Imprint Body-Body.
3. Set the options in the command dialog and confirm.

Options explained:

- **Imprint tool** – also creates edges on the tool body, and makes **Complete tool** available.
- **Complete target** – **None** leaves the new edges on the target as they are; **Edge** extends them until they meet other edges.
- **Complete tool** – the same choice for the edges on the tool.

Related:

Imprint Curve-Body, Boolean (to actually cut or join), Isoparam.
:::

::: {.command name="Isoparam" key="[Ctrl+R]{.key}" documented="25.2"}
Splits a face along a line of its own U or V direction (an isoparametric line), so the new edges follow the surface's internal grid. This gives clean split lines for later fillets, push/pull or Match Face. With **Subdivide** [25.2]{.ver} it splits a surface in half while keeping its control-point layout.

![](book/figures/c08-isoparam.svg)

Before you start:

- You need a face of a solid or sheet. The docs do not say whether it must be selected first; hovering it is enough to place the line.

Step by step:

1. Press [Ctrl+R]{.key}.
2. Move the cursor over the face to where the line should go; the preview follows the cursor.
3. Press [Tab]{.key} to switch between U and V, use [Shift+Wheel up]{.key} or [Shift+Wheel down]{.key} to add or remove lines, and [S]{.key} to turn on Subdivide.
4. Confirm with right-click.

Options explained:

- **Direction** – U or V, the surface direction the line follows ([Tab]{.key}).
- **Count** – how many lines are created ([Shift+Wheel up]{.key} or [Shift+Wheel down]{.key}).
- **Param** – where the line sits between the start and end of the face in that direction.
- **Subdivide** ([S]{.key}) – when off, the line is added without changing the surface's control points. When on, the surface is split so that both parts keep a consistent CV layout.

Keys:

- [Tab]{.key} U/V direction; [Shift+Wheel up]{.key} add a line; [Shift+Wheel down]{.key} remove a line; [S]{.key} Subdivide.

Common problems:

- A Subdivide split cannot be dissolved afterwards → Subdivide is destructive: both parts share the CV layout and the face cannot go back to its previous state. Undo ([Ctrl+Z]{.key}) straight away if needed.

Related:

Offset Face Loop, Imprint Curve-Body, Subdivide.
:::
