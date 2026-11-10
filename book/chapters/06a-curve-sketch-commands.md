# Curve (sketch) commands

These tools edit the curves you have drawn: cut and join them, offset them, round their corners, extend them and connect them to other curves. Many commands are **unified**: one key runs the curve or body version depending on the selection ([B]{.key} fillet, [J]{.key} join, [O]{.key} offset, [I]{.key} project…). Curves are selected in Edge mode ([2]{.key}), their vertices in Point mode ([1]{.key}) and regions in Face mode ([3]{.key}). Unless a card says otherwise, you confirm with OK in the command dialog or a right-click (see *Confirming, cancelling and repeating commands* in chapter 3).

| I want to… | Use |
|--------------------------------|------------------|
| Remove the pieces of curves between intersections | Trim |
| Join curves that touch end to end into one curve | Join Curves |
| Separate joined curves again | Unjoin Curves |
| Split a curve in two at a point | Split Segment (Split Curve at Point) |
| Add a control point (CV) to a spline | Insert Knot (Insert CV at Point) |
| Cut curves with another curve or a face | Cut Curve |
| Find out why a closed outline has no region | Checklist after Cut Curve |
| Offset whatever is selected with one key | Offset Curve (unified) |
| Draw a parallel copy of a flat curve | Offset Planar Curve |
| Grow or shrink a region | Offset Region |
| Add vertices on both sides of a vertex | Offset Vertex |
| Turn an open curve into a closed slot outline | Slot |
| Round or bevel a corner between curves | Fillet Curve · Fillet Vertex |
| Make a curve longer, or extend it to a target | Extend Curve |
| Connect two curves with a smooth new curve | Bridge Curve |
| Connect two vertices or two edges with a curve | Bridge Vertex · Bridge Edge |
| Make a curve meet another with a chosen continuity (Studio) | Vertex Align (Edge Align) |
| Project with one key, whatever is selected | Project (unified) |
| Put a curve onto a solid or sheet as a new curve | Project Curve-Body |
| Get the curve where two bodies meet, or a 3D curve from two views | Project Body-Body · Project Curve-Curve |
| Get the outline of bodies, or a projected copy of curves | Project Outline · Create Outline · Duplicate Curve and Project |
| Wrap curves onto a surface | Deform Curve |
| Add CVs by raising the curve degree | Raise Curve Degree |
| Rebuild a curve with better CV positions | Rebuild Curve |
| Flip the direction of a curve | Reverse Curve |
| Slide CVs along the hull without distorting it | Slide Curve CV |
| Turn vertices into control vertices | Convert Vertex |
| Remove surplus points from curves | Delete Redundant Topology |
| Show or hide the points of curves and bodies | Toggle Points |

## Cut, trim and join

::: {.command name="Trim" key="[T]{.key}" documented="25.1"}
Deletes pieces of curves. A piece (segment) runs from one dividing point to the next; the docs name intersections with other curves, end points and control points as dividing points. Trim is the quickest way to clean overlapping sketch lines into a closed profile. It works on planar and 3D curves.

![](book/figures/c06-trim.svg)

Before you start:

- Draw the curves so that they cross where the profile should change. You do not need to select anything first.

Step by step:

1. Press [T]{.key}, or click the Trim button in the toolbar.
2. Click a segment you want to remove. Only that piece, bounded by the nearest dividing points, is deleted.
3. Click each further segment to remove.

Common problems:

- More is removed than you wanted → nothing crosses the curve where you expected, so the piece runs on to the next intersection or end point. Make sure the curves really cross (snap to them while drawing), or split the curve first with **Split Segment**.
- The wrong piece went → [Ctrl+Z]{.key} undoes it.

Tips:

- Trim is optimised for dense 2D sketches with many overlapping lines [25.1]{.ver}.
- It is often quicker to draw construction lines a little too long and trim them than to draw each piece to exact length.

Related:

Cut Curve, Unjoin Curves, Split Segment, Extend Curve.
:::

::: {.command name="Join Curves" key="[J]{.key}" documented="26.2"}
Joins curves whose end points meet into one curve (a wire body). Joined curves act as one, so a profile made of lines and arcs can be picked with one click.

Before you start:

- Edge mode ([2]{.key}). Select the curves to join.
- The end points must meet. The docs say "perfectly aligned": connected points turn blue-green, unconnected points stay purple. In practice this means coinciding within Plasticity's modelling tolerance, which you get by snapping the end points together (Object Snaps). The docs give no numeric tolerance.
- [J]{.key} is a unified key: with curves selected it runs Join Curves, with sheets selected it runs Join Sheets. Join is also in the Suggested Commands menu.

Step by step:

1. Select the curves.
2. Press [J]{.key}. The curves are joined.

Keys:

- [J]{.key} join. The 26.2 key list also gives [J]{.key} for Join in the Outliner [26.2]{.ver}.

Common problems:

- The curves do not join → their end points do not meet (they stay purple). Snap one end point onto the other, or connect the gap with **Bridge Curve** or **Bridge Vertex**. Do not rely on two points that only look close at your zoom level.

Related:

Unjoin Curves, Bridge Curve, Join Sheets.
:::

::: {.command name="Unjoin Curves" key="[Alt+J]{.key}" documented="1.3"}
Splits a joined curve back into its separate segments, so that you can edit, delete or move each one on its own.

Before you start:

- Select the joined curves. [Alt+J]{.key} is a unified key: curves → Unjoin Curves; faces → Unjoin Faces; solids or sheets → Unjoin Shells. It is also in the Suggested Commands menu.

Step by step:

1. Select the curves.
2. Press [Alt+J]{.key}. The curves are separated.

Older versions:

- Before 1.3 the command was called Explode (1.3 release notes).

Related:

Join Curves, Cut Curve, Split Segment, Trim.
:::

::: {.command name="Split Segment (Split Curve at Point)" documented="26.2"}
Splits one curve into two at a picked point. A vertex is inserted there, dividing the curve into two (or more) segments. Use it before Trim or Fillet when a curve has no natural break where you need one.

Before you start:

- No default key: use the Split Segment button in the toolbar.

Step by step:

1. Click the Split Segment button in the toolbar.
2. Click the point on the curve where it should be split.
3. A vertex is added and the curve is divided.

Tips:

- Split Segment adds a vertex that divides the curve; **Insert Knot** only adds a CV to a spline. Pick the one you need.

Related:

Insert Knot, Cut Curve, Unjoin Curves, Trim.
:::

::: {.command name="Insert Knot (Insert CV at Point)" documented="26.2"}
Inserts a CV (control vertex) into a spline. In the toolbar the button is called *Insert CV into curve*. The extra CV gives you more local control where you want to reshape the curve.

How it works (general NURBS theory): a knot is a parameter value along the curve where one span meets the next. Inserting a knot at the parameter location you click adds one CV, and the neighbouring CVs are moved so that the curve keeps its shape. The new CV lies on the control hull, which is usually off the curve, so it does **not** necessarily sit at the point you clicked. The docs say only that a CV is inserted at the clicked point; they do not describe the parameter or the shape.

Before you start:

- The curve must be a spline. No default key: use the toolbar button.

Step by step:

1. Click the *Insert CV into curve* button in the toolbar.
2. Click the place on the curve where the extra control should be.
3. The spline gains one CV; nearby CVs may shift.

Common problems:

- Nothing happens → the curve is not a spline. On a regular segmented curve (straight segments) the command has no effect.

Tips:

- Every extra CV makes the curve heavier. Add CVs only where you need control; **Rebuild Curve** can even them out later.

Related:

Split Segment, Raise Curve Degree, Rebuild Curve.
:::

::: {.command name="Cut Curve" documented="25.2"}
Cuts curves with other curves or with faces. With a curve as the cutter, the cut is made with a surface generated from that curve. It is reached from the Cut command by pressing [C]{.key} inside it (see 7.2).

Before you start:

- You need the curve to cut (the target) and a cutter: a curve or a face.
- Cut Curve is also in the Suggested Commands menu.

Step by step:

1. Press [C]{.key} to start Cut, then [C]{.key} again to switch to Cut Curve.
2. **Select target bodies**: click the curve to be cut.
3. **Select cutters**: click the curve or face to cut with.
4. Set the options and confirm.

Options explained:

- **Extend** ([Tab]{.key}) – lengthens a curve cutter that is too short to cut the target completely [25.2]{.ver}.

Keys:

- [C]{.key} switch from Cut to Cut Curve; [S]{.key} screen space – the cutting direction follows the view; [Tab]{.key} Extend.

Common problems:

- The cut stops short → the cutter curve does not reach across the target. Turn on **Extend** ([Tab]{.key}), or lengthen the cutter with **Extend Curve**.
- The cut lands in the wrong place → press [S]{.key} to cut along the view direction instead.

Related:

Cut, Trim, Unjoin Curves, Split Segment.
:::

::: {.note title="Checklist: a closed outline shows no region"}
The docs define a region as an area enclosed by curves, shown in dark blue (light blue when selected). If an outline you think is closed shows no region, work through these points in order. Items marked as advice are general modelling practice; the docs do not list the exact rules for region forming.

1. **Open end points.** Every end point must meet the next curve. A purple end point is not connected; a connected one is blue-green (docs, Join Curves). Snap it onto its neighbour, close the gap with **Bridge Curve** or **Extend Curve**, or draw the lines too long and **Trim** them.
2. **Not in one plane.** The docs treat regions per plane (for example, [Alt]{.key}+click selects all regions on the same plane). A curve drawn on another construction plane, or a 3D curve that leaves the plane, cannot enclose a flat area with the others [ADVICE]{.advice}. Set the construction plane and flatten the curve onto it with [Alt+D]{.key} (Duplicate Curve and Project), then delete the original.
3. **Duplicate or overlapping segments.** Two curves lying on top of each other (a line drawn twice, a pasted copy that was not moved) are hard to see. Click the edge and move it aside to check, or look for an extra curve in the Outliner, and delete the copy [ADVICE]{.advice}. Their effect on regions is not documented.
4. **Self-intersections.** A curve that crosses itself, or two curves that cross where they should only touch, divide the area differently from what you expect [ADVICE]{.advice}. Trim the overshoot at the crossing, or redraw the curve. Slot, for one, documents that it needs a curve that does not cross itself.
5. **Region-display limit.** The docs say regions stop appearing after about 700 curves on one plane, because drawing them becomes too costly; the same limit is noted for SVG import. Delete construction lines you no longer need, or put parts of the drawing on separate planes. The docs do not say whether a joined curve counts as one curve or as several.
:::

## Offset

::: {.command name="Offset Curve (unified)" key="[O]{.key}" documented="26.2"}
One key for the curve and edge offsets. [O]{.key} runs Offset Planar Curve, Offset Region, Offset Vertex, Offset Edge or Offset Face Loop according to the selection. On an open curve, [O]{.key}, then [O]{.key} runs Slot [26.1]{.ver}.

Before you start:

- Select what you want to offset and press [O]{.key}. Offset is also in the Suggested Commands menu.
  - Vertices → **Offset Vertex**.
  - Planar curves → **Offset Planar Curve**.
  - Regions → **Offset Region**.
  - Faces → **Offset Face Loop** (chapter 8).
  - Edges → **Offset Edge** (chapter 8).
- With an open planar curve, [O]{.key} again inside the command starts **Slot**.

Common problems:

- The wrong kind of offset starts → check the selection mode. A vertex selected in Point mode ([1]{.key}) gives Offset Vertex; the whole curve in Edge mode ([2]{.key}) gives Offset Planar Curve.

Related:

Offset Planar Curve, Offset Region, Offset Vertex, Slot, Offset Edge, Offset Face Loop.
:::

::: {.command name="Offset Planar Curve" key="[O]{.key}" documented="26.1"}
Offsets planar (flat) curves by a distance to create new curves, for example a wall thickness around an outline or a parallel line at a set spacing. You can offset to one side, or by the same distance on both sides. In **Freestyle** mode you click the offset point instead of entering a distance. Its command name in the docs is *Offset Curve*.

![](book/figures/c06-offset-slot.svg)

Before you start:

- Edge mode ([2]{.key}). Select one or more planar curves.
- Press [O]{.key}. With curves selected, the unified Offset command runs Offset Planar Curve. It is also in the Suggested Commands menu.

Step by step:

1. Select the curves and press [O]{.key}. A yellow arrow appears.
2. Drag the yellow arrow to set the distance, or press [D]{.key} and move the mouse. Type an exact value in the **Distance** field.
3. Press [V]{.key} to choose the gap fill, and [S]{.key} to offset by the same distance on both sides. Confirm.

**Freestyle** ([F]{.key}; also *Freestyle Offset Planar Curve* in the Command Palette):

1. Select the curves, press [O]{.key}, then [F]{.key}.
2. Move the cursor to the offset point and click. With grid snapping on, the point snaps to the grid; with object snapping on, it snaps to objects.
3. **Distance**, **Gap fill** ([V]{.key}) and **Lock distances** ([S]{.key}) work as in the normal mode. Confirm.

Options explained:

- **Distance** – how far the new curve is from the original.
- **Gap fill** ([V]{.key} cycles) – how the gap at convex corners is filled:
  - **Round** – rounds the convex corners.
  - **Linear** – joins them with straight lines and adds extra vertices.
  - **Natural** – keeps the original shape without adding extra vertices.
- **Lock distances** ([S]{.key}) – equal distance on both sides [26.1]{.ver}.
- **Freestyle** ([F]{.key}) – sets the offset by clicking a point (see above).

![](book/figures/c08-gap-fill.svg)

Keys:

- [O]{.key} start ([O]{.key} again runs Slot); [D]{.key} distance by mouse; [V]{.key} gap fill; [S]{.key} lock distances [26.1]{.ver}; [F]{.key} Freestyle.

Common problems:

- Slot starts instead → pressing [O]{.key} inside the command switches to Slot. Press it only once.
- The corners have extra vertices you do not want → switch the gap fill to **Natural** ([V]{.key}).

Tips:

- For a band around a centre line with closed, rounded ends, use **Slot** instead of Lock distances.
- Use Freestyle with object snapping to make the offset pass exactly through a point of another curve.

Older versions:

- Up to 25.3 Lock distances was on [Tab]{.key}; from 26.1 it is [S]{.key} (26.1 migration guide).

Related:

Offset Region, Offset Vertex, Slot, Offset Edge, Offset Face Loop.
:::

::: {.command name="Offset Region" key="[O]{.key}" documented="26.1"}
Offsets the outline curves of selected regions by a distance to create new regions. Use it to grow or shrink a flat shape before extruding it, for example for a lip or a recess. With several regions selected, the docs say the result is either new individual regions or one combined region.

Before you start:

- Face mode ([3]{.key}). Select one or more regions.
- Press [O]{.key}. With regions selected, the unified Offset command runs Offset Region. It is also in the Suggested Commands menu.

Step by step:

1. Select the regions and press [O]{.key}.
2. Drag the yellow arrow to set the distance, or press [D]{.key} and move the mouse. Type an exact value in the **Distance** field.
3. Press [V]{.key} for the gap fill, [S]{.key} to lock distances and, with several regions, [I]{.key} to switch between separate and combined results. Check the preview, then confirm.

Options explained:

- **Distance** – how far the new outline is from the old one.
- **Gap fill** ([V]{.key}) – Round, Linear or Natural, as in Offset Planar Curve (diagram there).
- **Lock distances** ([S]{.key}) – equal distance on both sides [26.1]{.ver}.
- **Individual** ([I]{.key}) – with several regions selected, chooses between separate new regions and one combined region. The Offset Region page says that turning it **on** offsets the regions *in a combined form*, which is the opposite of what the name suggests. Until this is tested, judge the result by the preview, not by the state of the toggle.

Keys:

- [O]{.key} start; [D]{.key} distance by mouse; [V]{.key} gap fill; [S]{.key} lock distances; [I]{.key} individual.

Older versions:

- Up to 25.3 Lock distances was on [Tab]{.key}; from 26.1 it is [S]{.key} (26.1 migration guide).

Related:

Offset Planar Curve, Offset Face Loop, Extrude.
:::

::: {.command name="Offset Vertex" key="[O]{.key}" version="1.4"}
Inserts new vertices along the curve on both sides of a selected vertex. Use it when you need extra vertices at an equal distance either side of a point, for example to mark where a change of shape should start. The offset can run past the neighbouring vertices instead of stopping at them [26.2]{.ver}.

Before you start:

- Point mode ([1]{.key}). Select a vertex of a curve.
- Press [O]{.key}. With a vertex selected, the unified Offset command runs Offset Vertex.

Step by step:

1. Select the vertex and press [O]{.key}.
2. Move the mouse to set where the new vertices go, or press [D]{.key}. Type an exact value in the **Distance** field.
3. Click to fix the positions, then confirm.

Options explained:

- **Distance** – how far the new vertices are from the selected one.

Keys:

- [O]{.key} start; [D]{.key} distance by mouse.

Older versions:

- Before 26.2 the offset was clamped at the neighbouring vertices (26.2 release notes).

Related:

Offset Planar Curve, Split Segment, Fillet Vertex.
:::

::: {.command name="Slot" key="[O]{.key}, then [O]{.key}" version="26.1"}
Offsets an open, non-self-intersecting curve by the same amount on both sides and closes both ends with tangent arcs. The result is a closed slot outline, for bolt slots, ventilation cut-outs and similar shapes. The diagram is under Offset Planar Curve.

Before you start:

- The curve must be open and must not cross itself.
- Select the curve. Run **Slot** from the Command Palette, or press [O]{.key}, then [O]{.key}: the first starts Offset Curve, the second switches to Slot.

Step by step:

1. Select the curve.
2. Run Slot from the palette, or press [O]{.key}, then [O]{.key}.
3. Set the **Width**, or press [D]{.key} and move the mouse.
4. Confirm. The slot outline is created.

Options explained:

- **Width** – the width of the slot.

Keys:

- [D]{.key} width by mouse.

Common problems:

- Slot does nothing → the curve is closed or crosses itself. Use an open curve.

Tips:

- A flat slot outline is closed, so it forms a region you can extrude straight away (closed planar curves form regions automatically, see chapter 4).

Related:

Offset Planar Curve, Tangent Arc, Extrude.
:::

## Fillet, extend, bridge, align

::: {.command name="Fillet Curve · Fillet Vertex" key="[B]{.key}" documented="26.2"}
Rounds (fillet) or bevels (chamfer) the corner between two curve segments (Fillet Curve), or at selected connected vertices (Fillet Vertex). The direction in which you drag decides whether you get a fillet or a chamfer. Use it to round the corners of a sketch profile before you extrude it.

![](book/figures/c06-fillet-chamfer.svg)

Before you start:

- **Fillet Curve:** Edge mode ([2]{.key}); select the curves that meet at the corner.
- **Fillet Vertex:** Point mode ([1]{.key}); select the connected vertices to round.
- Press [B]{.key}. The unified Fillet key picks the variant from the selection: curves → Fillet Curve, vertices → Fillet Vertex, edges of a solid or sheet → Fillet Shell. Fillet is also in the Suggested Commands menu.

Step by step:

1. Select the curves or vertices and press [B]{.key}. A yellow dot appears.
2. Drag the yellow dot to set the radius. Dragging one way gives a fillet, the other way a chamfer; the docs do not say which is which, so watch the preview.
3. Or press [D]{.key} (fillet) or [C]{.key} (chamfer) and move the cursor. Type an exact value in the **Radius** field. Confirm.

Options explained:

- **Radius** – the size of the fillet or chamfer.

Keys:

- [B]{.key} start; [D]{.key} fillet distance by moving the cursor; [C]{.key} chamfer distance by moving the cursor.

Common problems:

- You get a chamfer instead of a rounded corner (or the other way round) → drag in the other direction, or press [D]{.key} for a fillet and [C]{.key} for a chamfer.
- Fillet Shell starts instead → solid or sheet edges were selected. Select the curve or its vertices instead.

Related:

Fillet Shell, Offset Vertex, Bridge Curve.
:::

::: {.command name="Extend Curve" documented="24.1"}
Lengthens a curve by a distance, with a choice of shapes for the new part. It accepts an end point (vertex) or a whole curve (both ends at once). It can also extend a curve exactly up to a target curve, sheet or solid [25.2]{.ver}. Use it, for example, to make a curve long enough to cross another before Trim, or to reach right across a body before Cut.

![](book/figures/c06-extend-shapes.svg)

The diagram redraws the shape figure on the official Extend Curve page; it is not an application test, and the exact curvature at each join is not documented.

Before you start:

- Point mode ([1]{.key}): select the end point (vertex) to extend one end. Or select the whole curve (Edge mode, [2]{.key}) to extend both ends at once.
- No default key: run *Extend* from the Command Palette. The unified Extend command runs Extend Curve for curves and Extend Sheet for the outside edges of a sheet.

Step by step:

1. Select the end point (or the curve) and run Extend.
2. Press [D]{.key}, move the cursor and click to set the length, or type the **Distance**.
3. Choose the **Shape** in the command dialog, then confirm.

**Extending to a target** [25.2]{.ver}:

1. Select one end point of the curve and run Extend.
2. Click the target: a curve, or a sheet or solid.
3. The curve extends until it meets the target exactly; the target sets the length.

Options explained:

- **Shape** – the shape of the new part, as the docs describe it:
  - **Natural** – continues the curve described by the original curve just before the start of the extension.
  - **Linear** – a straight line from the end point in the current tangent direction, without altering curvature.
  - **Soft** – blends gradually with the existing curve for a smooth transition, preserving tangent and curvature.
  - **Reflective** – mirrors the curvature and tangency of the curve, for a symmetrical continuation.
  - **Arc** – a circular arc from the end point.
- **Distance** – how far the curve is extended.

Keys:

- [D]{.key} distance by moving the cursor.

Tips:

- Use Linear when the extension only needs to cross something, for example a cutter for Cut Curve; use Natural, Soft or Reflective when the extended part stays in the design.

Older versions:

- Before 24.1 Extend Curve accepted only vertices; 24.1 added whole curves, extended in both directions (24.1 release notes).

Related:

Extend Sheet, Trim, Cut Curve, Bridge Curve.
:::

::: {.command name="Bridge Curve" documented="24.2"}
Creates a new curve that connects two curves, with G0–G3 continuity at each end. Tension is adjustable, the source curves can be trimmed automatically, and you can display curvature to check the result. Use it to close a gap between two curves smoothly, for example before building a surface from them.

![](book/figures/c06-bridge-curve.svg)

Before you start:

- Enable the Control-Point, Edge, Curve, Face and Axis object snaps. The start and end points can then snap to any position on a curve, edge or face.
- Click the Bridge Curve button in the toolbar. In the Command Palette, the unified *Bridge* command runs Bridge Curve when two curves or nothing are selected (two vertices → Bridge Vertex, two edges → Bridge Edge).

Step by step:

1. Click the Bridge Curve button.
2. Click the start point on a curve, edge or face.
3. Click the end point. The bridge appears with its gizmo.
4. Adjust the bridge:
   - Drag the parameter handles to move the start and end points along the source curves, and the **Sense Direction** handle to set which way the bridge connects to each source curve [26.2]{.ver}.
   - Press [Tab]{.key} to cycle the continuity, or set **Start curvature** and **End curvature** in the dialog.
   - Press [D]{.key} for the G1 tension, or drag the tension gizmos and the visible CVs [25.2]{.ver}.
5. Confirm.

Options explained:

- **Parameter 1/2** – the relative position of the start and end point on each source curve. The parameter handles set the same thing in the viewport [26.2]{.ver}.
- **Start curvature / End curvature** – the continuity at each end, G0, G1, G2 or G3 (see the diagram below), also set with the continuity gizmo [24.2]{.ver}.
- **Tension G1 / G2 / G3** (one value for each end) – the tension at that end. Tension G1 affects the first to third control vertex (CV) from the end, G2 the second and third, G3 the third.
- **Trim** ([Q]{.key}) – when on, any part of the source curves that extends beyond the bridge is trimmed.
- **Show curvature** – shows the curvature of the curve (see Toggle Curvature). Curvature combs are also under **Analysis** [25.2]{.ver}.
- **Create Constraints** [STUDIO]{.studio} [26.2]{.ver} – adds constraints that keep the chosen continuity when you change the geometry later. Click a constraint icon in the viewport to open its Constraint Options and change the continuity (G0–G3 for curves). The last-used setting is remembered.

![](book/figures/c06-continuity.svg)

Keys:

- [Tab]{.key} cycle G0 → G1 → G2 → G3; [D]{.key} G1 tension; [Q]{.key} trim on/off; [N]{.key} limit to face normal; [X]{.key}, [Y]{.key} or [Z]{.key} constrain to that axis.

Common problems:

- The start or end point will not land on an edge or face → turn on the object snaps listed above.
- The bridge connects from the wrong side of a source curve → drag the Sense Direction handle [26.2]{.ver}.
- The continuity is not what you expected → Bridge remembers the continuity settings from the last use [26.1]{.ver}. Check them before confirming.
- The constraints are gone after reopening the file → constraints are not yet saved with the file [26.2]{.ver}.

Tips:

- Turn on **Show curvature** while you adjust tension: a smooth comb without sudden jumps at the ends means the bridge flows into its neighbours.

Older versions:

- Up to 26.1 the dialog had a **Sense** option; in 26.2 the Sense Direction handle replaces it.

Related:

Bridge Vertex · Bridge Edge, Join Curves, Vertex Align (Edge Align), Toggle Curvature, Measure Continuity, Bridge Surface.
:::

::: {.command name="Bridge Vertex · Bridge Edge" documented="24.2"}
Bridges two selected vertices, or two edges of surfaces, with a new curve. The options are the same as in Bridge Curve: G0–G3 continuity at each end, adjustable tension and curvature display, with the continuity gizmo that 24.2 added to Bridge Vertex.

Before you start:

- **Bridge Vertex:** Point mode ([1]{.key}); select the two vertices.
- **Bridge Edge:** Edge mode ([2]{.key}); select the two surface edges.
- Run *Bridge* from the Command Palette. The Bridge Vertex page also mentions [L]{.key}: no other page lists this key, and elsewhere [L]{.key} runs Loft.

Step by step:

1. Select the two vertices or the two edges.
2. Run *Bridge* from the Command Palette.
3. Set the options in the command dialog or with the keys, then confirm.

Options explained:

- **Start/End curvature** – G0, G1, G2 or G3 at each end.
- **Tension** G1 / G2 / G3 for each end – as in Bridge Curve. The Bridge Edge page calls them Tension 1, 2 and 3.
- **Parameter 1/2** – the position on each vertex's curve or edge.
- **Trim** – trims any curve that extends beyond the bridge.
- **Show curvature** – shows the curvature of the new curve.
- **Create Constraints** [STUDIO]{.studio} [26.2]{.ver} – keeps the chosen continuity; edit it later in the Constraints menu.

Keys:

- [Tab]{.key} cycle continuity; [D]{.key} G1 tension; [Q]{.key} trim on/off; [X]{.key}, [Y]{.key} or [Z]{.key} axis.

Related:

Bridge Curve, Join Curves, Vertex Align (Edge Align).
:::

::: {.command name="Vertex Align (Edge Align)" version="26.1" studio="true"}
Curve mode of the **Edge Align** command (Studio only). It moves a target vertex or curve so that it meets a reference with the continuity you choose. It supports splines, polylines and geometric curves such as circles and polygons. Use it to make two curves flow into each other before you build surfaces from them.

Before you start:

- You need a Studio licence.
- Select the **target** (the one that moves) first, then the **reference** (the one it aligns to). Pick vertices in Point mode ([1]{.key}). For curves in Edge mode ([2]{.key}), Plasticity aligns the end nearest to where you click, on the target and on the reference.
- Run **Edge Align** from the Command Palette. With two vertices or curves selected it runs Vertex Align; with two surface edges, Surface Align.

Step by step:

1. Select the target first, then the reference.
2. Run **Edge Align** from the Command Palette – two vertices or curves run Vertex Align.
3. Set the continuity, tension and other options, then confirm.

**Picking at a shared or overlapping vertex**: hold [Ctrl+Shift]{.key} and click the target vertex. A list of the curves connected to it opens; hover an entry to highlight its curve and click to confirm. For the reference, do the same but hold [Shift]{.key} when you click in the list. You can also click and hold a vertex and scroll the mouse wheel to cycle through its connected curves.

Options explained:

- **Continuity** – for each end separately by clicking the black circles. The command page lists G0–G2, but the 26.1 and 26.2 release notes list G0–G3 for curves.
- **Tension** G1 / G2 / G3 – the CV continuity distance for each level. [D]{.key} sets the G1 tension.
- **Parameter** – the position of the aligned object within the geometry's parameter space. A value of 0.5 is not always halfway.
- **Partial Alignment** ([P]{.key}) – aligns only part of the curve. A sliding gizmo along the segment sets where the alignment starts and ends, and [P]{.key} toggles it [26.2]{.ver}.
- **Show Curvature** – shows the curvature comb; set the comb size in the Curvature menu.
- **Create Constraints** ([C]{.key}) – adds constraints that keep the chosen continuity, editable later in the Constraints menu [26.2]{.ver}.

Keys:

- [Tab]{.key} cycle continuity; [D]{.key} G1 tension; [P]{.key} partial alignment [26.2]{.ver}; [C]{.key} create constraints [26.2]{.ver}.
- [Ctrl+Shift]{.key}+click a vertex for the list of connected curves ([Shift]{.key} in the list for the reference); click, hold and scroll to cycle them.

Common problems:

- The wrong curve moves → the selection order is reversed. Select the target first, then the reference.
- The wrong curve is picked where curves share a vertex → use [Ctrl+Shift]{.key}+click or click-hold-scroll.
- *Edge Align* is not in the Command Palette → it needs a Studio licence.

Older versions:

- Up to 26.1 the command was called **Align**; 26.2 renamed it **Edge Align**.

Related:

Bridge Curve, Bridge Vertex · Bridge Edge, Surface Align, Project Align, Measure Continuity.
:::
