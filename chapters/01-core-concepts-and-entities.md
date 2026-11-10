# Core concepts and entities

::: {.note title="How to read this guide"}
Each tool has a card with its default key. Under the opening lines that say what the tool is for, a card can have these sections: **Before you start** (selection mode, what to select, how the tool starts), **Step by step** (what to do and what you see), **Options explained** (the options the official docs describe, and what each value does), **Keys**, **Common problems** (symptom → fix), **Tips**, **Older versions** (earlier defaults and behaviour) and **Related** tools. A card leaves out a section when the docs say nothing for it. Diagrams show options and results that are easier to see than to read. Keys in [violet]{.key} are the defaults from the official keymap; a dash (–) means no default key – run it from the Command Palette ([F]{.key}). [STUDIO]{.studio} = Studio licence required.

**Version labels.** [26.1]{.ver} means the release notes of that version announce the feature, option or key as new or changed. [24.2]{.doc} means it is available, but its introduction is unknown; the label gives the earliest release notes or documentation that mention it (26.2 = the current manual). A label next to an option refers to that option only. *Verified in* labels would mark behaviour tested in the application; nothing in this edition has been tested.

**Claim labels.** Text in the normal card sections is officially documented. **Tips** are general modelling advice unless they cite the docs ([ADVICE]{.advice} marks advice elsewhere). *Sources and accuracy notes* at the end of the guide list the sources.

macOS users: modifier keys may differ from the Windows/Linux keys shown. Open the Command Palette to see the binding on your system; you can right-click any entry there to reassign it.
:::

```{=typst}
#v(4pt, weak: true)
```

## What Plasticity is

Plasticity is a CAD modeller for artists and designers. Instead of polygon meshes it builds exact curves, surfaces and solids, so models stay precise and smooth at any zoom level and can be exported to manufacturing (STEP) or to render and game pipelines (meshes). The interface keeps clutter low with context-sensitive widgets and pop-up panels, and uses key bindings and selection modes familiar to Blender users.

This guide uses Plasticity 26.2.0 as its reference and draws on the release notes of 1.3 (09/10/2023), 1.4 (18/12/2023), 2024.1 (05/03/2024), 2024.2 (05/09/2024), 2025.1 (25/02/2025), 2025.2 (10/07/2025), 2025.3 (15/12/2025), 2026.1 (16/04/2026) and 2026.2 (19/10/2026). Installers exist for Windows, macOS and Linux; *Compatibility* in chapter 10 lists what the docs say about licences and operating systems.

| Release | Highlights from its release notes |
|-------|-----------------------------------------------------|
| **1.3** | New: Copy/Paste with Placement, Project Outline, Create Outline, Thicken Face, radial menus, STL import. Mentioned as existing: Move, Place, Box/Cylinder/Sphere, OBJ/STL export, Rebuild Curve. |
| **1.4** | New: Tangent Circle, Tangent Arc, Measure, Dimension, Offset Vertex. Mentioned as existing: circles, Radial and Rectangular Array. |
| **2024.1** | XNurbs (Studio); Rebuild Face, Extend Sheet, Toggle Points, Raise Surface Degree, Remove Nominal Surface; STEP export options; live Radial Array; Untrim can create holes; Extend Curve on whole curves. |
| **2024.2** | Square (Studio), Deform, Reverse; Explicit Control in Rebuild; 3MF import/export, SVG import; autosave; midplane construction plane. |
| **2025.1** | New UI; Slide; Section Analysis; Square Free continuity; Square/XNurbs Adjacent and Tension; transform orientation and pivot options; proportional CV moves; Suggested Commands on [Shift+F]{.key}. |
| **2025.2** | Align for surfaces (Studio; now Edge Align), Measure Continuity, Measure Curvature, Fork Material, Unlock All; Boolean Region; Render Mode gains HDRI choice, ground shadows and 34 physical materials; Topography and Face direction shaders (first called Topology and Normal Checker); π and units in fields. |
| **2025.3** | Instances (Create/Realize), Measure Radius, Ellipse, Export SVG, Publish to Plasticity Share; Toggle Curvature; new OBJ export options; more languages. |
| **2026.1** | PolySplines (Studio), Export Hidden Line, Slot; Align for curves (now Vertex Align); Outliner search and Active Collection; 2D snapping on construction planes; Arcball rotation; material density; default keys [Tab]{.key} → [5]{.key} and [Tab]{.key} → [S]{.key}. |
| **2026.2** | Align renamed **Edge Align** (Collinear solver, Skew boundary, partial-alignment gizmo, keys [B]{.key} and [P]{.key}); Project Align and the Constraint System (Studio); Assets (asset packs); Home View; Toggle Images/Meshes/Constraints; Curvature shader; Section and YZ/XZ snaps, snaps on instances; .plasticity import brings meshes, images and instances; Move on selection (experimental). |

The docs describe no feature history: you change a model by running further commands on its geometry. Chapter 10, *Practical workflows*, explains direct modelling, editability and persistence.

```{=typst}
#v(4pt, weak: true)
```

## NURBS in a nutshell

### Geometry, topology and B-rep {-}

Plasticity bodies are **boundary representations (B-rep)**: a body is described by the faces that bound it. A B-rep has two layers (general theory):

- **Topology** – which pieces exist and how they connect: faces, the edges that bound them, the vertices where edges end, and which faces share each edge.
- **Geometry** – the exact shape of each piece: the surface under each face, the curve under each edge, the point at each vertex.

The geometry under a face or edge is either **analytic** (plane, cylinder, cone, sphere; line, circle) or **spline** (NURBS). So not everything is stored as NURBS. The docs show both kinds: Raise Surface Degree "converts analytic surfaces to spline", STEP export has an option to convert analytic surfaces to NURBS, and Move keeps "the analytical geometry" of cylindrical and conical faces when it moves their edges. Free-form curves you draw and free-form faces are NURBS.

- **Surface and face.** A *surface* is the full mathematical surface. A *face* uses only part of it, bounded by its edges; when the boundary does not follow the surface's own borders, the face is *trimmed* (for example after a Boolean). Untrim ([Alt+T]{.key}) recovers the full surface as a sheet.
- **Faces and solid.** Faces that touch, or even enclose a space, are not yet a solid. A body is a solid only when its faces are joined along shared edges into a closed boundary with no gaps (general theory). Otherwise it is a sheet, with open edges.

### Exact shape, tolerance and display {-}

Four different things are often called "precision" (general theory, except where a release note is cited):

- **Mathematical geometry** – the exact definition of a curve or surface (a circle of radius 10, a NURBS with given CVs and knots). It does not depend on zoom.
- **Numerical precision** – the computer stores numbers in floating point, so values are exact only to a limited number of digits. From 26.1, input fields copy values with up to 8 decimal places [26.1]{.ver}.
- **Modelling tolerance** – the distance under which the modelling kernel treats two points, edges or faces as touching. Operations such as joining or Booleans depend on it. The docs do not publish Plasticity's tolerance values. The 25.2 notes link viewport clipping to "unit scale or very small scene tolerances".
- **Viewport tessellation (faceting)** – the screen shows a triangle mesh made from the exact geometry. Faceted edges on screen do not mean the model is faceted. The faceting preference ("Ultra" from 24.1 [24.1]{.ver}) changes only this display mesh; from 25.3 it applies without restarting, to new and edited bodies [25.3]{.ver}. Mesh exports (OBJ, STL) are tessellations too, with their own settings.

```{=typst}
#v(12pt, weak: true)
```

### Curves and surfaces {-}

| Concept | Meaning | Why it matters in Plasticity |
|---------|-------------------------|--------------------------|
| NURBS | Non-Uniform Rational B-Spline: a curve or surface defined by control points, their weights and a knot vector, blended by piecewise polynomial functions. | Free-form curves and faces are NURBS. Both NURBS and analytic geometry are exact, not faceted. |
| Control Vertex (CV) | A point that pulls the shape towards it. A curve usually passes through its end points but not through interior CVs. | Edit CVs in Control Point mode ([1]{.key}); the hull lines show the sequence of CVs. |
| Degree and order | Degree = highest power of the polynomial pieces: 1 linear, 2 quadratic, 3 cubic, 5 quintic. **Order = degree + 1**, the number of CVs that shape each span. | Raise Degree ([Shift+S]{.key}) and Rebuild set it. Degree 3 is the usual CAD choice. |
| Span and knot | A curve is made of spans joined at knots. Knot spacing and multiplicity set how smoothly spans join. | Insert Knot adds a CV; Rebuild controls the span count. |
| Weight | Each CV of a rational NURBS has a weight: a higher weight pulls the curve closer to that CV. Weights let NURBS describe exact circles and other conics. | Different from the **Weight** option of Rebuild Curve (see below). |
| Surface (U/V) | A surface is a grid of CVs in two directions, U and V. Lines of constant U or V are isoparms. | Isoparam ([Ctrl+R]{.key}) splits faces along U/V; Square/XNurbs give explicit U/V control. |
| Continuity | How smoothly two curves or surfaces meet: G0 position, G1 tangent, G2 curvature, G3 rate of change of curvature. | Bridge, Square, XNurbs and Bridge Surface let you choose the continuity of the result. |

```{=typst}
#v(6pt, weak: true)
```

- **Degree is not smoothness.** A higher degree gives each span more freedom, and at a simple knot a degree-*d* curve can be continuous up to its (*d* − 1)-th derivative, so degree 3 or more is needed for curvature-continuous (G2) joins inside one curve. But a high-degree curve with badly placed CVs can still wobble, and higher degrees cost more computation (docs, NURBS Overview).
- **More spans are not less smooth.** Spans add local control and data. Within one curve, spans with simple knots join as smoothly as the degree allows; a curve gets uneven because of its CV layout, not because of its span count. Fewer, well-placed CVs are usually easier to keep fair [ADVICE]{.advice}.
- **Adding CVs need not change the shape.** In NURBS theory, knot insertion and degree elevation add CVs while keeping the curve or surface exactly as it was. The Raise Degree page says it adds CVs and may add spans; neither it nor Insert Knot says whether the shape stays exactly the same.
- **Two kinds of weight.** The rational weight above is a property of each CV. The **Weight** field of [Rebuild Curve]{.cmd} (Explicit Control, [25.1]{.ver}) is a fitting setting: lower values loosen the shape for smoother surfacing, higher values keep it closer to the original (default 0.5). The 25.2 Selection panel shows whether a selected surface is rational [25.2]{.ver}.
- **Continuity levels include each other.** A G2 join is also G1 and G0. G0 means only that the ends meet; it *allows* a corner but does not *require* one. The docs list G0–G3 for curves and G0–G2 for surfaces.

![](figures/c01-continuity.svg)

## Entities (object types)

Plasticity groups everything you can select into Sketch, Body (Solid/Sheet), Image and Mesh objects. Each entity is picked in a specific selection mode.

![](figures/entity-hierarchy.svg)

```{=typst}
#v(4pt, weak: true)
```

| Entity | Definition | Select in | Selecting it auto-starts |
|-------|---------------------------|---------|----------------|
| Curve | Line or curve made of Vertices and Control Vertices; joined curves act as one (a “wire body”). Blue, yellow when selected. | Edge mode [2]{.key} | – |
| Vertex | End point of a curve. Purple, white when selected; overlapping vertices change colour to confirm connection. | Point mode [1]{.key} | – |
| Control Vertex | Smaller point that shapes the curve, linked by hull lines. More CVs = more complex shapes. | Point mode [1]{.key} | – |
| Region | Planar area enclosed by curves; formed automatically. Deleting a region also deletes its bounding curves [25.1]{.ver}. | Face mode [3]{.key} | Extrude |
| Solid | Body whose faces are joined into a closed boundary, so it encloses a volume. Through-holes and enclosed cavities are allowed. The Object Types page says "without any holes"; in B-rep terms that means no openings in the boundary. | Body mode [4]{.key} | – |
| Sheet | Open body (one or more faces with open edges). Removing a face from a solid makes it a sheet. | Body mode [4]{.key} | – |
| Face | Bounded piece of one surface (planar or curved, analytic or spline) of a solid or sheet. | Face mode [3]{.key} | Offset Face (push/pull) |
| Edge | Boundary curve between faces (black lines). | Edge mode [2]{.key} | Fillet (shared edge) or Extend Sheet (open edge) |
| Image | Imported PNG/JPG reference picture; snappable at its corners. | Body mode [4]{.key} | – |
| Mesh | Imported OBJ/STL/FBX/3MF data used as reference; snappable to vertices and faces. Not editable as NURBS. | Body mode [4]{.key} | – |

```{=typst}
#v(4pt, weak: true)
```

The colours tell you what you are looking at and what is selected (Object Types page):

- Curves are blue and turn yellow when selected. Regions are dark blue and turn light blue.
- Solids and sheets are grey; when selected, their outline turns yellow. A selected face turns light yellow; edges turn from black to yellow.
- Images and meshes show a yellow outline when selected.
- A plane with more than about 700 curves stops showing its regions, because drawing them becomes too costly.

## Selection modes and smart commands

- Modes: [1]{.key} Control Point, [2]{.key} Edge, [3]{.key} Face, [4]{.key} Solid/Body, [5]{.key} all modes at once [26.1]{.ver}. [Shift+1]{.key} to [Shift+4]{.key} toggle a single mode on or off, so several can be active.
- Convert a selection: [Ctrl+1]{.key} to control points, [Ctrl+2]{.key} edges, [Ctrl+3]{.key} faces, [Ctrl+4]{.key} solids, [Ctrl+5]{.key} whole group. Wire bodies convert to their vertices/CVs (and back) and regions convert to their bounding curves [25.1]{.ver}.
- **Smart commands:** selecting a Region starts Extrude, a Face starts Offset Face, a shared Edge starts Fillet and an open sheet Edge starts Extend Sheet – you can just drag the yellow handle without pressing a key. Move can also start on selection (experimental) [26.2]{.ver}. Each auto-start has its own switch under **Preferences › Commands** (master *Auto-invoke commands*, plus Extrude, Push-face, Extend Sheet, Fillet and Move; all on by default) [26.2]{.doc}.
- Inside a command, the modifier for changing its selection differs between commands: Fillet Shell uses [Ctrl]{.key}+click to add and remove edges; Loft, Sweep and Draft Face use [Shift]{.key}+click to add and [Ctrl]{.key}+click to remove. See *Viewport, command and Outliner selection* in chapter 3.
- **Overlapping objects:** [Ctrl+Shift]{.key}+left-click (or left-click while scrolling the wheel) opens a menu to choose which one to select [25.2]{.ver}. Hold [Alt]{.key} over a CV hull to select a whole row of CVs [25.2]{.ver}. Invert Selection works on edges and faces [25.2]{.ver}.
- **Select All Sheets / Solids / Measurements** (palette) [25.2]{.ver}; Select All skips locked items [25.2]{.ver}; **Select All Constraints** [STUDIO]{.studio} [26.2]{.ver}.

::: {.note .history title="Older versions: two keys changed in 26.1"}
Up to 25.3, [Tab]{.key} switched on all selection modes; from 26.1 it is [5]{.key}. Up to 25.3, [Tab]{.key} also toggled *Lock distances* (equal offset or thickness on both sides); from 26.1 it is [S]{.key} (migration guide 26.1). The official Selection Mode page still shows [Tab]{.key}. To get the old key back, assign *Selection mode: set all* to [Tab]{.key} in the Command Palette.
:::

```{=typst}
#v(16pt, weak: true)
```

### Switching selection modes {-}

1. Press [1]{.key} (Control Point), [2]{.key} (Edge), [3]{.key} (Face) or [4]{.key} (Body), or click the matching selection-mode button at the top left of the screen.
2. To work in two modes at once, add the second one with [Shift]{.key} and its number – for example [Shift+2]{.key} while in Face mode – or [Shift]{.key}-click its button. Do the same again to switch that mode off.
3. To switch every mode on, press [5]{.key}. It does not cycle; it switches all modes on.
4. Click the item. If a click does not pick what you expect, check the active modes: each entity can only be picked in its own mode (table above).

![](figures/c01-selection-modes.svg)

```{=typst}
#v(16pt, weak: true)
```

### Working with smart commands {-}

Smart commands save a step: the selection itself starts the command you are most likely to want.

1. Select a region to extrude it, a face to push it, an edge between two faces to fillet it, or an open edge of a sheet to extend it. The command starts and a yellow handle appears.
2. Drag the handle, or type a value in the command dialog, then confirm as usual (see *Confirming, cancelling and repeating commands* in chapter 3).

To stop an auto-start, open **Preferences › Commands** (P-Menu › Preferences, or [Ctrl+,]{.key}) and untick *Auto-invoke commands* to stop them all, or only the command you do not want. The Preferences page says Plasticity must be restarted after settings are changed (language changes apply at once).

## Construction planes, grid and snapping

A **construction plane (CPlane)** is the working plane on which new sketches and primitives are drawn. Besides the world planes you can create planes from geometry or from the view; saved planes appear in the Outliner and can be renamed.

| Action | Key | Result |
|--------------------|----------|------------------------------|
| CPlane from selection + align camera | [Space]{.key} | Plane on the selected face/region/curve; view turns to face it. |
| CPlane from selection (no camera move) | [Shift+Space]{.key} | Same plane, camera unchanged. |
| View-space CPlane through origin | [Ctrl+Space]{.key} | Plane parallel to the screen, passing through the world origin. |
| View-space CPlane at a picked point | [Ctrl+Shift+Space]{.key} | Plane parallel to the screen, with its origin at a point you click. |
| Midplane [24.2]{.ver} | [Space]{.key} or [Shift+Space]{.key} | With two or more parallel opposing faces/regions selected: plane at their average. |
| Plane through two points, view-aligned [25.1]{.ver} | [Space]{.key} | With two points selected: passes through them and aligns with the camera; handy for planarising a hull. Three points give the plane through them; four or more give their average. |

```{=typst}
#v(12pt, weak: true)
```

### Origin and orientation {-}

A construction plane has two separate properties:

- **Orientation** – which way the plane faces (its normal) and how its own X and Y axes lie in it. This decides on which plane new curves lie and what "X" and "Y" mean for axis locks and the CPlane orientation option of Move, Rotate and Scale.
- **Origin** – the point on the plane where its axes cross. The grid lies on the active plane. A plane can have the same orientation as another one but a different origin, and the other way round.

Each method sets these from different inputs. [Ctrl+Space]{.key} takes the orientation from the view and puts the origin at the world origin; [Ctrl+Shift+Space]{.key} takes the same orientation and puts the origin at the point you click. With a face and an edge selected, the face sets the alignment and the edge the direction. For planes made from faces, regions or points, the docs do not say where the origin goes or how the in-plane X and Y axes are chosen; check the grid and the axis lines after you create the plane.

```{=typst}
#v(16pt, weak: true)
```

### Setting a construction plane {-}

New curves and primitives are drawn on the active construction plane, so set the plane before you draw. Pick the method that fits what you have:

- **On a face or region:** in Face mode select the face or region and press [Space]{.key}. The plane lies on it and the view turns to face it.
- **Perpendicular to a face:** select a face and an edge, then press [Space]{.key}. The face sets the alignment and the edge the viewing direction.
- **Midplane:** select two or more opposing parallel faces or regions and press [Space]{.key} [24.2]{.ver}.
- **Through points:** in Control Point mode select two or more points and press [Space]{.key}. Two points give a plane through both, parallel to the camera; three give the plane through them; four or more give their average.
- **From the view:** orbit until you look along the direction you want. [Ctrl+Space]{.key} creates a plane parallel to the screen through the world origin; with [Ctrl+Shift+Space]{.key} you then click the point it passes through.
- **Back to a world plane:** [Num 7]{.key} switches to the XY plane (top view), [Num 3]{.key} to YZ (right view) and [Num 1]{.key} to XZ (front view).

For the first four methods, [Shift+Space]{.key} creates the same plane but leaves the camera where it is.

![](figures/c01-cplane.svg)

```{=typst}
#v(16pt, weak: true)
```

### Saving and reusing planes {-}

A plane you create stays temporary until you save it.

1. Click **Temporary construction plane** at the top of the screen. The plane is saved as *Custom plane 0* and listed in the Outliner under **Planes** and in the **Added Planes** menu on the right.
2. To use it again, click it in **Added Planes**. Double-click it to activate it and turn the view to face it.
3. To rename it, double-click it in the Outliner, type the name and press [Enter]{.key} (or click in the viewport).

```{=typst}
#v(16pt, weak: true)
```

### Drawing on the plane and snapping off it {-}

Curves are created on the active construction plane. Object snaps, however, find points on 3D geometry, and those points need not lie on the plane.

- **2D Snapping off:** you can snap to points anywhere on visible geometry. The docs do not say, tool by tool, whether a snapped point that lies off the plane stays where it is in 3D or is moved onto the plane. Check the result from a side view.
- **2D Snapping on** (Planes menu) [26.1]{.ver}: every point you pick is projected onto the active plane, and dragged points move along the plane instead of in 3D. Use it when everything you draw must stay flat on the plane while you snap to 3D geometry for position. It has no effect unless a construction plane is active.

```{=typst}
#v(16pt, weak: true)
```

### Snaps at a glance {-}

- **Object snaps** (toggle in the Snapping panel of the right sidebar or “Toggle object snapping” in the palette): CV, curve (end, middle, centre, 1/4, 3/4, closest, intersection, perpendicular, tangent, Tan/Tan [25.1]{.ver}), edge (end, middle), face (centre), region (centre), measurement points, and the Control-point snap [25.1]{.ver}. Meshes snap to vertices/faces, images to corners.
- Press [Shift+X]{.key} to step off the current snap type. Tap [Shift]{.key} while hovering an object to create temporary reference lines.
- Press [X]{.key}, [Y]{.key} or [Z]{.key} to lock to an axis and [Tab]{.key} to type exact values while drawing. In commands that use the gizmo (Move, Rotate, Scale, Push Face, Extrude, Thicken) [Tab]{.key} types an exact distance [26.1]{.ver}.
- **Newer snapping:** centre snap on spherical faces with X-ray on [25.3]{.ver}; **2D Snapping** on construction planes [26.1]{.ver}; **Section** snap where curves/edges cross the Section Analysis plane, **YZ** and **XZ** snaps where they cross those planes, snaps on instances, and the snapped mesh triangle is highlighted [26.2]{.ver}.

| | Object snapping | Grid snapping |
|------------|-------------------------|-------------------------|
| Snaps to | Features of geometry: CVs, curve and edge points, face and region centres, measurement points, mesh vertices/faces, image corners. | Increments of the grid on the active construction plane. |
| Switch on/off | Toggle in the **Snapping** window; *Toggle object snapping* in the palette; choose types under **Object Snaps**. | **Snap to grid** in **Grid and Units**; *Grid: toggle grid snapping* in the palette. |
| Size | – | **Grid size**; *Grid: increase/decrease grid size*. |
| Gizmos | – | Move arrows step in grid increments; the centre circle snaps to absolute grid points [24.2]{.ver}; the Scale gizmo respects increments [25.3]{.ver}. |

```{=typst}
#v(16pt, weak: true)
```

### What Ctrl does with snapping {-}

[Ctrl]{.key} means different things in different situations:

- **Drawing curves:** object snapping works automatically when it is switched on; you do not need [Ctrl]{.key}.
- **Moving existing points or objects:** hold [Ctrl]{.key} to snap to object snap targets.
- **Dragging with grid snapping on:** hold [Ctrl]{.key} to switch grid snapping off for that drag.
- **Inside a command, when clicking objects:** [Ctrl]{.key}+click adds or removes objects from the command's selection (see chapter 3).
- **Sweep twist:** [Ctrl]{.key} snaps the angle in 5° steps [26.1]{.ver}.

When object snapping and grid snapping are both on, the docs do not say which of the two drag rules wins while you hold [Ctrl]{.key}.

```{=typst}
#v(16pt, weak: true)
```

### Snapping while you draw {-}

1. Check that snapping is on: the toggle in the **Snapping** window of the right sidebar, or *Toggle object snapping* in the Command Palette. Choose the snap types you want under **Object Snaps**.
2. Move the cursor over the geometry. A small black dot marks a snap target and a tip help names it (for example *End*, or *Section,Edge*). Click while the tip help is shown.
3. If the cursor locks onto the wrong snap, press [Shift+X]{.key}. Press it again to cycle through the snap types under the cursor until you reach the one you want.
4. To line up with a point that is not under the cursor, hover an object and tap [Shift]{.key}. Temporary reference lines appear, and you can snap to them. The docs do not say which lines appear; watch the preview.
5. Press [X]{.key}, [Y]{.key} or [Z]{.key} to constrain the cursor to that axis.
6. Press [Tab]{.key} to type exact values: input boxes appear on the dimensions.

When a vertex snaps onto a curve or another vertex, it changes colour from purple to blue-green, and a small dot marks where curves meet. The colour is set under Preferences › Appearance › Supporting Color. Chapter 4 lists the in-tool keys of each drawing tool.

![](figures/c01-snapping.svg)

```{=typst}
#v(16pt, weak: true)
```

### Typing values {-}

- **Lengths and distances** – sketch dimensions after [Tab]{.key}, gizmo distances, and the **XYZ** fields of Move, which give the *amount* of movement along each axis, not a target position. Values are in the current **Length** unit.
- **Angles** – the dimension input of a sketch tool and the **Angle** field of Rotate. The Rotate page does not name the unit; Sweep's twist uses degrees [26.1]{.ver}.
- **Scale factors** – the **XYZ** fields of Scale. A factor has no unit: 1 leaves the size unchanged, 2 doubles it.
- **Absolute coordinates** – the docs do not describe typing a point's absolute coordinates. To put a point at an exact position, snap to geometry or measure from a known point.

Numeric fields in dialogs accept arithmetic (+ − × ÷); π (`pi`) and unit suffixes such as `mm` or `in` work from 25.2 [25.2]{.ver}. With centimetres as the unit, `5 + 2mm` gives 5.2 cm and `2 * pi * 3.15` gives 19.792.

```{=typst}
#v(16pt, weak: true)
```

### Grid and units {-}

The **Grid and Units** panel in the right sidebar sets both. The grid lies on the active construction plane.

- **Length** sets the viewport unit: Millimeter, Centimeter, Meter, Inch or Foot. **Mass** (Gram, Kilogram, Ounce or Pound) is used with a material's density; the mass of a selected object appears in the Selection menu at the bottom right [26.1]{.ver}.
- **Grid size** sets the size of the grid; **Line every** sets the spacing of its thicker lines.
- **Snap to grid** turns grid snapping on (also *Grid: toggle grid snapping* in the palette). Holding [Ctrl]{.key} while you drag turns grid snapping off for that drag.
- [Alt+Shift+Z]{.key} (overlays) shows or hides the grid.

**Display unit or real size?** Choosing a **Length** unit sets how lengths are shown and how typed numbers without a suffix are read. Making a part bigger or smaller is a different job: use Scale with a factor. Whether changing **Length** in an existing file keeps the size of the geometry (so 10 mm reads as 1 cm) or rescales it is not documented. Check a known dimension with [Measure Distance]{.cmd} after you change the unit.

```{=typst}
#v(16pt, weak: true)
```

### Checking imported dimensions {-}

Files from other programs often arrive at the wrong size because the two programs assume different units.

1. Before importing, check the **Length** unit in **Grid and Units**.
2. Import the file (P-Menu › Import/Append). For OBJ and STL files Plasticity asks you to confirm the units [24.1]{.ver}: choose the unit the file was made in.
3. Measure a feature whose real size you know: [Measure Distance]{.cmd} ([Ctrl+=]{.key}) between two snap points, [Measure Radius]{.cmd} on a hole, or select two parallel planar faces and read their distance in the Selection panel [25.2]{.ver}.
4. Compare the measured value with the known one. A ratio of 10 (mm ↔ cm), 25.4 (inch ↔ mm), 1000 (m ↔ mm) or 12 (foot ↔ inch) points to a unit mismatch.
5. Fix it: undo, then import again with the right unit; or scale the imported objects with Scale by the ratio (for example 25.4 for a part read as inches that should be millimetres). Check the pivot first, so the part grows about a sensible point.

How STEP and other CAD formats bring in their own units is not described in the docs; always measure after import.

```{=typst}
#v(16pt, weak: true)
```

### Exercise: an inclined construction plane {-}

This exercise practises creating, naming, saving and reusing a plane that is tilted 30° from the XY plane.

1. Press [Num 7]{.key} for the XY plane and draw a box with a corner box tool.
2. Select the box, press [R]{.key} (Rotate), set the axis to X and type 30 for the angle (check that the field reads degrees). Confirm.
3. In Face mode select the top face of the box and press [Shift+Space]{.key}. The plane now lies on the tilted face; the view does not move.
4. Click **Temporary construction plane** at the top of the screen. *Custom plane 0* appears under **Planes** in the Outliner and in **Added Planes**.
5. Double-click *Custom plane 0* in the Outliner, type *Incline 30* and press [Enter]{.key}.
6. Press [Num 7]{.key} to go back to the XY plane. Then double-click *Incline 30* in **Added Planes**: the plane becomes active and the view turns to face it.
7. Draw a circle. It lies on the tilted plane. Extrude it and look from the side ([Num 3]{.key}) to check the extrusion follows the tilt.
8. Save the file, close it and open it again. Check whether *Incline 30* is still listed. The docs do not say whether saved planes are stored in the file.
9. Where the plane's origin and grid lie on the face is not documented (see *Origin and orientation*): note where they appear.

## Anatomy of a command

![](figures/command-anatomy.svg){width=100%}

Every command dialog lists its options and includes an icon that opens the matching page of the official manual [25.1]{.ver}. [Ctrl+Z]{.key} undoes, [Ctrl+Shift+Z]{.key} redoes.

```{=typst}
#v(16pt, weak: true)
```

### Running a command {-}

1. Select what the command works on, if anything. The *Before you start* section of each card says what to select.
2. Start the command with its key, from the Command Palette ([F]{.key}), from **Suggested Commands** ([Shift+F]{.key}, which lists commands that suit the current selection), or from the command bar at the bottom of the screen. The command bar holds Search Commands ([F]{.key}), Move ([G]{.key}), Rotate ([R]{.key}), Scale ([S]{.key}), Duplicate Object ([Shift+D]{.key}), Boolean ([Q]{.key}), Rectangular Array, Radial Array and Suggested Commands.
3. Adjust the result with the handles and gizmo in the viewport, or type values in the command dialog. The keys that work inside each command are listed on its card.
4. Confirm with OK in the command dialog or right-click. *Confirming, cancelling and repeating commands* in chapter 3 covers the details.
5. If the result is wrong, undo with [Ctrl+Z]{.key}. [Shift+R]{.key} repeats the last command.

## Typical modelling workflow

![](figures/modelling-workflow.svg){width=100%}

A common practice is to build the main form first, cut and combine, and leave fillets until late, because fillets complicate later Booleans and offsets. The official manual has a dedicated “Fillet Order of Operations” page. Chapter 10, *A first complete project*, walks through this order on a small part.

## Organising the scene

- **Left sidebar:** Outliner, Materials and Assets sections, each with its own icon. The **Outliner** lists bodies, curves, groups, construction planes, meshes, images and measurements. Group [Ctrl+G]{.key}, ungroup [Alt+G]{.key}.
- **Visibility:** hide [H]{.key}, hide unselected [Shift+H]{.key}, unhide all [Alt+H]{.key}, invert hidden [Ctrl+H]{.key}; Lock Selected makes objects unselectable, **Unlock All** releases every lock [25.2]{.ver}; Isolate [.]{.key}. **Viewport: Toggle Images / Toggle Meshes / Toggle Constraints** show or hide all of that type (palette, no default key) [26.2]{.ver}.
- **Outliner extras:** search field [Ctrl+F]{.key} [26.1]{.ver}; double-click a group to make it the **Active Collection** that receives new objects [26.1]{.ver}; right-click → **Add to Isolation**, header stays visible while scrolling, [J]{.key} runs Join in the Outliner [26.2]{.ver}.
- **Materials:** Set Material [M]{.key}, Remove Material [Alt+M]{.key}, Fork Material [Shift+M]{.key} [25.2]{.ver}. The **Materials** section of the left sidebar (the Assets menu in earlier versions) lists them; right-click → “Select All With This Material” [25.1]{.ver}.
- **Assets** [26.2]{.ver}: reusable parts stored in asset packs (.plasticitypack). Mark an object with Outliner right-click → **Mark as Asset** (*Toggle Asset*), save packs with **Export Asset Pack**, then in the Assets section pick a pack folder and drag an asset into the viewport (Place starts; right-click confirms). The panel has search, multi-pack selection and context menus (reload, reveal file, select all instances). Moving or renaming a pack breaks the link.
- **Display:** X-ray [Alt+Z]{.key}, overlays [Alt+Shift+Z]{.key}, shader/matcap choice and the edges/curves/faces toggles in Shader Mode; the View Mode menu holds Section Analysis, orthographic camera, overlays, X-ray and Render Mode. Custom matcaps can be marked tinted or untinted with a JSON file of the same name next to the image [26.2]{.ver}.
- **Render Mode**: HDRI lighting with rotation, ground-plane shadow, ambient occlusion, physical materials [25.2]{.ver}; new default HDRI [25.3]{.ver}; panel icons toggle curves, edges, faces and constraints [26.2]{.ver}. **Shaders**: Topography (called Topology in 25.2; wireframe look for meshes) and Face direction (called Normal Checker; blue = outward, red = inward) [25.2]{.ver}; **Curvature** shader with **Gaussian** (sudden changes, inflections), **Mean** (overall smoothness) and **Max** (strongest bending – trouble spots for Thicken/Offset) modes [26.2]{.ver}.

![](figures/c01-left-sidebar.svg)

```{=typst}
#v(16pt, weak: true)
```

### Working in the Outliner {-}

The Outliner sorts objects into sections: Solids, Sheets, Curves, Meshes, Images, Measurements and Instances. New objects are named after the tool that made them, for example *Box.000*, *Extruded.000* or *Line.000*.

- **Select:** click an object. Right-click a section label › **Select all** selects everything in that section.
- **Rename:** double-click the name or press [F2]{.key}. To rename several objects together, select them with [Shift]{.key} held, then, still holding [Shift]{.key}, double-click one of their names or press [F2]{.key}.
- **Reorder:** drag and drop objects.
- **Find:** [Ctrl+F]{.key} or the search icon opens a search field; type the name of a file, group or object [26.1]{.ver}. To find an object you selected in the viewport, hover over the Outliner and press [/]{.key} (scroll to selection). [.]{.key} in the Outliner collapses every group and section except the one holding the selected object. Both are also in the Outliner's options menu, together with **Delete empty groups** (empty groups are dimmed).
- **States:** the icons next to each object or group switch **hide** (hidden, but still processed), **disable** (removed from the viewport and from processing, which reduces the load) and **lock** (cannot be selected or changed). Select several objects to change them together. Chapter 3 lists the keys.

```{=typst}
#v(16pt, weak: true)
```

### Groups and the Active Collection {-}

1. Select the objects and press [Ctrl+G]{.key} (*Group Selected*, or the group icon). They move into a new group. If they all share a parent group, the new group is made inside it; otherwise it goes to the root [24.2]{.ver}.
2. To take an object out of its group, select it and press [Alt+G]{.key} (*Ungroup Selected*).
3. Right-click a group folder for more: *Add current selection to group*, *Select all*, *New subgroup with current selection*, *Move selected items to root*, *Expand all* / *Collapse all*, *Add material* / *Remove material*, **Dissolve** (removes the folder, keeps the objects) and **Delete recursively** (removes the folder and everything in it).
4. To make new objects land in a group, double-click the group. It becomes the **Active Collection** and is highlighted [26.1]{.ver}. The highlight colour is set under Preferences › Appearance › Supporting Color. The docs describe the double-click as a toggle, so double-click again to switch it off.
5. [Shift+D]{.key} duplicates a selected group together with its contents [25.2]{.ver}.

```{=typst}
#v(16pt, weak: true)
```

### Applying materials {-}

1. Select solids, sheets or curves, or a group in the Outliner (a group's material applies to every object in it).
2. Press [M]{.key} (*Set Material*).
3. Set **Color**, **Roughness** (0 smooth to 1 very rough), **Metalness** (0 to 1), **IOR** and **Opacity**, then confirm. More options are in the Reflection, Transmission and Advanced menus; Advanced › **Density** gives objects a mass [26.1]{.ver}.

- Curves use only the colour and opacity. Image depth and opacity can also be set through a material.
- In the Outliner, each object shows its material as a coloured dot. Drag a dot onto another object's dot to copy the material, or onto an object in the viewport to assign it [25.3]{.ver}. Right-click an object to set, remove or fork its material.
- The **Materials** section lists every material in use under **Used Materials**. Editing a material updates all objects that use it at once. Drag a material from **Used Materials** or the **Materials Library** onto an object to assign it.
- **Cleaning up the list:** you cannot delete a material from **Used Materials**. The Materials page says a material disappears from the list only after every object that references it has been deleted from the scene. [Remove Material]{.cmd} ([Alt+M]{.key}) resets the selected objects to the default material. Whether a material also leaves the list once no object references it any more – after Remove Material, or after you assign other materials – without deleting the objects is not documented.
- The physical materials at the bottom of the panel only show properly in Render Mode. Press [M]{.key} to edit their texture: **Texture scale**, **Blending** (0 = most blending, 7 = none; useful to hide seams) and **Rotate X / Y / Z**. Their properties are not kept when you export to other software.

```{=typst}
#v(16pt, weak: true)
```

### Using assets {-}

To place an asset [26.2]{.ver}:

1. Open the **Assets** section (third icon of the left sidebar).
2. If no pack is listed, click **Add Asset Pack** and choose a .plasticitypack file, or drag the file into the viewport.
3. Drag an asset into the viewport. Place starts; position the asset and right-click to confirm.

To make your own pack:

1. Select the object and run **Toggle Asset** from the Command Palette, or right-click it in the Outliner › **Mark as Asset**. An asset icon appears next to it in the Outliner. Keep the object's origin inside its main mass or its interactive part; use Move or the Pivot shortcut to reposition it.
2. Run **Export Asset Pack**, choose a location and click Save. The pack is added to the Assets panel automatically.

- **Reload Asset** (palette, or Outliner right-click) puts a placed asset that is still linked back to its original state.
- A pack opened with **Import/Append** lands in the Outliner, not in the Assets panel; its objects are marked as assets.
- Keep your packs in one master folder: moving or renaming a pack breaks the link, and you have to import it again.

## Interface layout (schematic)

![](figures/c01-ui-layout.svg)

```{=typst}
#v(4pt, weak: true)
```

- **P-Menu:** recent files (drag one into the viewport to import [25.1]{.ver}), new, open, import/append, save, export, quick save version, save as startup scene, preferences, licence management; it also flags available updates [25.1]{.ver}.
- **Command Palette** [F]{.key}: search any command by name and see its key; right-click an entry to assign a shortcut. **Suggested Commands** on [Shift+F]{.key} [25.1]{.ver}.
- **Radial menus:** circular menus defined in \*.radial.json files (dropped into the viewport, stored in .plasticity/radials) and bound to keys via the palette.
- **View cube:** click a face to jump to that view; clicking the same face again (a double-click, in the current docs) flips to the opposite view [25.1]{.ver}. From 26.2 the cube has a new look, a face click turns the camera to the closest matching orientation, and right-clicking it opens a view menu with **Home View** (standard isometric view) [26.2]{.ver}. Chapter 2 explains the view cube in detail.

```{=typst}
#v(16pt, weak: true)
```

### Using the Command Palette {-}

1. Press [F]{.key} with the cursor over the viewport and type part of the command's name. The list narrows as you type.
2. Highlight a command with the arrow keys or the wheel and press [Enter]{.key}.
3. To give a command a key, right-click it › **Assign Shortcut** and press the key. A key that is already in use is shown in red; combine it with [Ctrl]{.key}, [Alt]{.key} or [Shift]{.key} to avoid a clash. **Remove Shortcut** clears the key.
4. Right-click › **Add to favorites** puts a button for the command below the input field. Right-click the button or the name › **Remove from Favorites** takes it off.

```{=typst}
#v(16pt, weak: true)
```

### Setting up a radial menu {-}

1. Get a \*.radial.json file. The official Radial Menu page offers two ready-made menus, *selection-mode.radial.json* and *viewport-settings.radial.json*; you can also write your own.
2. Drag the file into the viewport. Nothing visible happens, but the menu is loaded.
3. Press [F]{.key}, type *menu*, right-click *Radial Menu: …* and assign a shortcut.
4. Press the shortcut: the menu opens around the cursor. Click an item, or hold the key, move over an item and release the key.

To change or remove a menu, edit or delete its file in the radials folder (.plasticity/radials in your user folder on Windows and macOS; the docs give no Linux path) and drag an edited file into the viewport again.

## Licences

Plasticity is sold as **Indie** and **Studio** licences; a free trial also exists, but the docs do not describe its terms. Studio-only tools (licence page, 26.2): **Edge Align** (Surface Align and Vertex Align), **Project Align**, **XNurbs**, **Square**, **PolySplines**, Explicit Control in **Rebuild Face**, and the **Constraint System**. The Import/Export page lists IGES and SAT import and export, Rhino (.3dm) import and DXF/DWG import (Windows only) as Studio-only. *Compatibility* in chapter 10 compares the licences.
