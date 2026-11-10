# Solid and surface commands

These tools build solids and sheets from curves, regions, faces and edges, combine and cut bodies, and round or bevel their edges. Most of them start from a selection: regions and faces in Face mode ([3]{.key}), edges in Edge mode ([2]{.key}), whole bodies in Body mode ([4]{.key}). The Surfacing section at the end of the chapter covers the tools that build, join and repair sheets. Unless a card says otherwise, you confirm and cancel these commands in the usual way (see *Confirming, cancelling and repeating commands* in chapter 3).

| I want to… | Use |
|--------------------------------|------------------|
| Pull a region, face, edge or curve straight out into a body | Extrude |
| Spin a profile around an axis | Revolve |
| Build a surface or solid through a series of profiles | Loft |
| Move a profile along a path | Sweep |
| Make a quick tube or rod along a curve or edge | Pipe |
| Fill closed curves or a hole with a surface | Patch |
| Give a sheet or selected faces a thickness | Thicken · Thicken Face |
| Hollow out a solid, open or closed | Hollow |
| Make a surface through points I click | Constrained Surface |
| Turn a mesh into smooth NURBS surfaces (Studio) | PolySplines |
| Join, subtract or intersect bodies | Boolean |
| Split bodies with a curve or a face | Cut |
| Round or bevel the edges of a body | Fillet Shell |
| Take fillets off a body | Remove Fillets from Shell |
| Blend between two surfaces | Bridge Surface |
| Build a four-sided surface with set degree and spans (Studio) | Square |
| Fill an opening with three, four or more sides (Studio) | XNurbs |
| Make a surface edge meet another edge with G0–G2 continuity (Studio) | Surface Align (Edge Align) |
| Align a surface edge to a reference surface by projection (Studio) | Project Align |
| Make a sheet larger past its open edges | Extend Sheet |
| Join sheets along matching edges | Join Sheets |
| Split faces or whole bodies into separate sheets | Unjoin Faces · Unjoin Shells |
| Get back the full surface under a trimmed face | Untrim |
| Select the edges around an opening | Find Boundary Edges |
| Wrap a body onto another surface | Deform (Solid and Sheet) |
| Turn analytic surfaces into splines and add CVs | Raise Surface Degree |
| Rebuild a face with a cleaner structure | Rebuild Face |
| Flip the normals of a sheet | Reverse Sheet |
| Show the hidden spans of a face | Remove Nominal Surface |
| Slide surface CVs along the hull | Slide Surface CV |

## Creating bodies

::: {.command name="Extrude" key="[E]{.key}" documented="1.3"}
Pulls a profile along a straight direction to make a new body. Extruding faces, regions or surface edges gives solids; extruding curves gives sheets. Surface edges can be extruded directly from 26.1 [26.1]{.ver}. In the same step you set the distance, a taper angle and a wall thickness, and you can combine the result with existing bodies through the Boolean options, so a boss or a pocket needs no separate Boolean.

![](figures/c07-extrude-boolean.svg)

Before you start:

- Select the faces, regions, surface edges or curves to extrude. Regions and faces are selected in Face mode ([3]{.key}), edges in Edge mode ([2]{.key}).
- Selecting a region starts Extrude automatically. This is one of the *Auto-invoke commands* under **Preferences › Commands**, where it can be switched off (toggle **Extrude**); Plasticity needs a restart after you change preferences.
- Otherwise press [E]{.key}, before or after selecting. Extrude is also in the Suggested Commands menu.

Step by step:

1. Select the geometry, or press [E]{.key} and then select it.
2. Drag the yellow dot to set the distance, or press [D]{.key} and move the cursor. For an exact value, type it in the **Distance** field, or press [Tab]{.key} and type it on the gizmo [26.1]{.ver}.
3. If needed, set a taper with **Degrees** ([A]{.key}) and a wall with **Thickness** ([Shift+T]{.key}).
4. Choose how the result combines with other bodies (see *Target bodies* below), then confirm.

Options explained:

- **Distance** – how far the profile is extruded. A second value extrudes in the opposite direction, so the body can grow both ways from the profile. **Lock distances** ([S]{.key}) keeps both sides equal.
- **Degrees** – the extrusion angle, which tapers the side walls.
- **Thickness** – the wall thickness of the extruded body.
- **Target bodies** – how the new body combines with existing bodies. It works as in the Boolean command:
  - **Union** ([Q]{.key}) – joins the new body to the target.
  - **Difference** ([W]{.key}) – removes the new body from the target, for example to cut a pocket.
  - **Intersect** ([Shift+E]{.key}) – keeps only the part where the new body and the target overlap.
  - **Slice** ([Shift+Q]{.key}) – as Boolean › Slice: the overlap and the remaining pieces become separate solids.
  - **New Body** ([B]{.key}) – keeps the extrusion as a separate body.
- **Keep tools** ([T]{.key}) – keeps the tool bodies after the Boolean operation.
- **Individual** ([I]{.key}) – switches the direction mode [26.1]{.ver}:
  - **Direct** – all selected faces are extruded along one shared direction. The 26.1 release notes call this mode *Direction*.
  - **Individual** – each face is extruded along its own normal.

Keys:

- [F]{.key} freestyle – click a start point and an end point to set the direction and distance.
- [V]{.key} pivot – sets the position of the gizmo.
- [D]{.key} distance, [A]{.key} angle, [Shift+T]{.key} thickness – each set by moving the cursor.
- [S]{.key} lock distances, equal on both sides [26.1]{.ver}; [Tab]{.key} types an exact gizmo distance [26.1]{.ver}.
- [Q]{.key} union, [W]{.key} difference, [Shift+E]{.key} intersect, [Shift+Q]{.key} slice, [B]{.key} new body, [T]{.key} keep tools.
- [I]{.key} toggles between Individual and Direct [26.1]{.ver}.
- [Ctrl]{.key} modify selection – adds or removes objects, according to the current selection mode.

Common problems:

- Selecting a region does not start Extrude → the auto-start is off. Turn on *Auto-invoke commands* and *Extrude* under Preferences › Commands, or press [E]{.key}.
- The result is a sheet, not a solid → you extruded curves. Select the region enclosed by the curves (Face mode) instead.
- The extrusion merged with a body you wanted to keep separate, or the other way round → check the target mode: [B]{.key} New Body or [Q]{.key} Union.
- Several faces all move the same way instead of out from their own surfaces → press [I]{.key} for Individual [26.1]{.ver}.

Tips:

- To cut a pocket, draw the outline on a face, select the region and extrude it into the body with [W]{.key} Difference; for a boss, extrude it outwards with [Q]{.key} Union.
- Use lock distances to extrude a profile symmetrically, for example a part that is centred on its sketch plane.

Older versions:

- Up to 25.3, **Lock distances** was [Tab]{.key}; from 26.1 it is [S]{.key}, and [Tab]{.key} enters an exact gizmo distance.
- Surface edges could not be extruded directly before 26.1 (the 26.1 release notes add *Edge Extrusion*).

Related:

Boolean, Cut, Pipe, Revolve, Offset Face (Push Face).
:::

::: {.command name="Revolve" documented="26.1"}
Spins a profile around an axis that you define with two clicks. Revolving a region gives a solid; revolving a curve gives a solid or a sheet. Use it for parts that are round about an axis: shafts, knobs, bottles, rings. The result can be combined with other bodies while you revolve [26.1]{.ver}.

![](figures/c07-revolve.svg)

Before you start:

- Select a region (Face mode, [3]{.key}) or a curve.
- Revolve has no default key: run it from the **Revolve** button in the Suggested Commands menu, or search for *Revolve* in the Command Palette.

Step by step:

1. Select the region or curve and run Revolve.
2. Click the start point of the axis, then its end point.
3. Drag to set the angle, or press [A]{.key} and move the mouse; type an exact value in **Degrees**.
4. If needed, set a thickness ([Shift+T]{.key}) and a Boolean mode, then confirm.

Options explained:

- **Degrees** – how far the profile is revolved around the axis.
- **Thickness** ([Shift+T]{.key}) – a thickness for the result. The command page gives no further detail.
- **Boolean** [26.1]{.ver} – [Q]{.key} Union, [W]{.key} Difference, [Shift+E]{.key} Intersect, [Shift+Q]{.key} Slice, as in the Boolean command; [B]{.key} New body keeps the result as its own body.
- **Keep tools** ([T]{.key}) – keeps the tool objects after a Boolean operation.
- The command page's description also mentions *Normal*, *Binormal* and *Tangent* options but does not explain them.

Keys:

- [A]{.key} angle by moving the mouse; [Shift+T]{.key} thickness.
- [Q]{.key} union, [W]{.key} difference, [Shift+E]{.key} intersect, [Shift+Q]{.key} slice, [B]{.key} new body, [T]{.key} keep tools [26.1]{.ver}.

Common problems:

- The result is a sheet and you wanted a solid → revolving a curve can give a sheet. Revolve the region enclosed by the curves instead.
- The axis is slightly off → the two clicks set the axis. Turn on Object Snaps so that they land exactly on the end points of a line or edge.

Tips:

- Draw half of the cross-section with one straight side on the axis, then click the two ends of that side as the axis.
- Keep the profile on one side of the axis: a profile that crosses it would make the body pass through itself.

Related:

Extrude, Sweep, Loft, Boolean.
:::

::: {.command name="Loft" key="[L]{.key}" documented="24.1"}
Builds a surface or solid that passes through a series of profiles, in the order you select them. The profiles can be any mix of curves and edges; lofting regions or faces gives solids. Guide curves or edges control the shape between the profiles, and where a profile is an edge you can set G0, G1 or G2 continuity and tension so that the loft blends into the neighbouring surface.

![](figures/c07-loft-sweep-pipe.svg)

Before you start:

- You need two or more profiles: curves, edges, regions or faces. Select them **in the order in which the surface should flow** ([Shift]{.key}+click to add, [Ctrl]{.key}+click to deselect).
- Guides are optional curves or edges that must touch each profile.
- Selecting two vertices bridges two curves, as Bridge Vertex does.

Step by step:

1. Select the profiles in order.
2. Press [L]{.key}.
3. Optionally select guide curves or edges: [Shift]{.key}+click adds a guide, [Ctrl]{.key}+click removes one. Guides must also be selected in the order of the flow.
4. Set the options (below), then confirm.

**Loop:** select three or more curves, press [L]{.key}, then click **Loop** in the command dialog to close the loft into a ring.

**Regions and faces:** lofting two or more regions, or two faces, creates a solid. Guide curves are optional; with faces you can also set continuity and tension.

**Continuous lofting:** after lofting from a single edge, its two adjacent edges can be lofted as guides. Repeat this to join two sheets.

Options explained:

- **Simplify** (default on) [25.2]{.ver} – how planar sections are built:
  - **On** – simplified, trimmed planar patches where the CV layout would otherwise be inconsistent.
  - **Off** – keeps one consistent CV layout across the surface by building intermediate geometry between the profiles ("tweening").
- **Continuity** – G0, G1 or G2 where the loft meets an edge or face profile. You can set it per point by clicking the black circles on the surface; [Tab]{.key} cycles the values.
- **Tension** – the tension at each edge. [D]{.key} sets it for both edges at once by moving the cursor.
- **Loop** – closes the loft into a ring; needs three or more profiles.
- **Trim overlap** – with guides, trims the lofted surface where it overlaps:
  - **Guides** – the guide side is trimmed.
  - **Profiles** – the profile side is trimmed.

Keys:

- [L]{.key} starts Loft. Inside the command, [L]{.key} adds a **limit point**: click an edge to set the range of the loft, and click the limit point again to reverse the direction. Up to two per curve; Object Snaps must be on.
- [Tab]{.key} cycles continuity G0, G1, G2; [D]{.key} tension by moving the cursor.
- [Shift]{.key}+click adds and [Ctrl]{.key}+click removes profiles and guides.

Common problems:

- The loft twists or fails → the profiles or guides are in the wrong order. Reselect them in the order of the flow. For closed profiles, see *Example: lofting closed profiles* below.
- A guide shows a red dot [25.2]{.ver} → that guide does not touch the profiles. Every connection should show a blue-green intersection dot; draw the guides with Object Snaps on.
- It fails with guides → there are too many or too few guides, or profiles and guides are too close together. Try selecting the guides first, then the profiles. A failed loft may also come back as you select more guides: surfaces can appear and disappear during selection.
- The curves are too complex → rebuild them (Rebuild Curve), or split the shape into several simpler lofts and join them or connect them with bridge curves.
- An option you expect is missing → curves and edges offer different options; use curves where you need them.
- Diagnostic error bodies appear [24.1]{.ver} → they mark problems such as self-intersections.

Related:

Sweep, Patch, Bridge Vertex · Bridge Edge, Bridge Surface, Square.
:::

### Example: lofting closed profiles {-}

The Loft page documents open curves, edges, regions, faces and Loop, but says nothing about how closed profiles are matched up: it does not mention seams or start points, and a draft section on lofting closed curves is commented out of the page source. The background below is general NURBS theory, and the exercise lets you find out how 26.2.0 behaves.

[ADVICE]{.advice} A closed curve has a seam: the point where its parameter starts and ends. A loft joins matching parameter positions on each profile, so the surface's seam runs from seam to seam, and if the seams sit at different angles, or two profiles run in opposite directions, the surface lines spiral and the loft looks twisted. Profiles with the same number of segments and matching start points usually give the cleanest result.

Exercise (record what you see):

1. Draw a circle of 20 mm radius on the ground plane and a 30 × 30 mm Center Rectangle 40 mm above it, centred on the same axis.
2. Select the circle, then the rectangle, and press [L]{.key}. Note where the seam edge runs and whether the surface lines go straight up or spiral.
3. Undo, rotate the rectangle 45° about the vertical axis, and loft again. Compare.
4. Draw a guide with Object Snaps from a point on the circle to a corner of the rectangle and loft with it. Guides are documented to control the shape; record whether this one removes the twist.

If the loft twists, rotate or redraw the profiles so that their corresponding points line up, add guides, or rebuild the curves so that they have the same structure.

::: {.command name="Sweep" key="[Shift+P]{.key}" documented="24.1"}
Moves a profile along a path curve to make a body. Sweeping faces or regions gives solids; sweeping curves gives sheets. Twist, scale and guide curves control how the section turns and changes along the way, and the result can be combined with other bodies while you sweep [26.1]{.ver}. Use Sweep when the section must stay exact; for quick tubes, Pipe is faster but not dimensionally accurate.

Before you start:

- Select the profile: regions, faces or curves.
- You need a path curve, and optionally guide curves. Sweep is also in the Suggested Commands menu.

Step by step:

1. Select the profile.
2. Press [Shift+P]{.key}.
3. Click the path curve.
4. Set the options in the command dialog, the advanced dialog and with the keys.
5. Optionally add guides: check that **Select guides** is highlighted in the command dialog, select the guide curves ([Shift]{.key}+click for several, [Ctrl]{.key}+click to remove one), then set the guide method. The order in which you select guides changes the shape. Then confirm.

Options explained:

- **Twist** – rotates the section along the path, in degrees. Set it with [D]{.key} by moving the mouse; hold [Ctrl]{.key} to snap it in 5° steps [26.1]{.ver}.
- **Scale** [24.1]{.ver} – the scale of the section at the end of the path. Type a value, or drag in the field from left to right.
- **Alignment** – the docs give only one line for each value:
  - **Parallel** – "sweeps parallel to the path, regardless of the orientation".
  - **Normal** – "sweeps at an angle aligned with the path".
  - How each one orients an asymmetric profile along a curved path is not documented.
- **Distance** [25.2]{.ver} – extends or retracts the body along the path. The command page gives the default as 1.00; lowering it towards 0 shortens the result.
- **Guide method** (with guides):
  - **Point** – the section is rotated and scaled so that the points that start on the guide and the path stay in contact with them.
  - **Chord** – the section is rotated but not scaled.
  - **Curve** – the section is rotated but not scaled. The guide and the path must touch the profile; one contact point stays fixed on the profile and the other can slide along it. The profile must be large enough to span the greatest distance between the two guides.
- **Boolean** [26.1]{.ver} – [Q]{.key} Union, [W]{.key} Difference, [Shift+E]{.key} Intersect, [Shift+Q]{.key} Slice, [B]{.key} New body.
- Advanced dialog:
  - **Keep tools** ([T]{.key}) – keeps the tool objects after a Boolean operation.
  - **Simplify** (default off) – chooses between trimmed planar sections and uniform geometry.
  - **Corner type** [25.3]{.ver} – how outside corners of the path are swept: **Mitre** gives a sharp corner, **Round** a rounded one. The 25.3 release notes say Round works best with 90° corners.

Keys:

- [Shift+P]{.key} start; [D]{.key} twist by moving the mouse; hold [Ctrl]{.key} to snap the twist in 5° steps [26.1]{.ver}.
- [Q]{.key} union, [W]{.key} difference, [Shift+E]{.key} intersect, [Shift+Q]{.key} slice, [B]{.key} new body, [T]{.key} keep tools.
- [Shift]{.key}+click adds and [Ctrl]{.key}+click removes guides.

Common problems:

- The result is a sheet → you swept a curve. Sweep the region or face for a solid.
- **Curve** guides do not work → the profile must touch both the guide and the path, and be wide enough to span the greatest distance between the guides.
- The shape changes unexpectedly when you add guides → guide order matters; reselect them in a different order.
- Diagnostic error bodies appear [24.1]{.ver} → they mark problems such as self-intersections.
- A Twist value from an older tutorial gives a different result → see *Older versions*.

Older versions:

- Up to 25.3, **Twist** was in radians; from 26.1 it is in degrees [26.1]{.ver}.

Related:

Pipe, Loft, Extrude, Revolve, Boolean.
:::

::: {.command name="Pipe" key="[P]{.key}" documented="1.4"}
Creates a pipe of any size along curves or edges, with a polygon, circular or custom section. Several curves or edges selected give several pipes [1.4]{.ver}. A wall thickness turns the rod into a tube, and Boolean options let the pipe add to or cut into other bodies.

**Official warning:** Pipe is not intended for dimensionally accurate pipes. It is meant for quickly making good-looking pipes or tubes; because it approximates angles, the result is not suitable for precise plumbing, mechanical design or anything that needs exact dimensions. For an accurate, fully controlled pipe, use **Sweep**. (Source: the note on the official Pipe page, <https://doc.plasticity.xyz/solid/pipe>, accessed 21/10/2026.)

Before you start:

- Select one or more curves or edges. Each one gets its own pipe.
- Pipe is also in the Suggested Commands menu.

Step by step:

1. Select the curves or edges.
2. Press [P]{.key}. Three handles appear.
3. Drag the **yellow dot** to set the section size, the **yellow square** to set the wall thickness and the **white circle** to set the rotation.
4. Set the options in the command dialog or with the keys, then confirm.

Options explained:

- **Vertex count** – the number of corners of the polygon section; **0** makes it circular.
- **Diameter** – the section size.
- **Thickness** – the wall thickness of the pipe.
- **Angle** – rotates the section around the path.
- **Scale** [24.1]{.ver} – the scale of the section at the end point of the pipe. Type a value or drag in the field from left to right.
- **Distance** [25.2]{.ver} – extends or retracts the pipe along the path. **Distance 1** adjusts the start, **Distance 2** the end; the default is 1.00, and lowering it towards 0 shortens the pipe.
- **Select custom profile** ([C]{.key}) – use regions, curves or faces as the section.
- **Target bodies** – Boolean options as in the Boolean command: [Q]{.key} Union, [W]{.key} Difference, [Shift+Q]{.key} Slice, [B]{.key} New Body, [T]{.key} Keep Tools. The command page does not list Intersect.

Keys:

- [D]{.key} section size, [A]{.key} angle, [Shift+T]{.key} thickness – each by moving the cursor.
- [C]{.key} select custom profile.
- [Q]{.key} union, [W]{.key} difference, [Shift+Q]{.key} slice, [B]{.key} new body, [T]{.key} keep tools.

Common problems:

- The pipe is not dimensionally exact → this is expected (see the official warning above). Use **Sweep** with a drawn section for exact pipes.
- The scaled end is at the wrong end → reverse the path curve (Reverse Curve) to flip it.

Older versions:

- Before 26.1 the **Diameter** field was called **Section Size** [26.1]{.ver}.

Related:

Sweep, Extrude, Boolean, Cut, Reverse Curve.
:::

::: {.command name="Patch" documented="24.1"}
Fills closed curves, or a hole bounded by edges, with a new surface. It also works on regions [26.1]{.ver} and on a closed loop of edges on a solid, which gives a new sheet [24.2]{.ver}. For holes you can set the continuity with the surrounding faces (planar, G0, G1 or G2) and use guide curves; Patch can also fill several holes in one go or trim one sheet to a hole in another.

Before you start:

- Select what to fill: closed curves, a region, the edges around a hole in a sheet, or edges of a solid.
- Patch has no default key: run it from the Suggested Commands menu or the Command Palette.

Step by step:

1. Select the closed curves, or the edges around the hole.
2. Run **Patch**.
3. Set the options: **Tolerance** for curves; **Continuity**, **Faces** and **Tolerance** for a hole. Then confirm.

**With guide curves:** draw the guide curves first. Where a guide touches the surrounding surface, add an edge there with **Isoparam**. Then select the edges around the hole, run Patch, select the guide curves, set the options and confirm.

**Several holes at once:** select a sheet with several holes and run Patch. The holes are filled and the result becomes a solid. If any one hole cannot be filled, the whole command fails.

**Trim a sheet to a hole** [24.1]{.ver}:

1. Select the sheet to be trimmed (the target) and hide it for now.
2. On the base sheet, select the edge loop around the hole.
3. Switch to Body mode ([4]{.key}), unhide the target sheet and add it to the selection.
4. Run **Patch**, set **Method** and **Tolerance**, and confirm.

Options explained:

- **Tolerance** – the tolerance of the patch; available in every case.
- **Continuity** (holes) – how the patch meets the surrounding faces. You can set it individually by clicking the black circles on the surface:
  - **Planar** – the patch is flat.
  - **G0 / G1 / G2** – the patch touches the neighbouring faces, is tangent to them, or matches their curvature.
- **Faces** (holes) – **Single**, **Minimal** or **Quality**. The docs do not explain these values; compare the results in your version.
- **Method** (trimming) – **Trim to hole** trims the target sheet to the hole in the base sheet; **Trim to sheet** trims it to line up with the end section of the base sheet.

Common problems:

- Patching several holes fails completely → one of the holes cannot be filled. Patch the holes one at a time to find it.
- The patch does not follow the shape you want → add guide curves, with an Isoparam edge wherever a guide touches the surface.

Tips:

- After deleting faces, **Find Boundary Edges** selects the edges around the opening, ready for Patch.

Related:

Loft, Delete Face, Find Boundary Edges, Isoparam, XNurbs, Join Sheets.
:::

::: {.command name="Thicken · Thicken Face" documented="1.3"}
Adds thickness to a sheet (**Thicken**) or to selected faces (**Thicken Face**), with a separate thickness value for each side. Thicken is the usual way to turn a surface model into a solid part with a wall, such as a shell, a panel or a blade. Thicken Face was added in 1.3 [1.3]{.ver}; the introduction date of Thicken for sheets is not known.

![](figures/c07-thicken-hollow.svg)

Before you start:

- **Thicken:** select a sheet (Body mode, [4]{.key}).
- **Thicken Face:** select faces (Face mode, [3]{.key}).
- Both pages tell you to run the **Thicken** command; what you have selected decides which behaviour you get. It has no default key: run it from the Command Palette or the Suggested Commands menu.

Step by step:

1. Select the sheet or the faces.
2. Run **Thicken**.
3. Set the thickness for each side in the command dialog, or press [D]{.key} and move the cursor. [Tab]{.key} lets you type an exact distance on the gizmo [26.1]{.ver}. Then confirm.

Options explained:

- **Thickness** – the docs say it sets "the thickness of each of both sides": one value per side of the sheet or face, so the wall can grow to one side, the other side or both.
- **Lock distances** ([S]{.key}) – the same thickness on both sides.

Keys:

- [D]{.key} thickness by moving the cursor.
- [S]{.key} lock distances [26.1]{.ver}; [Tab]{.key} types an exact distance [26.1]{.ver}.

Common problems:

- Thicken fails → the problem area is highlighted in red [26.2]{.ver}. Fix the geometry there and try again.

Tips:

- If Thicken fails, try a smaller thickness or thicken towards the other side. The Curvature shader's **Max** mode shows areas likely to cause trouble for Thicken and Offset [26.2]{.ver}.

Older versions:

- Up to 25.3, **Lock distances** was [Tab]{.key}; from 26.1 it is [S]{.key}.

Related:

Hollow, Extrude, Offset Face (Push Face), Join Sheets; *When geometry fails* (chapter 10).
:::

::: {.command name="Hollow" documented="26.1"}
Turns a solid into a shell with walls of a set thickness. With a **face** selected, that face is removed and the result is an open hollow, like a cup or a box without a lid. With the whole **solid** selected, the result is a closed hollow shell. Several bodies can be hollowed at once [26.1]{.ver}. See *Hollow or Thicken?* below.

Before you start:

- **Open hollow:** Face mode ([3]{.key}); select the face or faces to remove.
- **Closed hollow:** Body mode ([4]{.key}); select the solid or solids.
- Hollow has no default key: run it from the Command Palette or the Suggested Commands menu.

Step by step:

1. Select the faces or the solids.
2. Run **Hollow**.
3. Drag the yellow dot to set the wall thickness, or press [D]{.key} and move the cursor; type an exact value in **Thickness**.
4. When hollowing a whole solid, turn **Local** off. Then confirm.

Options explained:

- **Thickness** – the wall thickness: one value for the whole wall.
- **Local** – the docs only say to turn it off when you hollow out a solid; they do not describe what it does when on.

Keys:

- [D]{.key} thickness by moving the cursor.

Common problems:

- Hollow fails → the problem area is highlighted in red [26.2]{.ver}. Check that part of the body.
- A whole solid does not hollow as expected → turn **Local** off.

Related:

Thicken · Thicken Face, Delete Face, Boolean; *When geometry fails* (chapter 10).
:::

### Hollow or Thicken? {-}

Both commands make walls, but they start from different things and keep different surfaces.

| | Hollow | Thicken · Thicken Face |
|---|---|---|
| Starts from | a solid (or faces of it) | a sheet, or selected faces |
| Surfaces kept | face selected: that face is removed, leaving an opening; solid selected: closed outside, closed void inside | the sheet or faces stay the reference; material is added to their sides |
| Thickness values | one value: the wall thickness | one value per side ("the thickness of each of both sides") |
| Direction | not documented | side 1, side 2 or both; which side is which is not documented |
| On failure | red highlight [26.2]{.ver} | red highlight [26.2]{.ver} |

[ADVICE]{.advice} Use Hollow when you already have the outside shape as a solid and want a part of even wall, such as a housing or a cup. Use Thicken when your model is a surface (for example a lofted panel) and you know which side the material should go.

::: {.command name="Constrained Surface" documented="26.2"}
Generates a surface that passes through points you click. Use it to make a freeform surface through a set of known points, for example measured points or the corners of a shape.

Before you start:

- Run **Constrained Surface** from the Command Palette. The docs do not say what the points can snap to; Object Snaps help to click existing points exactly.

Step by step:

1. Run the command.
2. Click the points the surface should pass through. [Ctrl+Z]{.key} removes the last point.
3. Adjust the options in the command dialog, then confirm.

Options explained:

- **Tolerance** – the tolerance of the surface.
- **Angular tolerance** – higher values give a more relaxed surface, lower values a tighter one.
- **Optimize**:
  - **Performance** – the surface is generated quickly.
  - **Smoothness** – the surface is generated more smoothly.

Keys:

- [Ctrl+Z]{.key} removes the last point.

Related:

Patch, Loft, XNurbs.
:::

::: {.command name="PolySplines" version="26.1" studio="true"}
Converts mesh objects into editable NURBS surfaces: clean, untrimmed single- and multi-span surfaces with G2 continuity. Unlike Catmull-Clark subdivision, which refines a mesh by repeated approximation, it produces fewer, cleaner B-spline patches that are suitable for manufacturing and engineering. It works well with the Blender Bridge add-on, which updates the result live and imports it into the scene. Studio only.

Before you start:

- Import the mesh or select one in the scene. The command page lists OBJ and FBX as the supported formats "at the moment".
- Quad-dominant meshes work best; triangles and n-gons are handled too.
- Run **PolySplines** from the Command Palette; it has no default key.

Step by step:

1. Select the mesh.
2. Search for *PolySplines* in the Command Palette and run it.
3. Adjust the options in the command dialog.
4. Confirm. A spline object is created.

Options explained:

- **Rounded Corners** – rounds the corners of an open body, with or without thickness applied.
- **Merge Patches**:
  - **On** – adjacent patches are merged into one surface with a clean CV layout. Recommended for further modelling.
  - **Off** – each patch stays a separate Bézier patch with its own CV structure.
- **Interpolate Boundary Exactly** – the surface boundary matches the mesh boundary's spline curve exactly instead of approximating it. Useful when two open bodies with aligned boundaries will be joined.

**Editing the result:**

- PolySpline CVs can be moved directly in Point mode ([1]{.key}), like mesh vertices [26.2]{.ver}.
- **Duplicate** ([Shift+D]{.key}) copies selected PolySpline CVs and keeps them editable [26.2]{.ver}. If the copies lack enough support geometry, they are rebuilt into a valid PolySpline topology where possible.
- **Remove Nominal Surface** on a PolySpline face removes its CVs and bakes the surface. This is destructive, so check the selection first [26.2]{.ver}.

Common problems:

- Creases or bevels made in the mesh modeller are lost → vertex and edge creasing and bevelling from other modelling programs are not supported. Add supporting edge loops in the mesh to sharpen corners and edges instead.
- The CVs can no longer be edited as a PolySpline → Remove Nominal Surface has baked the surface; undo ([Ctrl+Z]{.key}) straight away if that was not intended.

Tips:

- For the live workflow from Blender, see "Working with PolySplines" in the official Blender Bridge guide.

Related:

Remove Nominal Surface, Duplicate, Import / Append, Rebuild Face.
:::

## Combining and cutting

::: {.command name="Boolean" key="[Q]{.key}" documented="25.2"}
Combines a **target** with one or more **tools**, in any mix of solids and sheets: join them, subtract the tools, keep only the overlap, or slice them into pieces. Boolean is the basic way to build complex shapes from simple ones. Extrude, Revolve, Sweep and Pipe offer the same operations while they run.

![](figures/c07-boolean-ops.svg)

Before you start:

- Body mode ([4]{.key}). Decide which body is the target (the one that is kept and changed) and which are the tools.

Step by step:

1. Press [Q]{.key}.
2. While **Select target bodies** is highlighted in the command dialog, click the target solid or sheet.
3. While **Select tool bodies** is highlighted, click the tool or tools. To change either choice later, click its button again and reselect.
4. Choose the operation ([Q]{.key}, [W]{.key}, [Shift+E]{.key}, [Shift+Q]{.key}, or **Region** in the dialog). If needed, move, rotate or scale the tool with [G]{.key}, [R]{.key} or [S]{.key}. Then confirm.

Options explained:

- **Operation**:
  - **Union** ([Q]{.key}) – joins the target and the tools.
  - **Difference** ([W]{.key}) – removes the tools from the target.
  - **Intersect** ([Shift+E]{.key}) – creates a solid where the target and the tools overlap.
  - **Slice** ([Shift+Q]{.key}) – creates a solid at the intersection and keeps the remaining pieces as separate solids. In the official comparison image for a solid target and a solid tool, the result is three pieces: the overlap, the target without it and the tool without it.
  - **Region** [25.2]{.ver} – creates solids from the enclosed regions formed by the whole collection of bodies (solids and sheets).
- **Keep Tools** ([T]{.key}) – performs the operation but leaves the tool objects in place.
- **Advanced** [25.2]{.ver} – how each side is treated during the operation:
  - **Target Material** – whether the target acts as a solid or a sheet: **Default** (the body's normal state), **Empty** (an empty shell), **Inside** or **Outside** (a solid seen from inside or outside, judged by the tool's normal direction).
  - **Tool Material** – the same choice for the tools, judged by the target's normal direction.

The official page compares the results for each combination (solid or sheet target with solid or sheet tool) in images. One stated example: with a solid target and tool, **Target Material › Outside** and **Tool Material › Empty**, Slice gives three results – a combined copy of both bodies, a sheet from the tool with the overlap removed, and a solid from the target with the overlap removed.

Keys:

- [Q]{.key} union, [W]{.key} difference, [Shift+E]{.key} intersect, [Shift+Q]{.key} slice, [T]{.key} keep tools.
- [G]{.key} move, [R]{.key} rotate, [S]{.key} scale the tool during the command, as in Move, Rotate and Scale; [X]{.key}, [Y]{.key} or [Z]{.key} constrain to an axis, [Shift+X]{.key}, [Shift+Y]{.key} or [Shift+Z]{.key} to a plane.

Common problems:

- The Boolean fails → the problem area is highlighted in red [26.2]{.ver}. Look there for faces that only touch, tangent faces, gaps or nearly coincident faces; see *When a Boolean fails* below.
- The tool disappeared and you still need it → turn on **Keep Tools** ([T]{.key}), or undo and run the Boolean again.
- Difference removed the wrong part → target and tool are the wrong way round. Click **Select target bodies** and reselect.

Tips:

- Leave cutting tools slightly longer than the target where they cut through, so that faces do not end exactly on each other.

Related:

Cut, Extrude, Pipe, Imprint Body-Body; *When geometry fails* (chapter 10).
:::

### When a Boolean fails {-}

**What the docs say.** Boolean accepts any mix of solids and sheets; the official page shows the outcome of each operation for each solid/sheet combination, and **Target Material** and **Tool Material** change how each side is treated. From 26.2 a failed Boolean, Hollow or Thicken highlights the problem geometry in red. The docs do not describe how Boolean handles bodies that only touch, are tangent, or do not meet at all.

**How the inputs relate** [ADVICE]{.advice} (general B-rep behaviour, not tested in Plasticity):

- **Overlapping** – the bodies share a real volume and their faces cross at clear angles. This is the case Booleans are built for and the most reliable.
- **Touching** – faces lie exactly on each other, or the bodies meet only along an edge or at a point. The intersection has no volume, so kernels may fail, merge the faces, or leave zero-thickness or non-manifold results.
- **Tangent** – a curved face just touches another face (a cylinder resting on a plane). The intersection is degenerate and often fails or leaves thin sliver faces.
- **Nearly coincident** – faces almost line up, for example 0.001 mm apart. This creates tiny faces and edges close to the modelling tolerance and is the most common hidden cause of failures and bad fillets later.
- **Disconnected** – the tool does not reach the target. What each operation returns in Plasticity is not documented.

**Diagnosing and fixing without changing your dimensions** [ADVICE]{.advice}:

1. Look at the red highlight and check that area for touching, tangent or nearly coincident faces and very small faces.
2. As a diagnostic only, move the tool a little with [G]{.key} during the command and watch the preview. If the Boolean now works, the cause is coincidence or tangency at that spot. Do not keep the moved tool: it changes the part's size.
3. Fix the geometry instead: make through-cut tools run clearly past the far side of the target (the extra length is outside the part, so nothing changes); for a Union, sink the tool into the target by a clear amount where it is hidden inside; snap faces that should coincide exactly onto each other rather than nearly.
4. Remove small or redundant faces from earlier steps ([Delete Redundant Topology]{.cmd}), and add fillets after the Boolean rather than before.
5. If one combined operation keeps failing, split it into several Booleans with one tool each.

::: {.command name="Cut" key="[C]{.key}" documented="25.2"}
Cuts solids or sheets with a cutter curve or face. A curve cutter generates a cutting surface. The pieces become separate bodies. Use it to split a part into sections, separate a lid from a box, or cut along a sketched line.

![](figures/c07-cut.svg)

Before you start:

- You need the target bodies (solids or sheets) and the cutters (curves or faces).

Step by step:

1. Press [C]{.key}.
2. While **Select target bodies** is highlighted, click the solids or sheets to cut.
3. While **Select cutters** is highlighted, click the curves or faces to cut with. To change either choice, click its button again and reselect.
4. If a curve cutter is too short, turn on **Extend** ([E]{.key}). Press [S]{.key} to cut along the view direction. Then confirm.

Options explained:

- **Select target bodies** – the solids or sheets to be cut.
- **Select cutters** – the curves or faces that cut them.
- **Extend** [25.2]{.ver} – lengthens a curve cutter that is too short to cut all the way through the target.
- **Screen space** ([S]{.key}) – the cutting direction follows the current view, so the curve cuts as you see it on screen.

Keys:

- [C]{.key} switches to **Cut Curve**, which cuts curves instead of bodies.
- [S]{.key} screen space – cut along the view direction.
- [E]{.key} extend, as listed on the Cut page. The Cut Curve page lists [Tab]{.key} for the same option.

Common problems:

- The body is only partly cut → the curve cutter does not reach across the body. Turn on **Extend** [25.2]{.ver}, or lengthen the curve.
- The cut does not follow the line as you see it on screen → press [S]{.key} for screen space.

Tips:

- To cut a body into pieces without a sketch, use a face or sheet as the cutter, or use **Boolean › Slice** with a solid tool.

Related:

Boolean, Cut Curve, Extrude, Pipe, Imprint Curve-Body.
:::

## Fillet

::: {.command name="Fillet Shell" key="[B]{.key}" documented="1.3"}
Fillets (rounds) or chamfers (bevels) the edges of solids and sheets. A positive distance gives a fillet, a negative one a chamfer. The fillet profile can be Conic, Chordal (constant chord length) [1.3]{.ver}, G2 (curvature-continuous) or Full [24.1]{.ver}, and variable distance and range limits let a fillet change size or stop part-way along an edge.

![](figures/c07-fillet-shapes.svg)

Before you start:

- Edge mode ([2]{.key}). Select one or more edges.
- Selecting an edge shared by two faces starts the command automatically. This auto-start is one of the *Auto-invoke commands* under **Preferences › Commands** (toggle **Fillet**).
- Otherwise press [B]{.key}. [B]{.key} is a unified Fillet key: with edges selected it runs Fillet Shell, with curves Fillet Curve, with vertices Fillet Vertex.

Step by step:

1. Select the edges. The command starts, or press [B]{.key}.
2. Drag the yellow dot to set the distance: positive values make a fillet, negative values a chamfer. Press [D]{.key} to set the fillet distance by moving the cursor, or type the value.
3. [Ctrl]{.key}+click an edge to add it; [Ctrl]{.key}+click it again to remove it.
4. Set the shape and other options, then confirm.

**Copying a radius:** click an existing fillet to copy its radius. This works only for the **Conic** shape and when both distance values are the same.

**Variable fillet:** press [V]{.key} to add a variable point on the fillet.

**Limiting the range:** press [L]{.key} and click on the fillet's centre line to add a limit point; click it again to reverse the direction. Up to two limit points; Object Snaps must be on.

Options explained:

- **Distance** – the size of the fillet or chamfer; positive for a fillet, negative for a chamfer.
- **Shape** (fillet):
  - **Conic** – a natural, smooth transition using a conic section curve.
  - **Chordal** – keeps a constant chord length across the fillet, so it looks the same whatever the angle between the faces [1.3]{.ver}.
  - **G2** – curvature-continuous with both adjacent faces, for high-quality surfacing.
  - **Full** – tangent to all three neighbouring faces (left, centre and right), so the whole centre face is rounded over. Select the two edges of that face. The 24.1 release notes call it *Full Round* [24.1]{.ver}.
- **Tension** [25.2]{.ver} – how pronounced or subtle the fillet looks. Available for every shape except Full.
- **Y-Blend › Attempt** – where three blends meet at one point (a "Y"), tries to build better topology there and avoid poor results.
- **Selection › Add tangent edges** ([T]{.key}) – when on, edges tangent to the selected ones are filleted too; turn it off to fillet only the selected edges.
- **Chamfer Shape**:
  - **Offset** – the default chamfer.
  - **Apex** – reduces how far the border of the chamfer surface is displaced.
  - The other options are the same as for a fillet.

**Circular fillets and other blends.** The docs never say which shape gives a constant-radius circular cross-section. They call the size *Distance*, while the copy tip and Remove Fillets from Shell speak of a *radius*. From general geometry [ADVICE]{.advice}: a circular arc is one special case of a conic, so a Conic fillet may or may not be circular depending on its shape and Tension; a G2 fillet next to a flat face must start with zero curvature, so its section cannot be a single circular arc; and a circular section with a constant chord would need a different radius wherever the face angle changes. Where a drawing needs a true radius, check the result before relying on it.

Keys:

- [D]{.key} fillet distance by moving the cursor.
- [C]{.key} chamfer distance; [A]{.key} chamfer angle by moving the cursor (or set the two distance values directly).
- [V]{.key} add a variable point; [L]{.key} add a limit point (needs Object Snaps; up to two).
- [T]{.key} toggle Add tangent edges.
- [Ctrl]{.key} modify selection – [Ctrl]{.key}+click adds or removes edges.

Common problems:

- Selecting an edge does not start the fillet → the auto-start is off. Turn on *Auto-invoke commands* and *Fillet* under Preferences › Commands, or press [B]{.key}.
- More edges are filleted than you selected → **Add tangent edges** is on. Press [T]{.key} to turn it off.
- Odd shapes where three fillets meet → turn on **Y-Blend › Attempt**.
- Clicking a fillet does not copy its radius → copying works only with the Conic shape and equal distance values.
- The limit point cannot be placed → turn on Object Snaps.
- Fillets fail or give bad corners → check the order: go from the largest radius to the smallest (see Tips).

Tips:

- Leave fillets late in the model: faces are easier to push, draft or Boolean before they are rounded.
- Fillet the largest radii first, then the smaller ones. If all the fillets are the same size, start with the edges between faces at the widest, most open angles. This is the summary of the official "Fillet Order of Operations" page, which uses videos made in other CAD programs as general reference.

Related:

Remove Fillets from Shell, Fillet Curve · Fillet Vertex, Offset Edge; *When geometry fails* (chapter 10).
:::

::: {.command name="Remove Fillets from Shell" documented="26.2"}
Removes fillets from solids and sheets. You can limit it to fillets up to a maximum radius, and to convex or concave fillets only. Use it to clean up an imported model before editing it, or to redo fillets in a better order.

Before you start:

- Select the solid or sheet to clean up (Body mode, [4]{.key}).
- No default key: run it from the Command Palette.

Step by step:

1. Select the body.
2. Search for *Remove Fillets From Shell* in the Command Palette and run it.
3. Set **Max Radius** and **Convexity**, then confirm.

Options explained:

- **Max Radius** – the largest fillet radius to remove. Larger fillets are left alone.
- **Convexity**:
  - **Any** – removes fillets of either kind.
  - **Convex** – removes only convex fillets (rounded outside edges).
  - **Concave** – removes only concave fillets (rounded inside corners).

Tips:

- To redo fillets in a better order, remove them, change the model, then fillet again from the largest radius to the smallest.

Related:

Fillet Shell.
:::
