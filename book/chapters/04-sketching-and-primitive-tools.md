# Sketching and primitive tools {.pagebreak}

These tools create new geometry: curves drawn on a plane or on existing geometry, ready-made solids (sphere, box, cylinder), and measurements that check sizes and smoothness. Most of them need no selection: click the tool's button in the toolbar and start clicking points.

| I want to… | Use |
|--------------------------------|------------------|
| Draw straight segments joined end to end | Line |
| Draw a smooth curve through the points I click | Spline Curve |
| Draw a curve by placing its control points (CVs) | Control Point Curve |
| Draw a circle from its centre, its diameter or three points | Center · Two-Point · Three-Point Circle |
| Draw a circle that touches two or three curves | Tangent Circle |
| Draw an ellipse | Ellipse |
| Draw an arc from its centre, or through three points | Center-Point Arc · Three-Point Arc |
| Continue a curve with an arc that leaves it smoothly | Tangent Arc |
| Draw a triangle, hexagon or other regular polygon | Regular Polygon |
| Draw a helix, e.g. the path for a spring or thread | Spiral |
| Draw a rectangle or square | Corner · Center · Three-Point Rectangle |
| Turn typed text into curves | Text |
| Create a solid sphere, box or cylinder | Sphere, Corner · Center · Three-Point Box, Cylinder |
| Measure a length or distance | Measure Distance |
| Measure the radius of a round edge or curve | Measure Radius |
| Change a size by typing a new value | Dimension |
| Look inside a model without cutting it | Section Analysis |
| Check how smoothly two surfaces meet (G0, G1, G2) | Measure Continuity |
| Show curvature combs on curves and edges | Toggle Curvature |

All sketch tools draw on the active construction plane, or directly on geometry when you snap to it. The same in-tool controls apply to most tools in this chapter (exceptions are noted on the command cards):

| While drawing | Effect |
|-------------|-----------------------------------------------|
| [Tab]{.key} | Numeric input boxes on the live dimensions (lengths, radii, angles). Numeric fields in dialogs accept arithmetic (+ − × ÷); π and unit suffixes such as 2mm or 1in [25.2]{.ver}. |
| [X]{.key}, [Y]{.key} or [Z]{.key} | Constrains the cursor to that axis. |
| Tap [Shift]{.key} | While hovering an object, creates temporary snappable reference lines. |
| Snapping | Automatic while sketching when Object Snapping is on. A connected vertex changes colour from purple (to blue-green by default); a small dot also marks curve intersections in Control Point mode [26.1]{.ver}. [Shift+X]{.key} temporarily switches off the snap you are locked onto; press it again to step through the snap types [24.1]{.ver}. |
| Knife mode [K]{.key} | Drawing a curve that snaps to points on faces can cut those faces as you draw. |
| Auto pivot [25.3]{.ver} | Corner and Center boxes, cylinders, rectangles, Center, Two-Point and Three-Point circles, polygons and ellipses orient their pivot to the surface normal where they are first placed. |
| [Ctrl+C]{.key} in a field | Copies the value with up to 8 decimal places in the line, spline, circle, ellipse, arc, rectangle and primitive tools and in Dimension [26.1]{.ver}. |

```{=typst}
#v(4pt, weak: true)
```

Unless a card says otherwise, confirm a tool with OK in the command dialog or a right-click (see *Confirming, cancelling and repeating commands* in chapter 3). Closed or intersecting planar curves automatically form **Regions**, which can be extruded directly. Deleting a region also deletes the curves that bound it [25.1]{.ver}.

## Curves

::: {.command name="Line" key="[Shift+A]{.key}" documented="26.1"}
Draws straight line segments joined end to end (a polyline) – the usual start for mechanical profiles. Each click adds a segment; closing the outline on its first point gives a Region that you can extrude straight away.

Before you start:

- No selection is needed. Press [Shift+A]{.key} or click the Line button in the toolbar.
- Set the construction plane you want to draw on, or plan to snap onto existing geometry.

Step by step:

1. Click a start point (grid, vertex or object snap).
2. Move the cursor and click to add each segment. [Tab]{.key} types a length or angle; [X]{.key}, [Y]{.key} or [Z]{.key} locks an axis.
3. If a point lands in the wrong place, [Ctrl+Z]{.key} cancels the last click and you carry on drawing.
4. After the last point, right-click to finish the sequence. Closing on the first point creates a Region.

Keys:

- [Shift+A]{.key} start; [Tab]{.key} exact length or angle; [X]{.key}, [Y]{.key} or [Z]{.key} axis lock; [K]{.key} knife mode; [Ctrl+Z]{.key} cancel the last click; right-click finish.

Common problems:

- The closed outline does not become a Region → the last point did not snap exactly onto the first. Snap to the start point and check that the vertex changes colour from purple.
- The cursor keeps locking onto an unwanted snap → press [Shift+X]{.key} to step past it.

Tips:

- To keep every picked point on the construction plane, switch on **2D Snapping** in the Planes menu of the right sidebar. It needs an active construction plane [26.1]{.ver}.

Related:

Spline Curve, Control Point Curve, Corner · Center · Three-Point Rectangle, Trim, Fillet Curve · Fillet Vertex.
:::

::: {.command name="Spline Curve" documented="26.1"}
Smooth free-form NURBS curve fitted through the points you click – for organic outlines and curves that drive surfaces. The curve passes through every clicked point, and Plasticity works out the control points (CVs) for you. If you want to place the CVs yourself, use Control Point Curve instead.

![](book/figures/c04-spline-vs-cv.svg)

Before you start:

- No selection is needed. Click the Spline Curve button in the toolbar; there is no default key.

Step by step:

1. Click the start point of the curve.
2. Click successive points; the curve passes through them. [Ctrl+Z]{.key} cancels the last click.
3. After the last point, right-click to finish.
4. Refine the result via its CVs in Control Point mode ([1]{.key}).

Keys:

- [Tab]{.key} switches to Control Point Curve (instead of numeric input); [K]{.key} knife mode; [Ctrl+Z]{.key} cancel the last click; [X]{.key}, [Y]{.key} or [Z]{.key} axis lock.

Common problems:

- [Tab]{.key} does not open the numeric input boxes → in this tool [Tab]{.key} switches between through-points and control points. Snap to the grid or to existing geometry to place points exactly.
- The curve wobbles → there are too many points, or points too close together. Undo and redraw with fewer points.

Tips:

- Few, well-spaced points give smoother curves.
- Refine afterwards with Rebuild, Raise Degree and Slide, and check the shape with Toggle Curvature.

Related:

Control Point Curve, Rebuild Curve, Raise Curve Degree, Slide Curve CV, Toggle Curvature.
:::

::: {.command name="Control Point Curve" documented="26.1"}
Draws a curve by placing its control vertices (CVs) directly, instead of points the curve passes through. Gives cleaner CV layouts for surfacing. The curve starts at your first click; the other points pull the curve towards them but may not lie on it (diagram above).

Before you start:

- No selection is needed. Click the Control Point Curve button in the toolbar; there is no default key.

Step by step:

1. Click the starting point of the curve.
2. Click to place each CV; the curve follows the CV hull. [Ctrl+Z]{.key} cancels the last click.
3. After the last CV, right-click to finish the curve.

Keys:

- [Tab]{.key} switches back to Spline Curve; [K]{.key} knife mode; [Ctrl+Z]{.key} cancel the last click; [X]{.key}, [Y]{.key} or [Z]{.key} axis lock.

Common problems:

- The curve does not pass through the clicked points → that is how control points work. Use Spline Curve when the curve must go through each point.

Tips:

- Use as few CVs as the shape needs: a simple, even CV layout is easier to edit and gives smoother surfaces when the curve drives a Loft, Sweep or other surface.
- To see the CVs again later, switch to Control Point mode ([1]{.key}).

Related:

Spline Curve, Insert Knot (Insert CV at Point), Slide Curve CV, Rebuild Curve, Bridge Curve.
:::

::: {.command name="Center Circle · Two-Point Circle · Three-Point Circle" documented="1.4"}
Full circles from the centre and a size, from the two ends of a diameter, or through three rim points. A circle is a closed planar curve, so it becomes a Region that you can extrude. Choose the variant by what you know: the centre, the two ends of a diameter, or three points the circle must pass through.

![](book/figures/c04-circles.svg)

Before you start:

- No selection is needed. Click the matching button in the toolbar's circle group; none of the three has a default key.
- The circle orients its pivot to the surface normal where you first click (auto pivot) [25.3]{.ver}.

Step by step:

1. Run the variant.
2. Pick the defining points in order:
   - **Center Circle** – click the centre, then move the cursor to set the size and click.
   - **Two-Point Circle** – click one end of the diameter, then move the cursor and click the other end.
   - **Three-Point Circle** – click a point on the circumference, then a second one, then move the cursor to set the size and click the third.
3. Press [Tab]{.key} to type the size instead of clicking. Read the label of the input box first: the docs do not say whether it is a radius or a diameter (see *Radius or diameter?* at the start of this chapter).
4. Confirm; a single [Enter]{.key} or left-click also confirms [24.1]{.ver}.

Keys:

- [Tab]{.key} exact dimensions; [K]{.key} knife mode.
- [V]{.key} vertical/horizontal: tilts the circle relative to the construction plane (Center and Two-Point Circle).
- [X]{.key} or [Y]{.key} axis lock in Center Circle; [X]{.key}, [Y]{.key} or [Z]{.key} in Two-Point and Three-Point Circle.

Common problems:

- The circle stands up instead of lying on the plane → [V]{.key} has tilted it; press [V]{.key} again.
- A typed value gives a circle twice or half the expected size → the value was taken as the other of radius and diameter. Undo, and type double or half the value.

Tips:

- Dimension values are shown while you draw Two-Point and Three-Point circles [1.4]{.ver}.
- Three-Point Circle is handy for fitting a circle to existing geometry: snap the three points to existing vertices.
- To change the size later, select the circle in Edge mode and use Dimension ([=]{.key}); the Dimension page says it edits the circle's diameter.

Related:

Tangent Circle, Ellipse, Center-Point Arc · Three-Point Arc, Dimension, Measure Radius.
:::

::: {.command name="Tangent Circle" version="1.4"}
Circle tangent to two existing curves or edges, or to three [24.1]{.ver}. Use it for round features that must touch existing outlines exactly, for example a boss that sits between two walls.

Before you start:

- You need the curves or edges the circle should touch. No selection is needed beforehand; click the Tangent Circle button in the toolbar (no default key).

Step by step:

1. Run Tangent Circle. The command dialog shows *Select first curve segment*.
2. Click the first curve or edge when it is highlighted, then the second. Optionally click a third one to make the circle tangent to all three.
3. Move the cursor to set the size; the circle follows the cursor and stays tangent.
4. Press [Tab]{.key} to type the size in the **Radius** field, or [F]{.key} to freeze the circle while you reposition the cursor.
5. Confirm.

Options explained:

- **Select first curve segment / Select second curve segment** – click each curve segment when it is highlighted.
- **Radius** – the circle size. The field is labelled Radius, but the official page describes it as "Specify the diameter". Check the preview after typing.
- An inline radius input is shown during creation, so you can see and round the value [26.1]{.ver}.

Keys:

- [Tab]{.key} goes to the **Radius** field; [F]{.key} **Freeze** stops the circle following the cursor so you can reposition it – useful when you need to flip the side the circle leads towards while dragging.

Common problems:

- A typed size gives no circle → only some sizes can touch both curves. The inline input shows the current value, so you can round it from there.
- The circle jumps to the wrong side → press [F]{.key}, move the cursor to the side you want, then carry on.

Tips:

- Tangent circles and arcs have their own hover snaps [24.1]{.ver}.

Related:

Center Circle · Two-Point Circle · Three-Point Circle, Tangent Arc, Fillet Curve · Fillet Vertex.
:::

::: {.command name="Ellipse" version="25.3"}
Draws an ellipse from its axes (major and minor), with precise control. You place the centre, then set the radius of one axis and then the other. Like a circle, the closed ellipse becomes a Region.

Before you start:

- No selection is needed. Click the Ellipse button in the toolbar; there is no default key.
- The ellipse orients its pivot to the surface normal where you first click (auto pivot) [25.3]{.ver}.

Step by step:

1. Run Ellipse.
2. Pick the centre.
3. Move the cursor to set the radius and direction of the first axis (major or minor) and click; [Tab]{.key} for exact values.
4. Move the cursor to set the other axis and click. The command page describes steps 3 and 4 as one "adjust the size and click"; the official demo sets one axis, then the other.
5. Confirm.

Keys:

- [Tab]{.key} exact dimensions; [K]{.key} knife mode; [X]{.key} or [Y]{.key} axis lock.

Tips:

- Tan/Tan snapping works on ellipses and general splines [25.1]{.ver}, which helps when you draw lines tangent to them.
- For a true circle, use Center Circle: it is simpler and can be resized with Dimension.

Related:

Center Circle · Two-Point Circle · Three-Point Circle, Tangent Circle, Offset Curve (unified).
:::

::: {.command name="Center-Point Arc · Three-Point Arc" documented="24.1"}
Partial circles: centre + start + end, or through three points. Use Center-Point Arc when you know where the centre is (for example a rounded end around a hole), and Three-Point Arc when the arc must join two existing points.

![](book/figures/c04-arcs.svg)

Before you start:

- No selection is needed. Click the matching button in the toolbar's circle and arc group; neither has a default key.

Step by step:

**Center-Point Arc**

1. Click the centre of the arc.
2. Move the cursor and click the first point on the circumference. This sets the radius and where the arc starts; [Tab]{.key} for exact values.
3. Move the cursor to sweep the arc to its end and click. The live dimension shows the angle.

**Three-Point Arc**

1. Click the first point on the circumference.
2. Move the cursor and click the second point; [X]{.key}, [Y]{.key} or [Z]{.key} locks an axis.
3. Move the cursor and click the third point; [Tab]{.key} for exact values. The page does not say which click is which; in the official demo video the first two clicks are the ends of the arc and the third sets how far it bulges.

Keys:

- [Tab]{.key} radius or angle; [X]{.key}, [Y]{.key} or [Z]{.key} axis lock; [K]{.key} knife mode (listed for Center-Point Arc).

Common problems:

- [Tab]{.key} does nothing at the start of Three-Point Arc → the command page offers numeric input for the last point, after the first two clicks.

Tips:

- A single [Enter]{.key} or left-click confirms the arc [24.1]{.ver}.
- To make an arc that continues a line without a kink, use Tangent Arc instead.

Related:

Tangent Arc, Center Circle · Two-Point Circle · Three-Point Circle, Fillet Curve · Fillet Vertex, Trim.
:::

::: {.command name="Tangent Arc" version="1.4"}
Arc tangent to an existing curve. It leaves the curve without a kink, so it is the quickest way to continue a line with a smooth bend, or to link two curves with an arc that is tangent to both (right-hand panel of the diagram above).

Before you start:

- You need the curve the arc should start from. No selection is needed beforehand; click the Tangent Arc button in the toolbar (no default key).

Step by step:

1. Run Tangent Arc and click the curve the arc should be tangent to (optionally a second tangent curve).
2. Move the cursor to set the size of the arc. To end on a second curve, move to it until the tangent snap appears.
3. Shape the arc with the keys below and click to finish.

Keys:

- [D]{.key} flips the direction; [N]{.key} constrains to the normal, [B]{.key} to the binormal; [X]{.key}, [Y]{.key} or [Z]{.key} locks an axis.

Common problems:

- The tangent point does not appear → the tangent detection is sensitive. Move the cursor slowly near the point you want without crossing over it; crossing it can stop the tangent point from showing.
- The arc bends the wrong way → press [D]{.key}.

Tips:

- Tangent circles and arcs have their own hover snaps [24.1]{.ver}.

Related:

Center-Point Arc · Three-Point Arc, Tangent Circle, Bridge Curve, Fillet Curve · Fillet Vertex.
:::

::: {.command name="Regular Polygon" documented="24.1"}
N-sided regular polygon: triangle, square, hexagon and so on, with all sides equal. Like any closed planar curve it becomes a Region, ready to extrude into a nut, a prism or a cut-out.

Before you start:

- No selection is needed. Click the Regular Polygon button in the toolbar (the command reference calls it *Polygon*); there is no default key.
- The polygon orients its pivot to the surface normal where you first click (auto pivot) [25.3]{.ver}.

Step by step:

1. Pick the centre.
2. Move the cursor to a corner: this sets the size and rotation. [Tab]{.key} for exact values.
3. Set the number of sides with [Shift+Wheel]{.key}, or with [Up]{.key} or [Down]{.key}, and press [C]{.key} or [V]{.key} if needed (see below).
4. Click, then right-click to confirm.

Options explained:

- **Number of sides** – [Shift+Wheel up]{.key} or [Up]{.key} adds a vertex; [Shift+Wheel down]{.key} or [Down]{.key} removes one. The tool remembers the last vertex count [24.2]{.ver}.
- **Circumscribed / inscribed** ([C]{.key}) – switches between the two ways of sizing the polygon. In the usual drafting sense, an inscribed polygon has its corners on the size circle and a circumscribed one has its sides touching it. The docs do not say which is the default, so check the preview.
- **Vertical / horizontal** ([V]{.key}) – tilts the polygon relative to the construction plane.

Keys:

- [Tab]{.key} exact dimensions; [Shift+Wheel]{.key}, or [Up]{.key} or [Down]{.key}, number of sides; [C]{.key} circumscribed/inscribed; [V]{.key} vertical/horizontal; [K]{.key} knife mode; [X]{.key} or [Y]{.key} axis lock.

Tips:

- Because it remembers the last vertex count, a series of hexagons needs setting only once.
- Offers a Centre snap point [24.2]{.ver} for placing holes or other features in the middle.

Related:

Center Circle · Two-Point Circle · Three-Point Circle, Corner · Center · Three-Point Rectangle, Extrude.
:::

::: {.command name="Spiral" documented="26.2"}
Spiral/helical curve – e.g. a path for springs or threads with Sweep or Pipe. You draw the spiral's axis and its size, then set the number of turns, the pitch and the direction of rotation in the dialog.

Before you start:

- No selection is needed. Click the Spiral button in the toolbar; there is no default key.

Step by step:

1. Click the start point of the spiral's axis.
2. Move the cursor and click the end point of the axis; [X]{.key}, [Y]{.key} or [Z]{.key} locks an axis.
3. Move the cursor to set the size of the spiral and click.
4. Refine parameters in the dialog, use the keys below, or drag the yellow dots and the white circle in the viewport.
5. Confirm.

Options explained:

- **Turns** – the number of rotations.
- **Radius** – the size of the spiral. The field is labelled Radius, but the official page describes it (and the [R]{.key} key) as setting the diameter; check the preview.
- **Angle** or **Pitch** – how steeply the spiral climbs. The two values are linked: changing one changes the other.
- **Handedness** – reverses the direction of rotation (left- or right-handed).

Keys:

- [A]{.key} angle by moving the mouse; [D]{.key} length of the axis by moving the mouse; [R]{.key} size by moving the mouse; [X]{.key}, [Y]{.key} or [Z]{.key} axis lock.

Common problems:

- The pitch changed when you edited the angle → Angle and Pitch are linked; set the one you need last.
- A thread turns the wrong way → switch **Handedness**.

Tips:

- For a spring, sweep or pipe a small circle along the spiral. Pipe is the quicker route when the profile is a simple circle.
- For any helix, axis length = pitch × turns: 5 turns at a pitch of 2 need an axis 10 long. The docs do not say whether Plasticity's Pitch is the rise per turn, or which value it keeps when you change another.

Related:

Pipe, Sweep, Line.
:::

::: {.command name="Corner · Center · Three-Point Rectangle" documented="24.1"}
Rectangles by diagonal, by centre + corner, or by three points (any orientation). The result is a Region ready to extrude. Corner Rectangle is the everyday choice; Center Rectangle keeps the shape centred on a point; Three-Point Rectangle lets the first side run in any direction, for example along a sloping edge.

![](book/figures/c04-rectangles.svg)

Before you start:

- No selection is needed. Click the matching button in the toolbar's rectangle group; none of the three has a default key.
- The rectangle orients its pivot to the surface normal where you first click (auto pivot) [25.3]{.ver}.

Step by step:

1. Run the variant and pick the points:
   - **Corner Rectangle** – click a corner, move the cursor to the opposite corner and click.
   - **Center Rectangle** – click the centre, move the cursor to a corner and click.
   - **Three-Point Rectangle** – click a corner, click a second point (this sets the first side and its direction), then move the cursor to set the width and click.
2. [Tab]{.key} for width and height.
3. Right-click to confirm; a single [Enter]{.key} or left-click also confirms [24.1]{.ver}.

Keys:

- [Tab]{.key} width and height; [K]{.key} knife mode.
- [C]{.key} switches between Corner and Center Rectangle while drawing; [S]{.key} restricts to a square (both).
- [X]{.key}, [Y]{.key} or [Z]{.key} axis lock (Three-Point Rectangle).

Common problems:

- The rectangle should be centred on a point → press [C]{.key} while drawing to switch to Center Rectangle.
- The rectangle has to follow an angled edge → use Three-Point Rectangle and snap the first two points to that edge.

Tips:

- To change the size later, select the rectangle's edges and use Dimension ([=]{.key}): it edits the lengths of the two sides.

Related:

Corner · Center · Three-Point Box, Line, Dimension, Extrude.
:::

::: {.command name="Text" documented="24.2"}
Converts typed text into curves in a chosen font. Use the curves for lettering that you extrude, emboss, engrave or project onto a body.

Before you start:

- No selection is needed. Text has no toolbar button: run it from the Command Palette.

Step by step:

1. Run Text from the Command Palette. The text is placed at the origin of the XY plane, 1 cm high by default.
2. Type the text and choose font and size in the command dialog.
3. Confirm. The text curves are created.
4. Move, rotate or scale the curves into place.

Options explained:

- **Text box** – the text to create.
- **Font** – one of the built-in fonts; more fonts were added in 24.2 [24.2]{.ver}.
- **Size** – the font size.

Common problems:

- Your own font is not in the list → only the built-in fonts are available; installing custom fonts is currently not possible.
- The text is not where you are working → it always starts at the origin of the XY plane. Move it afterwards.

Tips:

- For raised or engraved lettering, extrude the letters and combine them with the body (union or difference), or imprint them onto a face with Imprint Curve-Body.

Related:

Extrude, Imprint Curve-Body, Deform Curve, Move.
:::

## 3D primitives

::: {.command name="Sphere" documented="1.3"}
Solid sphere. You place the centre and set the size; while the command is open you can also combine the new sphere with an existing body, as with Boolean.

Before you start:

- No selection is needed. Click the Sphere button in the toolbar; there is no default key.

Step by step:

1. Click the centre, then move the cursor to set the size ([Tab]{.key} for an exact value) and click.
2. Adjust the size if needed: drag the yellow dot, press [D]{.key} and move the cursor, or type in the **Radius** field.
3. To combine the sphere with another body, choose the target and the operation (see below).
4. Confirm.

Options explained:

- **Select target bodies** – a body for the new sphere to be combined with. It works as in the Boolean command.
- **Radius** – the size of the sphere. The field is labelled Radius, but the official page says it (and [D]{.key}) sets the diameter; check the value in the preview.

Keys:

- [Tab]{.key} exact size; [D]{.key} size by moving the cursor; [X]{.key}, [Y]{.key} or [Z]{.key} axis lock.
- Combining with the target, as in Boolean and Extrude: [Shift+Q]{.key} Slice, [Q]{.key} Union, [W]{.key} Difference, [Shift+E]{.key} Intersect, [B]{.key} New Body, [T]{.key} Keep Tools.

Common problems:

- The sphere merged with, or cut, another body → a target and operation were set. Press [B]{.key} (New Body) for a separate solid.

Tips:

- Dimension values are shown while you create the sphere [1.4]{.ver}, and new spheres get a default name [1.3]{.ver}.
- Spherical faces offer a **Center** snap point when X-ray mode is on [25.3]{.ver}.
- To change the diameter later, select the sphere in Body mode and use Dimension ([=]{.key}).

Related:

Corner · Center · Three-Point Box, Cylinder, Boolean, Dimension.
:::

::: {.command name="Corner · Center · Three-Point Box" documented="1.3"}
Solid box: draw the base like the matching rectangle, then the height. As with Sphere, the new box can be combined with an existing body while the command is open.

Before you start:

- No selection is needed. Click the matching button in the toolbar's box group; none of the three has a default key.
- Corner and Center Box orient their pivot to the surface normal where you first click (auto pivot) [25.3]{.ver}.

Step by step:

1. Draw the base ([Tab]{.key} for sizes), as with the rectangle tools (diagram in the rectangle card):
   - **Corner Box** – click a corner, then the opposite corner.
   - **Center Box** – click the centre, then a corner.
   - **Three-Point Box** – click a corner, click a second point on the base, then move the cursor to set the base size and click.
2. Drag or type the height and click.
3. Adjust if needed: type in the dialog fields; for Corner and Center Box you can also drag the yellow dots or press [H]{.key} for the height.
4. To combine the box with another body, choose the target and the operation (see below).
5. Confirm.

Options explained:

- **Select target bodies** – a body for the new box to be combined with, as in Boolean.
- **Width**, **Length**, **Height** – the box dimensions.

Keys:

- Base: [Tab]{.key} exact sizes (Corner and Center Box); [C]{.key} switches between Corner and Center Box; [S]{.key} restricts to a square base (Corner and Center Box); [X]{.key}, [Y]{.key} or [Z]{.key} axis lock (Three-Point Box).
- Height: [H]{.key} height by moving the cursor (Corner and Center Box; the Three-Point Box page lists only the axis locks).
- Combining with the target: [Shift+Q]{.key} Slice, [Q]{.key} Union, [W]{.key} Difference, [Shift+E]{.key} Intersect, [B]{.key} New Body, [T]{.key} Keep Tools.

Common problems:

- The box merged with, or cut, another body → a target and operation were set. Press [B]{.key} (New Body) for a separate solid.

Tips:

- Example: for a 40 × 20 × 10 block (in your current units), draw a Corner Box, type 40 and 20 for the base and 10 for the height. Check it with Measure Distance on one edge in each direction.
- Dimension values are shown while you create the box [1.4]{.ver}, and new boxes get a default name [1.3]{.ver}.
- To change the three side lengths later, select the box in Body mode and use Dimension ([=]{.key}).

Related:

Corner · Center · Three-Point Rectangle, Cylinder, Sphere, Boolean, Extrude, Dimension.
:::

::: {.command name="Cylinder" documented="1.3"}
Solid cylinder. You draw the base circle, then the height; as with the other primitives, the new cylinder can be combined with an existing body while the command is open – for example to cut a round hole with Difference.

Before you start:

- No selection is needed. Click the Cylinder button in the toolbar; there is no default key.
- The cylinder orients its pivot to the surface normal where you first click (auto pivot) [25.3]{.ver}.

Step by step:

1. Click the centre of the base circle and move the cursor to set its size ([Tab]{.key} for an exact value, [V]{.key} to tilt the base).
2. Click, then move the cursor to set the height and click.
3. Adjust if needed: drag the yellow dots, press [F]{.key} (size of the base) or [D]{.key} (height), or type in the dialog fields.
4. To combine the cylinder with another body, choose the target and the operation (see below).
5. Confirm.

Options explained:

- **Select target bodies** – a body for the new cylinder to be combined with, as in Boolean.
- **Radius** – the size of the base circle. The English page says this field (and [F]{.key}) sets the diameter; the German and Japanese pages say the radius. Check the value in the preview.
- **Height** – the length of the cylinder.

Keys:

- Base: [Tab]{.key} exact size; [V]{.key} vertical/horizontal, tilting the base relative to the construction plane; [X]{.key}, [Y]{.key} or [Z]{.key} axis lock.
- Height stage: [F]{.key} size of the base by moving the cursor; [D]{.key} height by moving the cursor.
- Combining with the target: [Shift+Q]{.key} Slice, [Q]{.key} Union, [W]{.key} Difference, [Shift+E]{.key} Intersect, [B]{.key} New Body, [T]{.key} Keep Tools.

Common problems:

- The cylinder lies on its side → [V]{.key} has tilted the base; press it again.
- The cylinder merged with, or cut, another body → press [B]{.key} (New Body) for a separate solid.

Tips:

- Example: an 8-wide hole through a plate 10 thick. Start the cylinder on the plate's top face, enter 4 if the **Radius** field takes a radius or 8 if it takes a diameter, make it taller than 10 (going through the plate), select the plate as target and press [W]{.key} (Difference).
- Cylinders can be resized with Dimension [24.1]{.ver}: select the cylindrical face in Face mode and press [=]{.key}.
- Dimension values are shown while you create the cylinder [1.4]{.ver}, and new cylinders get a default name [1.3]{.ver}.

Related:

Center Circle · Two-Point Circle · Three-Point Circle, Extrude, Boolean, Dimension, Measure Radius.
:::

## Measuring and analysis

### Dimension, measurements and constraints {-}

Three different features deal with sizes and relationships. Keep them apart:

- **Dimension** ([=]{.key}) *changes* a size once: you type a new value and the geometry is modified. The docs describe no lasting link between the value and the geometry, so do not expect later edits to keep the size you typed.
- **Measurements** (Measure Distance, Measure Radius, Toggle Curvature, Measure Continuity) only *read* the geometry. Each one is stored in the Outliner under *Measurements* and updates when the measured object changes, but it never drives the shape.
- **Constraint System** [26.2]{.ver} [STUDIO]{.studio} keeps a *relationship* live: commands such as Square, Surface Align, Project Align, Vertex Align and Bridge Curve can create constraints, so connected geometry updates together. Constraints currently are not saved in the project file; they last only for the current session. See https://doc.plasticity.xyz/plasticity-essentials/constraint-system.

::: {.command name="Measure Distance" key="[Ctrl+=]{.key}" version="1.4"}
Measures sizes and distances between curves, edges or snap points – for example the side of a rectangle curve or the diameter of a cylinder. A measurement placed towards an axis gives the distance along that axis of the construction plane; confirming with a right-click gives the straight-line distance between two points. Measurements are kept in the Outliner (*Measurements*) and update when the measured object is moved or changed.

Before you start:

- No selection is needed. Press [Ctrl+=]{.key} or run *Measure Distance* from the Command Palette.
- Values follow the axes of the active construction plane. To measure along another direction, create a construction plane that matches it first.

Step by step:

**One edge or curve** (e.g. the side of a box)

1. Press [Ctrl+=]{.key} and click the edge or curve.
2. Move the cursor towards the axis you want and click to place the dimension.

**Two points**

1. Press [Ctrl+=]{.key} and click the first snap point (vertex, mid-point, centre and so on).
2. Pick the second point, then place the result as an axis distance or a direct distance (below). The page describes the distance "between two points" but does not list the second pick as a step of its own.

**Axis-projected distance** – after picking, move the cursor towards a construction-plane axis and left-click. The value is the distance along that axis only.

**Direct distance** – after picking, right-click when confirming instead. The value is the straight-line distance between the two points.

After placing, the value stays in the viewport and a measurement is added to the Outliner under *Measurements*. To reposition it, select it in the Outliner and press [G]{.key} to move it along its axis.

Keys:

- [Ctrl+=]{.key} start; left-click place along an axis; right-click when placing gives the straight-line distance; [G]{.key} on a measurement selected in the Outliner moves it.

Common problems:

- The value is along the wrong direction → the dimension follows the construction-plane axis you move towards. Move the cursor the other way, right-click for the straight-line distance, or change the construction plane.

Tips:

- Select a measurement in the Outliner and use Move to type exact values [24.2]{.ver}.
- Values copy to the clipboard in your units [24.2]{.ver}.
- The measurements panel at the lower right shows the angle between two edges [24.1]{.ver} and between two planes and the surface class of faces [24.2]{.ver}.
- Arrowheads at dimension ends [25.3]{.ver}; custom measurement colour under **Preferences › Appearance › Measurement Color** [26.1]{.ver}.
- Measurement points are snap targets [24.2]{.ver}, and *Select All Measurements* selects every visible measurement [25.2]{.ver}.

Related:

Measure Radius, Dimension, Measure Continuity.
:::

::: {.command name="Measure Radius" version="25.3"}
Measures radial geometry – edges of cylinders, cones and similar shapes, or sketch curves. The result goes to the Outliner (*Measurements*) as a radius annotation marked **R**.

Before you start:

- No selection is needed. Run *Measure Radius* from the Command Palette or the toolbar; there is no default key.

Step by step:

1. Run Measure Radius and click the radial edge of the solid, or the sketch curve.
2. Move the mouse to set the length of the annotation line, then click the left or right mouse button to confirm.
3. The value appears next to the **R** symbol, and the measurement is added to the Outliner under *Measurements*.

Tips:

- Use it to check what a size field really took (see *Radius or diameter?* at the start of this chapter).
- To change a radius rather than read it, use Dimension: it edits the diameter of circles, arcs, cylinders and spheres, and the size of fillets.

Related:

Measure Distance, Dimension, Cylinder.
:::

::: {.command name="Dimension" key="[=]{.key}" version="1.4"}
Edits an object's dimensions directly: select, type the new value, the geometry updates. It is the quickest way to correct a size after drawing, without rebuilding the shape. It changes the geometry once; it does not create a lasting rule (see *Dimension, measurements and constraints* above).

Before you start:

- Select the object in the selection mode that matches what you want to change:
  - the two side lengths of a rectangle curve, or the diameter of a circle or arc curve → Edge mode ([2]{.key});
  - the diameter of a cylinder, the size of a fillet, or the distance between two faces of a solid → Face mode ([3]{.key});
  - the diameter of a sphere, or the three side lengths of a box → Body mode ([4]{.key}).
- Press [=]{.key} or run *Dimension* from the Command Palette.

Step by step:

1. Select the object and press [=]{.key}. The current dimensions are displayed.
2. Press [Tab]{.key} to enter dimension input mode and type the new value.
3. If there are several dimensions, press [Tab]{.key} to move to the next one and type its value.
4. Press [Enter]{.key} to confirm.

Keys:

- [=]{.key} start; [Tab]{.key} input mode and next dimension; [Enter]{.key} confirm.

Common problems:

- No dimension appears → the object is not one Dimension supports, or it was selected in the wrong mode. Check the list under *Before you start*.

Tips:

- Example: to turn a 40 × 20 rectangle into 50 × 20, select its edges in Edge mode, press [=]{.key}, [Tab]{.key}, type 50 and press [Enter]{.key}.
- Works on cylinders [24.1]{.ver} and on individual line segments [25.2]{.ver}.
- Fields accept arithmetic; π and unit suffixes from 25.2 [25.2]{.ver}, so you can type, for example, *40 + 2mm*.

Related:

Measure Distance, Measure Radius, Corner · Center · Three-Point Rectangle, Cylinder.
:::

::: {.command name="Section Analysis" version="25.1"}
Virtual slice through the model to inspect its interior – a display tool, the geometry is not cut. Part of the model is hidden on one side of a section plane, so you can check wall thickness, internal parts and whether components are aligned or interfere.

Before you start:

- To place the plane on a face, select that face first.
- Run Section Analysis (Command Palette, or the button in the View Mode menu at the top right of the viewport).

Step by step:

1. Select a face to define the section plane (or choose another **Plane** option in step 3).
2. Run Section Analysis (Command Palette or View Mode menu).
3. Position the section: choose the **Plane**, then set the **Distance** (or press [D]{.key} and move the cursor) and use **Flip** ([F]{.key}) to show the other side.
4. Confirm; the slice stays visible while you inspect.
5. To turn it off, click the Section Analysis button again or run the command again from the Command Palette.

Options explained:

- **Plane** – where the section plane comes from:
  - **Selection** – the selected face of the object.
  - **Previous** – the previous placement. The first placement is saved, so this brings it back.
  - **CPlane** – the active construction plane.
- **Distance** – moves the section plane.
- **Flip** – reverses the direction of the section plane, so the other side of the model is hidden.

Keys:

- [D]{.key} moves the section plane by moving the cursor; [F]{.key} flips its direction.

Tips:

- Interfering objects are highlighted in red.
- Works on meshes (STL, FBX, OBJ) [25.3]{.ver}.
- Section hatching in Export Hidden Line [26.1]{.ver}: its *Section Hatching* method hatches only the faces cut by Section Analysis.
- **Section** snap points where curves and edges cross the section plane [26.2]{.ver}, so you can draw exactly on the cut.

Related:

Export Hidden Line, Measure Distance.
:::

::: {.command name="Measure Continuity" version="25.2"}
Checks whether two adjoining surface edges meet with G0, G1 or G2 continuity (G3 not supported). It draws *continuity combs* – deviation plots along the joint – and reports a value with a pass/fail marker. These are not the curvature combs of Toggle Curvature, which show how much one curve bends. The result is an interactive measurement: it stays in the Outliner and updates live while you edit the surfaces [25.3]{.ver}.

Before you start:

- Select two adjacent, touching surface edges (Edge mode, [2]{.key}).
- Run Measure Continuity from the Command Palette or the toolbar; there is no default key.

Step by step:

1. Select two adjacent, touching surface edges.
2. Run Measure Continuity.
3. Choose the **Continuity** level to check ([Tab]{.key} cycles G0, G1 and G2) and read the value and the markers along the edge.
4. Confirm. A G0, G1 or G2 continuity measurement is stored in the Outliner under *Measurements*.

Options explained:

- **Continuity** – the level checked and the value reported:
  - **G0** – position: the positional deviation, in your units.
  - **G1** – tangency: the angular deviation between the surfaces, in degrees.
  - **G2** – curvature: the curvature deviation, as a normalised value from 0.0 to 1.0.
- **G0 / G1 / G2 Scale** – in the Curvature panel of the right sidebar [25.3]{.ver}. The Measure Continuity page and the 25.3 release notes describe these as the visual scale (size) of the continuity combs and deviation plots. The Surface Align page calls its Analysis G0 / G1 / G2 Scale "tolerance scales for respective continuity checks". The docs give no tolerance values and do not say that any scale control changes whether a check passes.
- **Show maxes** [25.3]{.ver} – in the same panel; displays the numerical deviation values and continuity markers along the edge.
- **Continuity markers** – show whether the measured deviation is within tolerance:
  - green tick – within tolerance;
  - yellow tick – a G2 special case: a value of 1.0 is reported as "flat" (one surface has an infinite radius in that direction). It is an exception, not an error; check it visually with a shader;
  - yellow warning – the chosen level is within tolerance but a lower level is not (for example G1 passes but G0 fails), so the joint does not pass;
  - red cross – out of tolerance.

Keys:

- [Tab]{.key} cycles G0, G1 and G2.

Common problems:

- G1 or G2 passes but the joint is marked with a warning → a lower level fails. Fix G0 (the edges must touch) first.
- G2 shows 1.0 "flat" → one surface is flat in that direction. Judge the joint with a zebra or curvature shader.
- The combs are hard to see → change **G0 / G1 / G2 Scale**. Judge pass or fail from the value and the marker, not from the comb size.

Tips:

- Keep the measurement visible while you move CVs or use Slide, and watch the values change.
- The same check is built into the Align tool [25.2]{.ver}.

Related:

Toggle Curvature, Surface Align (Edge Align), Bridge Surface, Slide Surface CV; *Surface quality* (chapter 10).
:::

### Exercise: G0 passes, G1 fails {-}

This exercise shows a joint that is in position but not tangent. No measured values are printed here; record the ones you see.

1. Create a Corner Box, for example 40 × 20 × 10.
2. In Face mode select the top face and one side face, and separate them from the box with Unjoin Faces ([Alt+J]{.key}), so that two pieces meet along the shared edge.
3. Select the two edges along that joint and run Measure Continuity.
4. With **Continuity** on G0, record the value and the marker. The two faces share the edge, so expect a deviation close to zero and a green tick.
5. Press [Tab]{.key} to switch to G1, and record the value and the marker. The faces meet at 90°, so geometry predicts an angular deviation of about 90° and a red cross.
6. Turn on **Show maxes**, adjust **G1 Scale** until the comb is readable, and record whether the value or the marker changes with the scale.
7. Switch the viewport to a zebra shader (Shader Mode panel). At a crease the stripes are expected to break; record what you see.

 Whether step 2 gives two separate sheets that Measure Continuity accepts, and the actual values, still need recording in 26.2.0 (with screenshots of the combs and zebra stripes).

::: {.command name="Toggle Curvature (Measure Curvature)" version="25.2"}
Displays curvature combs on curves and surface edges to judge smoothness. Each comb line stands perpendicular to the curve; its length shows how sharply the curve bends there (longer line, tighter bend: curvature = 1 / radius). The line joining the tips shows how the curvature changes along the curve. Curvature combs describe one curve's bending; to measure how two surfaces meet, use the continuity combs of Measure Continuity.

![](book/figures/c04-curvature-comb.svg)

Before you start:

- Select the curves or surface edges to check. With edges selected the command shows surface curvature; with curves, curve curvature.
- Run *Toggle Curvature* from the Command Palette ([F]{.key}) or click its toolbar button.

Step by step:

1. Select the curve or surface edge.
2. Run Toggle Curvature. White comb lines appear, with a red line joining their tips.
3. Adjust the comb size in the Curvature panel of the right sidebar (**Comb scale**).
4. A curvature measurement is added to the Outliner under *Measurements*; toggle its display there [25.3]{.ver}.

Options explained:

- **Comb scale** – the display size of the combs (default 0.1). Drag left or right in the field, or type a value. It changes only how long the lines are drawn, not the curve.
- **Autosize** [26.2]{.ver} – the button next to the field resizes the combs to suit the current viewport zoom.

Common problems:

- The combs are too small or too large → press the autosize button, or change **Comb scale**.
- No comb appears on part of a curve → that part is straight: its curvature is zero, so there is nothing to show.
- An older Plasticity version opens the file without your curvature checks → files from 25.3 open in earlier versions, but existing curvature measurements are removed.

Tips:

- Live feedback while you edit (e.g. with Slide) [25.3]{.ver}.
- Reading the comb: on a planar curve, equal line lengths mean a constant radius – a circular arc (a 3D curve such as a helix can have constant curvature without being an arc); lines that flip to the other side mark an inflection (S-bend); a sudden jump, usually at an edit point or where two curves meet, means the curves do not share curvature (not G2) and can show as an uneven highlight.
- Across a joint between two curves the combs show the continuity level (diagram below): at G0 the comb breaks at a kink, at G1 the combs meet but their lengths can differ, at G2 they meet with the same length.
- For surfaces, the **Curvature** analysis shader in the Shader Mode panel colours the whole surface (Gaussian, Mean or Max) [26.2]{.ver}.

![](book/figures/c04-continuity-combs.svg)

Older versions:

- Introduced as *Measure Curvature* in 25.2; renamed *Toggle Curvature* in 25.3, when it also got its own panel in the right sidebar.

Related:

Measure Continuity, Slide Curve CV, Rebuild Curve, Bridge Curve; *Surface quality* (chapter 10).
:::
