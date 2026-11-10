# Common commands (curves and bodies)

These commands work on almost anything you can select: curves, solids and sheets, and often faces, edges and control points as well. They move and copy geometry, repeat it in patterns, link copies to an original (instances), set its appearance (materials) and refine curves and edges. Unless a card says otherwise, you confirm and cancel these commands in the usual way (see *Confirming, cancelling and repeating commands* in chapter 3).

| I want to… | Use |
|--------------------------------|------------------|
| Move objects, faces, edges or control points | Move |
| Turn a selection about an axis | Rotate |
| Make a selection bigger or smaller, evenly or along one axis | Scale |
| Make a mirror image, optionally cut at the plane and joined to the original | Mirror |
| Copy a selection and move the copy at once | Duplicate |
| Project curves or outlines onto the construction plane, or copy faces out as a new body | Alternative Duplicate |
| Copy objects from a point on them to points elsewhere in the model | Place |
| Copy objects into another window by a reference point | Copy / Paste with Placement |
| Repeat objects along a curve | Curve Array |
| Repeat objects around a centre point | Radial Array |
| Repeat objects in a row or a grid | Rectangular Array |
| Make linked copies that follow every change to the original | Create Instance |
| Turn instances into normal, editable objects | Realize Instances |
| Give objects a colour or a physical material | Set Material |
| Copy a material so that you can edit the copy | Fork Material |
| Return objects to the default appearance | Remove Material |
| Add control points to a curve or surface | Subdivide |
| Lengthen an edge until it meets another edge | Complete Edge |

## Transform

Move, Rotate and Scale each show a gizmo at the selection's pivot and share the same options in the command dialog. Duplicate and Alternative Duplicate (for faces) open the Move gizmo too.

**Shared transform options**: orientation *Normal / Pivot / Construction Plane / World* and pivot *Bbox / Median / Active*. Pivots are stored with each object [25.1]{.ver}. The dialogs show XYZ colour chips, [Tab]{.key} enters an exact gizmo distance, and **Advanced › Transform Instances Inversely** moves only the parent while its instances stay put [26.1]{.ver}. In detail:

- **Orientation** – which way the gizmo's axes point:
  - **Normal** – aligned with the object's surface normal.
  - **Pivot** – matches the previously defined pivot orientation.
  - **Construction Plane** – aligned with the active construction plane.
  - **World** – aligned with the global (world) axes.
- **Pivot** – where the gizmo sits, and so the point the selection rotates and scales about. [V]{.key} lets you click a new position for the gizmo.
  - **Bbox** – the centre of the bounding box around all the selected objects.
  - **Median** – the average position of the selected objects' own pivots.
  - **Active** – the pivot of the last selected (active) object.
- **Advanced › Transform Instances Inversely** – transforms only the parent object. Plasticity applies the inverse transformation to each attached instance, so the instances stay where they are [26.1]{.ver}.

![](figures/c05-pivot.svg)

When you insert a box (Corner Box, Center Box), a cylinder, a rectangle, a circle or a regular polygon, the pivot is oriented along the surface normal at the point where you first place it [25.3]{.ver}. In Move, [W]{.key} cycles through the orientations; the Rotate and Scale pages describe [W]{.key} as switching the gizmo to world coordinates.

::: {.note .history title="Older versions: transform options"}
The 25.1 release notes, which introduced the choice of orientation and pivot, called them **Local**, **CPlane**, **World** and **Bounding Box**, **Median**, **Last Selected**. The 26.2 command pages use the names above.
:::

::: {.command name="Move" key="[G]{.key}" documented="1.3"}
Translates objects or sub-elements (faces, edges, CVs) with the Move gizmo. You can drag along one axis, in a plane or freely, type exact distances, or move from one picked point to another (Freestyle). Move is also how you shape a surface by its control points, with optional proportional and mirrored editing.

Before you start:

- Select what you want to move: whole objects, or faces, edges or control points in the matching selection mode (Control Point [1]{.key}, Edge [2]{.key}, Face [3]{.key}).
- Press [G]{.key}. Move can also start automatically when you select something (experimental; switch it off under Preferences › Commands) [26.2]{.ver}.

Step by step:

1. Select and press [G]{.key}. The Move gizmo appears at the pivot.
2. Drag a gizmo arrow (single axis) or drag freely. [X]{.key}, [Y]{.key} or [Z]{.key} locks an axis; [Shift+X]{.key}, [Shift+Y]{.key} or [Shift+Z]{.key} a plane; [G]{.key} the visible (screen) plane.
3. Hold [Ctrl]{.key} to snap. For an exact distance, type it in the **XYZ** fields or press [Tab]{.key} [26.1]{.ver}.
4. Confirm. Consecutive gizmo drags in the same direction add up to one running total [26.2]{.ver}.

**Move to the origin**: press [G]{.key}, then [F]{.key}, then right-click twice. To move it by a particular point instead: [G]{.key}, then [F]{.key}, click the point, then right-click.

Options explained:

- **XYZ** fields – exact movement per axis.
- **Orientation**, **Pivot**, **Advanced › Transform Instances Inversely** – see *Shared transform options* above.
- **Freestyle** [F]{.key} (also the *Freestyle Move* palette command) – move from a picked base point to a target: click a start point and an end point, which set the direction and distance.
- **Move Control Point** – when the selection is CVs on a surface, the dialog adds:
  - **Proportional** – None (only the selected CVs move), All (all CVs on the surface are affected) or Selected (proportional editing applied to the selected CVs). Falloff is measured along the hull (UV distance), not as a straight-line distance.
  - **Falloff U** / **Falloff V** – separate falloff amounts in the U and V directions, for All and Selected.
  - **Mirror** – None, X, Y or Z: mirrored CV moves relative to the active construction plane [25.1]{.ver}. Mirror settings are remembered, and with an axis-aligned construction plane mirrored moves use world axes [26.2]{.ver}.
- **Edges** – planar edges use the same options as Move. Moving edges of solids and sheets also supports circular edges on cylindrical and conical faces, keeping the analytic geometry [25.3]{.ver}: select a circular edge, press [G]{.key} and drag the gizmo.
- **Meshes** – mesh pivots can be moved and stored [25.3]{.ver}.

Keys:

- [G]{.key} start; [X]{.key}, [Y]{.key} or [Z]{.key} axis; [Shift+X]{.key}, [Shift+Y]{.key} or [Shift+Z]{.key} plane; [G]{.key} (inside the command) screen space.
- [F]{.key} Freestyle; [V]{.key} click to place the gizmo (pivot); [Alt+V]{.key} remove the pivots you have set; [W]{.key} change the orientation.
- [Ctrl]{.key} hold to snap; [Tab]{.key} exact gizmo distance [26.1]{.ver}.

Common problems:

- Move starts every time you select something → this is the experimental auto-start. Switch it off under Preferences › Commands [26.2]{.ver}.
- The gizmo axes do not point where you want to move → change **Orientation** ([W]{.key}), or use Freestyle ([F]{.key}) and pick two points.
- A second drag moved the object further than you expected → drags in the same direction accumulate into one total [26.2]{.ver}. Check the XYZ fields.
- You want to move a parent but not its instances → turn on **Advanced › Transform Instances Inversely** [26.1]{.ver}.
- When editing CVs proportionally the gizmo is not where you expect → the last active CV selection sets the pivot position.

Tips:

- Freestyle with snapping is the quickest way to put one exact point onto another, for example a corner onto a corner.
- With Snap to Grid on, the X (red), Y (green) and Z (blue) gizmo arrows snap to increment units along their axes, and the white circle (pivot centre) snaps to the absolute grid increments rather than moving the whole object incrementally [24.2]{.ver}.

Related:

Rotate, Scale, Mirror, Duplicate, Place.
:::

::: {.command name="Rotate" key="[R]{.key}" documented="24.1"}
Rotates objects with the Rotate gizmo; single-axis, screen-space or freestyle rotation; adjustable pivot. Use Freestyle when the axis is not one of the gizmo's axes, for example to turn a part about one of its own edges.

Before you start:

- Select the objects. Freestyle rotation also works on faces of solids and sheets [26.1]{.ver}.
- Press [R]{.key}.

Step by step:

1. Select and press [R]{.key}. The Rotate gizmo appears at the pivot.
2. Drag a ring of the gizmo, or type the angle. [X]{.key}, [Y]{.key} or [Z]{.key} constrains the rotation to that axis; [G]{.key} rotates in the visible plane.
3. A progress indicator shows how far you have rotated; consecutive gizmo drags in the same direction add up [26.2]{.ver}. Confirm.

Options explained:

- **Angle** – the last angle set with the gizmo, as a number; type a value to change it.
- **Axis** – the rotation axis as an X, Y or Z vector.
- **Orientation**, **Pivot**, **Advanced › Transform Instances Inversely** – see *Shared transform options*.
- **Freestyle** [F]{.key} (also *Freestyle Rotate* in the palette) – click the start and end of the rotation axis, then a reference point; move the cursor to rotate and click to set the angle. Snaps parallel and perpendicular to geometry. Works on faces of solids and sheets [26.1]{.ver}.

Keys:

- [R]{.key} start; [X]{.key}, [Y]{.key} or [Z]{.key} constrain to an axis; [G]{.key} screen space – rotate in the visible plane.
- [F]{.key} Freestyle; [V]{.key} pivot – click to reposition the gizmo; [W]{.key} world space – gizmo axes switch to world coordinates.

Common problems:

- The object swings around the wrong point → move the pivot with [V]{.key}, or change **Pivot** (Bbox, Median, Active).
- The axis you need is not on the gizmo → use Freestyle and click two points on the axis, for example the ends of an edge.

Tips:

- For a precise angle, start the rotation with the gizmo, then type the value in **Angle**.

Related:

Move, Scale, Mirror, Radial Array.
:::

::: {.command name="Scale" key="[S]{.key}" documented="24.1"}
Scales objects with the Scale gizmo; uniform, per-axis or freestyle; adjustable pivot. Scale works with factors (ratios): 2 doubles the size, 0.5 halves it. Freestyle can also scale to an exact length.

Before you start:

- Select the objects. Freestyle scale also works on faces of solids and sheets [26.1]{.ver}.
- Press [S]{.key}.

Step by step:

1. Select and press [S]{.key}. The Scale gizmo appears at the pivot.
2. Drag the gizmo handles or type factors. [X]{.key}, [Y]{.key} or [Z]{.key} constrains to an axis, [Shift+X]{.key}, [Shift+Y]{.key} or [Shift+Z]{.key} to a plane, and [S]{.key} scales uniformly in all three directions.
3. Confirm.

Options explained:

- **XYZ** – scale factors per axis. A scale of −1 on an axis mirrors an instance [25.3]{.ver}.
- **Orientation** (e.g. Normal – aligned to the surface normal), **Pivot** position and **Advanced › Transform Instances Inversely** – see *Shared transform options*.
- **Freestyle** [F]{.key} (also *Freestyle Scale*) – click the start and end of the scaling axis, move the cursor, then click at the desired ratio. Its dialog has:
  - **Ratio** – the scale ratio.
  - **Length** – the length of the scaled object.
  - **Uniform** – keeps proportions.

Keys:

- [S]{.key} start; [X]{.key}, [Y]{.key} or [Z]{.key} axis; [Shift+X]{.key}, [Shift+Y]{.key} or [Shift+Z]{.key} plane; [S]{.key} (inside the command) uniform.
- [F]{.key} Freestyle; [V]{.key} click to place the gizmo (pivot); [W]{.key} world coordinates.

Common problems:

- The object stretches in one direction only → it is constrained to an axis or plane. Press [S]{.key} for uniform scaling, or turn on **Uniform** in Freestyle.
- Scale does not follow the grid → turn on Snap to Grid: incremental snapping is respected when it is on [25.3]{.ver}.
- You need to grow a sheet by an exact margin → Scale uses factors, not distances. Use Extend Sheet or offset its outline instead.

Tips:

- To scale a part to a measured size, use Freestyle: click the two ends of a known dimension, then type the target in **Length**.

Related:

Move, Rotate, Mirror, Extend Sheet, Offset Curve (unified).
:::

::: {.command name="Mirror" key="[Alt+X]{.key}" documented="25.3"}
Mirrors objects with the Mirror gizmo; can slice along the mirror plane and merge the halves. The usual way to build a symmetric part is to model one half, then mirror it with **Cut down mirror plane** and **Union halves** on. With **Make instances**, the mirrored half follows every change you make to the original.

![](figures/c05-mirror.svg)

Before you start:

- Select the objects to mirror. Mirror also handles meshes and instances [25.3]{.ver}.
- Press [Alt+X]{.key}, or click the Mirror button in the Suggested Commands menu.

Step by step:

1. Select and press [Alt+X]{.key}. The Mirror gizmo appears.
2. Choose the direction: with the gizmo; with [X]{.key}, [Y]{.key} or [Z]{.key} towards the positive axis; or with [Shift+X]{.key}, [Shift+Y]{.key} or [Shift+Z]{.key} towards the negative axis. You can also click a flat face, or a curved face (plane tangent to it at that point), to set the mirror plane.
3. Set **Cut down mirror plane**, **Union halves** and **Make instances** as needed, then confirm.

Options explained:

- **Cut down mirror plane** – splits the target at the mirror plane first. Use it when the object crosses the plane. The docs do not say which piece is then mirrored, so check the preview.
- **Union halves** ([Q]{.key}) – joins original and mirror into one body.
- **Make instances** ([I]{.key}) – the mirrored half becomes an instance of the original instead of an independent copy [26.1]{.ver}.
- **Freestyle** [F]{.key} (also *Freestyle Mirror*) – click start and end points to define the plane.

Keys:

- [Alt+X]{.key} start; [X]{.key}, [Y]{.key} or [Z]{.key} positive direction; [Shift+X]{.key}, [Shift+Y]{.key} or [Shift+Z]{.key} negative direction.
- [F]{.key} Freestyle; [Q]{.key} Union halves; [I]{.key} Make instances [26.1]{.ver}.

Common problems:

- The copy is on the wrong side → use the other direction: [Shift]{.key} with the axis key gives the negative side.
- The result is two bodies → turn on **Union halves** ([Q]{.key}).
- The object crosses the mirror plane and the copy overlaps it → turn on **Cut down mirror plane** and check the preview.

Tips:

- On a curved face, the mirror plane is perpendicular to the face's normal and touches the face where you click.
- Mirroring with **Make instances** gives live symmetry while you design: changes to the original show in the mirrored half at once (official Create Instance page). Realize Instances turns the half into a normal body later.

Related:

Move, Rotate, Scale, Create Instance, Realize Instances.
:::

## Duplicate, place and array

::: {.command name="Duplicate" key="[Shift+D]{.key}" documented="25.2"}
Copies the selection and opens the Move gizmo straight away to position the copy, with the XYZ fields and the usual Move keys. It works on objects and groups, and also on faces, edges, regions and PolySpline CVs, which makes it a quick way to pull geometry out of a body. The copy is an independent object: later changes to the original are not passed on to it (compare *Duplicate, instance or asset?* below).

Before you start:

- Select the objects, or the faces, edges or regions to copy. Groups can be selected in the Outliner.
- Press [Shift+D]{.key}.

Step by step:

1. Select and press [Shift+D]{.key}. The copy is made and the Move gizmo appears.
2. Drag the gizmo, type values in the **XYZ** fields, or use the Move keys below. Confirm.

Options explained:

- **XYZ** – how far the copy moves along each axis.

Keys:

- [Shift+D]{.key} start; [X]{.key}, [Y]{.key} or [Z]{.key} axis; [Shift+X]{.key}, [Shift+Y]{.key} or [Shift+Z]{.key} plane; [G]{.key} screen space.
- [F]{.key} Freestyle (start point to end point); [V]{.key} click to place the gizmo (pivot); [Alt+V]{.key} remove the pivots you have set; [W]{.key} change the orientation.

Common problems:

- Duplicated faces carry extra edges (surface lines) → duplicating faces that carry surface lines keeps the raw surface data; redundant topology is no longer removed. Use Delete Redundant Topology if needed [26.2]{.ver}.
- Several regions became one shape → duplicating multiple regions produces a single combined shape.

Tips:

- Duplicating a group in the Outliner duplicates all its children recursively [25.2]{.ver}.
- Duplicate the edges of a sheet to recreate its boundary as curves.
- Duplicate also copies selected PolySpline CVs; if they lack support geometry they are rebuilt into a valid PolySpline topology [26.2]{.ver}.
- For many evenly spaced copies, an array is quicker than repeated Duplicate.

Related:

Alternative Duplicate, Place, Copy / Paste with Placement, Rectangular Array, Create Instance.
:::

::: {.command name="Alternative Duplicate" key="[Alt+D]{.key}" documented="24.2"}
Context-dependent copy: curves → a copy projected onto the current construction plane; faces → copied out as a new body; solids and sheets → outline curves (Project Outline). The result depends entirely on what you select, so it is three tools on one key.

Before you start:

- For curves and outlines, set the construction plane you want to project onto first: the new curves are created on the current construction plane.
- Select curves, faces, or solids or sheets. Alternative Duplicate is also in the Command Palette.

Step by step:

1. Select the geometry and press [Alt+D]{.key}.
2. What happens next depends on the selection:
   - **Curves** – the curves are projected onto the current construction plane along its normal direction, as new curves (see *What a planar projection changes* below).
   - **Faces** – a new body is created from the faces (the official page calls it a solid), keeping their name and material [24.2]{.ver}. The Move gizmo appears, so you can move it away at once.
   - **Solids or sheets** – their outlines are projected onto the active construction plane as curves (Project Outline).
3. Confirm.

Options explained:

- **XYZ** (faces) – how far the new body moves along each axis.

Keys:

- With faces, the Move keys apply: [X]{.key}, [Y]{.key} or [Z]{.key} axis; [Shift+X]{.key}, [Shift+Y]{.key} or [Shift+Z]{.key} plane; [G]{.key} screen space; [F]{.key} Freestyle; [V]{.key} gizmo position; [W]{.key} world coordinates.

Common problems:

- The projected curves are not where you expected → they are always created on the current construction plane. Set the plane first, or move the curves afterwards with the Move gizmo.
- The projected curve is shorter, has different angles or has a sharp point → the projection flattens the curve; see the note below.
- Copying faces out fails or gives a poor body → success depends on the complexity of the faces; simpler face selections are more reliable.

Tips:

- Use the curve case to get a flat, plan-view copy of a 3D curve, and the solid case to get a silhouette for drawings or a cutting profile.

Related:

Duplicate, Project Outline · Create Outline · Duplicate Curve and Project, Project Curve-Body, Offset Curve (unified).
:::

::: {.note title="What a planar projection changes"}
The official page says the projection "flattens the original geometry onto the plane while preserving the curve's overall shape and continuity". That is true of the plan view, the shape you see when you look straight down the plane's normal. It is not true of the 3D measurements (general theory of parallel projection):

- **Lengths** stay the same only for parts that already lie parallel to the plane. Everything else becomes shorter: a 100 mm line tilted 30° out of the plane projects to 100 × cos 30° ≈ 86.6 mm.
- **Angles and curvature** change unless the curve lies in a plane parallel to the construction plane. A circle in a tilted plane becomes an ellipse, and a curve's radius of curvature changes from point to point.
- **Continuity**: a smooth curve stays smooth where its tangent is not parallel to the projection direction. Where the tangent is parallel to it, the projected curve can get a sharp point (cusp) or turn back on itself, so a G1 curve can lose G1.
- **Degenerate cases**: a straight line along the normal becomes a point; a curve that lies in a plane containing the normal becomes a line segment, with any loops folded onto each other.

Check the result in plan view and, if it matters, measure it or compare curvature combs before you build on it.
:::

::: {.command name="Place" key="[Ctrl+D]{.key}" documented="1.3"}
Copies objects and places them at a picked location. You click a reference point on the original, then click destinations; each click puts a copy there. While placing you can scale, rotate and flip the copy, make instances, and combine the copy with the body underneath through a Boolean operation. This makes Place a quick kitbashing tool: screws, vents and other details dropped onto a model, or cutters placed and subtracted in one step. Dragging an asset into the viewport starts Place automatically [26.2]{.ver}.

![](figures/c05-place.svg)

Before you start:

- Select the objects to copy.
- Press [Ctrl+D]{.key}, or run *Place* from the Command Palette.

Step by step:

1. Select, press [Ctrl+D]{.key}.
2. Click the reference point on the object you are copying.
3. Click the reference point of the destination; a copy is placed there. Before confirming you can press the keys below to scale, rotate, flip or Boolean the copy.
4. Click to confirm.
5. Keep clicking to place more copies (repeat steps 3 and 4); press [Esc]{.key} to finish.

Options explained:

- **Scale** ([S]{.key}) – allows scaling.
- **Angle** ([A]{.key}) – allows rotation.
- **Flip** ([F]{.key}) – flips the duplication axis.
- **Axis** ([X]{.key}, [Y]{.key} or [Z]{.key}) – sets the duplication axis to the X, Y or Z axis.
- **Offset** ([D]{.key}) – the docs describe it only as "allows consecutive duplication".
- **Make instances** ([I]{.key}) – the copy is an instance instead of an independent copy [26.1]{.ver}.
- **Boolean** – what happens with the body you place onto (the Boolean target):
  - **Union** ([Q]{.key}) – joins target and copy.
  - **Difference** ([W]{.key}) – removes the copy from the target.
  - **Intersect** ([Shift+E]{.key}) – keeps only the overlap.
  - **Slice** ([Shift+Q]{.key}) – creates a solid at the intersection and keeps the remaining solids.
  - **New body** ([B]{.key}) – no Boolean; the copy is a new solid.
- Mesh and instance objects can be placed (meshes: vertex and face snaps) [26.1]{.ver}; instances support every snap point [26.2]{.ver}.

Keys:

- [Ctrl+D]{.key} start; [S]{.key} scale; [A]{.key} rotate; [F]{.key} flip; [X]{.key}, [Y]{.key} or [Z]{.key} axis; [D]{.key} offset; [I]{.key} instances.
- [Q]{.key} union; [W]{.key} difference; [Shift+E]{.key} intersect; [Shift+Q]{.key} slice; [B]{.key} new body; [Esc]{.key} finish.

Common problems:

- The copy lands offset from where you clicked → the copy's reference point goes onto the destination point. Pick a meaningful reference point on the original, such as the centre of its base.
- Few snap points on a mesh or instance → meshes snap to vertices and faces only. For instances, the 26.1 notes list only face and edge snaps; the 26.2 notes and the Create Instance page say instances support all snap points.

Tips:

- To cut the same hole in many places, place a cylinder with **Difference** ([W]{.key}) and keep clicking.

Related:

Duplicate, Copy / Paste with Placement, Create Instance.
:::

::: {.command name="Copy / Paste with Placement" key="[Ctrl+Shift+C]{.key} (copy), [Ctrl+Shift+V]{.key} (paste)" version="1.3"}
Copy with a base point, paste at a target point. It works like Place split into two steps, so the copy and the paste can happen in different Plasticity windows: for example, copy a part from a library file and paste it into your model.

Before you start:

- Open both windows if you are copying between files.
- Copy with Placement does not work with meshes or instances.

Step by step:

1. Select the objects, press [Ctrl+Shift+C]{.key} and click the reference point on the object you are copying.
2. To paste into a different window, switch to that window.
3. Press [Ctrl+Shift+V]{.key} and click the destination reference point. Use the keys below to flip, scale, rotate or Boolean the copy.
4. Right-click to confirm.
5. To paste more copies, click further destination points and confirm again; press [Esc]{.key} to exit.

Options explained:

- While pasting, the same options as in Place: **Flip** ([F]{.key}), **Axis** ([X]{.key}, [Y]{.key} or [Z]{.key}), **Scale** ([S]{.key}), **Angle** ([A]{.key}), **Offset** ([D]{.key}, consecutive duplication) and the Boolean choices Union ([Q]{.key}), Difference ([W]{.key}), Intersect ([Shift+E]{.key}), Slice ([Shift+Q]{.key}) and New body ([B]{.key}).

Keys:

- [Ctrl+Shift+C]{.key} copy with placement; [Ctrl+Shift+V]{.key} paste with placement; [Esc]{.key} exit.
- While pasting: [F]{.key}, [X]{.key}, [Y]{.key}, [Z]{.key}, [S]{.key}, [A]{.key}, [D]{.key}, [Q]{.key}, [W]{.key}, [Shift+E]{.key}, [Shift+Q]{.key}, [B]{.key}.

Common problems:

- Copy with Placement does not work on a mesh or an instance → this is a documented limitation. Use Place within one window, or realize the instances first.
- Materials were lost when pasting into a new window → inherited materials are preserved when pasting into a newly opened scene window [26.1]{.ver}.

Tips:

- Pick the same kind of reference point every time (for example the centre of the mounting face), so parts land consistently.
- The 24.2 notes say the Copy and Paste command inherits the name and material of the original [24.2]{.ver}; they do not say whether this covers the *with Placement* variants.

Related:

Place, Duplicate, Realize Instances.
:::

### How array counts work {-}

The array pages describe **Number** (Curve Array, Rectangular Array) and **Number 2** (Radial Array) as "the number of duplications", and **Repeat** (Rectangular Array, second direction) as "the number of repetitions". They do not say whether the original object is counted. Watch the preview, or count the objects in the Outliner after you confirm. The examples below are arithmetic for both readings: A = the number counts every item including the original; B = the number counts only the new copies.

| Example (pure arithmetic) | Reading A | Reading B |
|---|---|---|
| Rectangular, Spacing, Distance 1 = 10 mm, Number = 5 | 5 items, last centre 40 mm from the original | 6 items, last centre 50 mm from the original |
| Same, part 6 mm wide: total extent | 40 + 6 = 46 mm | 50 + 6 = 56 mm |
| Rectangular, Extent, Distance 1 = 100 mm, Number = 5 (if the last item sits at the distance) | pitch 100 ÷ 4 = 25 mm | pitch 100 ÷ 5 = 20 mm |
| Rectangular grid, Number = 5, Repeat = 3 | 5 × 3 = 15 items | 6 × 4 = 24 items |
| Radial, Spacing, Degrees = 30, Number 2 = 4 | items at 0°, 30°, 60°, 90° | items at 0° to 120° |
| Radial, Total, Degrees = 360, Number 2 = 6 (spread evenly round a full circle) | pitch 360 ÷ 6 = 60° | pitch 360 ÷ 7 ≈ 51.4° |

![](figures/c05-arrays.svg)

::: {.command name="Curve Array" documented="25.2"}
Copies objects along a path curve, with optional twist and scale. You set the number of copies; they are spread along the curve and can turn with it, keep their orientation, or follow it without flipping. Use it for chain links, rivets along a seam or posts along a path.

Before you start:

- Select the objects to copy. Images, meshes (.OBJ, .STL and similar) and instances can be arrayed too [25.3]{.ver}.
- You need a curve to use as the path.
- Curve Array has no default key: run it from the Command Palette or the Suggested Commands menu.

Step by step:

1. Select the objects, run Curve Array, pick the path curve. A preview of the copies appears.
2. Set the number of copies with **Number**, or add and remove copies with the mouse wheel (see Keys).
3. Set **Alignment**, **Twist**, **Scale** and **Extent** as needed, then confirm.

Options explained:

- **Number** – "the number of duplications" (see *How array counts work* for whether the original is counted).
- **Twist** – twist along the curve, in degrees.
- **Scale** – scale factor along the curve.
- **Alignment** – how the copies are oriented:
  - **Parallel** – copies keep their original orientation, ignoring the curve's rotation.
  - **Normal** – copies are aligned to the path (the curve's local normal frame).
  - **Transport** – a stable frame that follows the curve without twisting or flipping, for complex paths [26.1]{.ver}.
- **Extent** and **Method** – how far the copies extend or retract along the path [25.2]{.ver}:
  - **Distance** – Extent is a length, in the units set in your preferences.
  - **Ratio** – Extent is a ratio between 0.00 and 1.00 (default 1.00).
- **Make instances** ([I]{.key}) – the copies are instances instead of independent copies [25.3]{.ver}.

![](figures/c05-curve-array.svg)

Keys:

- [Shift+Wheel up]{.key} adds a copy; [Shift+Wheel down]{.key} removes one; [I]{.key} make instances.

Common problems:

- Copies flip or twist suddenly along a 3D path → use **Transport** alignment [26.1]{.ver}.
- The copies do not reach the end of the curve → check **Extent**: with Ratio, 1.00 is the default.
- All copies point the same way although the path bends → **Parallel** is on; choose **Normal**.

Related:

Radial Array, Rectangular Array, Create Instance, Sweep.
:::

::: {.command name="Radial Array" documented="1.4"}
Copies objects, or faces of a body such as fillets [24.2]{.ver}, around a centre point with a live preview [24.1]{.ver}. You set the number of copies and the angle: a full circle of bolts on a flange, spokes of a wheel, or a fillet repeated around a hub.

Before you start:

- Select the objects, or faces of a body. Instances, meshes and images can be arrayed too [25.3]{.ver}.
- Run Radial Array from its button in the Command Bar, or from the Command Palette. It has no default key.

Step by step:

1. Select, run Radial Array, click the centre point. The preview appears.
2. Set the count and angle, or add and remove copies with the mouse wheel (see Keys).
3. Choose **Mode** and the other options, then confirm.

Options explained:

- **Mode** [24.2]{.ver}:
  - **Total** – the copies are spread evenly over the total angle given in **Degrees** (the page says "total distance", but the value is the Degrees field).
  - **Spacing** – **Degrees** is the fixed spacing between copies.
- **Degrees** – the angle.
- **Number 2** – "the number of duplications" (see *How array counts work*).
- **Number 1** – "the number of repetitions in a radial pattern"; **Step 1** – "the distance between each repetition in a radial pattern". The page does not say how Number 1 differs from Number 2, or whether Step 1 is a length or an angle. Watch the preview when you change them.
- **Make instances** ([I]{.key}) – the copies are instances instead of independent copies [25.3]{.ver}.

Keys:

- [Shift+Wheel up]{.key} adds a copy; [Shift+Wheel down]{.key} removes one; [I]{.key} make instances.

Common problems:

- The copies circle the wrong point → you set the centre with your click. Restart and snap ([Ctrl]{.key}) to the exact centre, for example of a circular edge.
- The copies are much closer together or further apart than expected → check **Mode**: in Total mode Degrees is the angle all copies share, in Spacing mode it is the angle between neighbouring copies.

Tips:

- Radial Array and Rectangular Array remember the last count you used [1.4]{.ver}.

Related:

Rectangular Array, Curve Array, Rotate, Create Instance.
:::

::: {.command name="Rectangular Array" documented="1.4"}
Copies in a linear pattern, optionally in a second direction for a grid. Use it for rows of holes, grilles, keyboard keys or tiles. Like Radial Array, it can array faces of a body [24.2]{.ver}.

Before you start:

- Select the object(s) or faces. Instances, meshes and images can be arrayed too [25.3]{.ver}.
- Run Rectangular Array from its button in the Command Bar, or from the Command Palette. It has no default key.

Step by step:

1. Select and run the command; a preview appears. [X]{.key}, [Y]{.key} or [Z]{.key} constrains the direction to an axis.
2. Click the first direction and set the options.
3. Optionally click **Select endpoint 2** and right-click the second direction. The command page says right-click here.
4. Confirm.

Options explained:

- **Mode** [24.2]{.ver} (the 24.2 notes call the first mode *Extend*):
  - **Extent** – copies spread evenly within the distance.
  - **Spacing** – the distance is the spacing between copies.
- **Distance 1** and **Number** – distance and "number of duplications" in the first direction.
- **Distance 2** and **Repeat** – distance and "number of repetitions" in the second direction (see *How array counts work*).
- **Make instances** ([I]{.key}) – the copies are instances [25.3]{.ver}.

Keys:

- [X]{.key}, [Y]{.key} or [Z]{.key} constrain to an axis; [Shift+Wheel up]{.key} adds a copy; [Shift+Wheel down]{.key} removes one; [I]{.key} make instances.

Common problems:

- The pattern is shorter or longer than planned → check **Mode**: Extent spreads the copies within the distance, Spacing puts that distance between each pair. Then check how the count is read (see *How array counts work*).
- Only one row appears → the second direction is optional; click **Select endpoint 2** to add it.

Tips:

- Use Extent when the overall size is fixed (copies across a panel), Spacing when the pitch is fixed (holes every 10 mm).

Related:

Radial Array, Curve Array, Duplicate, Create Instance.
:::

## Instances

### Duplicate, instance or asset? {-}

| | Duplicate (Duplicate, Place, arrays without Make instances) | Instance (Create Instance, or Make instances in Mirror, Place, arrays) | Asset (Toggle Asset, Assets panel) [26.2]{.ver} |
|---|---|---|---|
| What you get | An independent copy of the geometry | A copy that stores only its own transformation and material (colour for curves) and refers to the parent's geometry | A copy of an object from an asset pack (.plasticitypack), put into the scene with Place |
| Editable on its own? | Yes | No: read-only. Edit the parent, or use Realize Instances first | Yes: the Assets page describes changing an inserted asset and reverting it with Reload Asset |
| Depends on | Nothing | The parent object in the same file | The asset pack file; if you move or rename the pack, import it again |
| When the source changes | Not passed on | Every instance follows at once | Reload Asset (asset status "linked") reverts the asset to its original state. Whether changes to the pack reach placed assets is not documented |
| Breaking the link | – | Realize Instances | Not documented |
| Limits | – | Copy with Placement does not work on instances | – |

Sources: the Create Instance, Realize Instances and Duplicate pages, the Assets page and the 25.3 and 26.2 release notes. Whether a placed asset is itself an instance object is not documented; the Assets panel offers **Select All Instances of This Asset**, but this may only mean "copies".

::: {.command name="Create Instance" version="25.3"}
Unified command (Create Solid and Sheet Instance / Create Curve Instance): creates live instances of solids, sheets, curves and groups that reference the original. Edits to the parent propagate to all instances, keeping files light. An instance stores only its own transformation (position, pivot, rotation, scale) and material (colour for curve instances), and refers to the parent for its geometry. Use instances when you need many identical parts, such as fasteners or panels.

![](figures/c05-instances.svg)

Before you start:

- Select the solid or sheet, or the curve, to use as the parent; or select a group in the Outliner.
- Create Instance has no default key: run it from the Command Palette.

Step by step:

1. Select the parent.
2. Search for *Create Instance* in the Command Palette and run it. The command picks the variant from the selection (solids and sheets, or curves).
3. Move the new instance to where you want it, then confirm.

**Instancing a group**: select the group in the Outliner, run Create Instance, move the instanced group and confirm. The instance of the group is placed outside the group folder, under its own *Instances* category in the Outliner.

Options explained:

- The docs list no options for this command. Instances themselves are read-only copies of their parent: edit the parent, and every instance follows. Curve instances hide their CVs.

Common problems:

- You cannot edit an instance → instances are read-only. Edit the parent, or turn the instance into a normal object with Realize Instances.
- You cannot tell instances from normal objects → instances have medium to light grey surface edges. You can change this colour under Preferences › Appearance [26.2]{.ver}.
- Copy with Placement does not work on instances → a documented limitation; use Place or Duplicate instead.
- You want to move the parent but leave its instances where they are → turn on **Advanced › Transform Instances Inversely** in Move, Rotate or Scale [26.1]{.ver}.

Tips:

- Instances are exported by Export OBJ [25.3]{.ver}, can be made by the arrays [25.3]{.ver} and by Mirror and Place [26.1]{.ver}.
- Once you have one instance, you can duplicate it any number of times; all the duplicates still follow the parent.
- Mirror with **Make instances** gives live symmetry: a change to one half appears in the other.
- Instances support all snap points [26.2]{.ver}, and a scale of −1 on an axis mirrors an instance [25.3]{.ver}.

Related:

Realize Instances, Place, Mirror, Curve Array, Radial Array, Rectangular Array.
:::

::: {.command name="Realize Instances" version="25.3"}
Unified command (Realize Solid and Sheet Instances / Realize Curve Instances): converts instances into independent, editable bodies or curves. Realize instances when one copy must differ from the others, or before an operation that needs real geometry.

Before you start:

- Select the instances to convert (solid, sheet or curve instances), or an instanced group.
- Realize Instances has no default key: run it from the Command Palette.

Step by step:

1. Select the instances.
2. Search for *Realize Instances* in the Command Palette and run it.
3. The instances are converted into editable objects. Instanced groups are realized the same way.

Common problems:

- The scene becomes slow after realizing → realized bodies are real geometry and raise the computational load. Realize only the instances you need to edit.

Tips:

- After realizing, a copy no longer follows the parent: changes to the parent are not passed on to it.

Related:

Create Instance, Copy / Paste with Placement.
:::

## Materials

::: {.command name="Set Material" key="[M]{.key}" documented="1.3"}
Assigns a material to the selection; materials are listed in the **Materials** section of the left sidebar. Solids and sheets take the full material; curves are affected by colour and opacity only; for images, the material sets depth and opacity. A material set on a group is applied to every object in it.

Before you start:

- Select the solids, sheets or curves, or select a group in the Outliner.
- Press [M]{.key}.

Step by step:

1. Select the objects (or the group in the Outliner).
2. Press [M]{.key}. The material dialog opens.
3. Set the options, then confirm.

You can also drag a material from the **Used Materials** or **Materials Library** part of the Materials section onto an object in the viewport [25.3]{.ver}.

Options explained:

- **Color** – the base colour.
- **Roughness** – how rough the surface is (0 perfectly smooth, 1 very rough); **Metalness** – how metallic it looks (0 non-metallic, 1 fully metallic).
- **IOR** – index of refraction: how light bends through the material (1.0 air, 1.5 glass, 2.4 diamond).
- **Opacity** – how transparent or opaque the material is. Transparent materials are shown at 50 % transparency, even with default and custom matcaps [24.2]{.ver}.
- **Clearcoat** / **Clearcoat roughness** – an extra specular layer on top of the base material, and its roughness.
- **Specular color** / **Specular intensity** – colour and strength of the specular reflection.
- **Iridescence** / **Iridescence IOR** – strength of an iridescent thin-film effect, and the film's index of refraction.
- **Thickness** and **Transmission** – the material's thickness, and how much light passes through it.
- **Sheen** / **Sheen color** / **Sheen roughness** – a soft, velvet-like reflection near the edges, its colour and roughness.
- **Density** (Advanced) – used to calculate mass, shown per object in the Selection menu at the bottom right [26.1]{.ver}. The units are set in the Units section.
- **Physical materials** only:
  - **Texture scale** – the overall scale of the texture.
  - **Blending** – the triplanar projection blending: 0 blends the most, 7 not at all.
  - **Rotate X/Y/Z** – rotates the whole material about the world X, Y or Z axis.

Keys:

- [M]{.key} start.

Common problems:

- A physical material looks plain → turn on Render Mode; the shaders show only there.
- An unused material stays in the list → see *Removing a material from the list* under Remove Material.
- Materials look different after export → physical material properties are for visualisation in Plasticity and are not kept when you export a mesh or CAD file to other software.

Tips:

- Right-click a material › **Select All With This Material** [25.1]{.ver}.
- 34 physical (PBR) materials, visible in Render Mode [25.2]{.ver}, plus Cathedral Tile [25.3]{.ver}; searchable catalogue with previews [25.2]{.ver}.
- Hover a material to highlight its users; drag the material dot from the Outliner into the viewport [25.3]{.ver}.

Older versions:

- The 25.1–25.3 release notes call the material list the **Assets** menu or tab. In 26.2 it is the **Materials** section, and **Assets** is the asset-pack panel.

Related:

Fork Material, Remove Material.
:::

::: {.command name="Fork Material" key="[Shift+M]{.key}" version="25.2"}
Duplicates the material of the selected objects into a new editable material, listed in the Materials section. Use it to make a variation of an existing material without changing the original.

Before you start:

- Select the object whose material you want to fork.

Step by step:

1. Select the object.
2. Press [Shift+M]{.key}.
3. The material is duplicated and the copy can be edited, for example with Set Material ([M]{.key}).

Keys:

- [Shift+M]{.key} start.

Related:

Set Material, Remove Material.
:::

::: {.command name="Remove Material" key="[Alt+M]{.key}" documented="26.2"}
Removes the assigned material from the selected objects and resets them to the default material. It does not delete the material itself. For groups, right-click the group in the Outliner › **Remove material**.

Before you start:

- Select the objects. The command is also in the Suggested Commands menu.

Step by step:

1. Select the objects.
2. Press [Alt+M]{.key}. The material is reset to the default.

Keys:

- [Alt+M]{.key} start.

**Removing a material from the list**: materials cannot be removed from the **Used Materials** list. The docs say a material disappears from the list only after every object that references it has been deleted from the scene. They do not say whether removing the material from every object (with Remove Material, or by assigning another material) without deleting the objects also removes it from the list.

Related:

Set Material, Fork Material.
:::

## Curve and surface structure

::: {.command name="Subdivide" documented="25.3"}
Adds control points to selected curves and surfaces. More control points give you finer control over the shape, at the cost of a heavier curve or surface. The official page describes the result differently in two places, so check the CVs after each run.

Before you start:

- Select one or more curves or surfaces.
- Subdivide has no default key: run it from the Command Palette.

Step by step:

1. Select the curves or surfaces.
2. Type *Subdivide* in the Command Palette and run it. The docs list no options.
3. What the page says happens:
   - **Curves** – the CVs are "doubled", and the new CVs become selected.
   - **Surfaces** – degree and spans increase, and the surface stays selected. The page says the result "depends heavily on how the surface is constructed and how many spans and degrees there are".
4. Run it again to subdivide further.

Common problems:

- [Alt+S]{.key} does nothing → the default key was removed in 25.3. Use the Command Palette.
- The surface gains more or fewer control points than you expected → the result depends on how the surface is built. The docs disagree on surfaces: the page's description says the counts double each time; its steps say degree and spans increase "by one count more".

Tips:

- Add only as many CVs as you need: dense curves and surfaces are harder to keep smooth.
- To split a surface while keeping its CV layout, use **Isoparam** with **Subdivide** ([S]{.key}) instead.
- "Doubled" need not mean exactly twice the count. In general theory, inserting one knot in the middle of each span adds one CV per span, so a degree-3 curve with 4 CVs (1 span) would get 5 CVs, not 8. Count the CVs in your own model rather than assuming either.

Older versions:

- Before 25.3, Subdivide had the default key [Alt+S]{.key}; the 25.3 release notes say it was removed [25.3]{.ver}.

Related:

Raise Curve Degree, Raise Surface Degree, Rebuild Curve, Isoparam.
:::

::: {.command name="Complete Edge" documented="26.2"}
Extends a selected edge until it meets another edge. Use it, for example, when an edge you have added stops short inside a face.

Before you start:

- Edge mode ([2]{.key}). Select the edges to extend.
- Complete Edge has no default key: run it from the Command Palette or the Suggested Commands menu.

Step by step:

1. Select the edges.
2. Run *Complete Edge*.
3. The edges are extended until they meet another edge. The docs list no options.

Common problems:

- The edge is not extended → it can only be extended until it intersects another edge. The docs do not say which edges qualify.

Tips:

- Imprint Curve-Body (**Completion**) and Imprint Body-Body (**Complete target** / **Complete tool**) have their own options, which extend new edges while imprinting.

Related:

Imprint Curve-Body, Imprint Body-Body, Isoparam.
:::
