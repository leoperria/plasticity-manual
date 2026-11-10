# Practical workflows {.pagebreak}

The earlier chapters describe one tool at a time. This chapter connects them: how far a Plasticity model stays editable, a first project from sketch to export, a routine for geometry that will not build, a surface-quality exercise, and a compatibility overview. It links to the command cards for details instead of repeating them.

## Direct modelling, editability and persistence

**General information (not specific to Plasticity).** CAD programs broadly follow two approaches. *History-based* (feature-based, parametric) modellers record an ordered list of features – sketch, extrude, fillet – that you can reopen, change and replay. *Direct* modellers keep the resulting geometry and let you change it by editing faces, edges and curves themselves. Many programs mix both.

**What the official docs describe for Plasticity.** The docs describe no feature tree or history timeline. The Outliner lists objects – bodies, curves, groups, construction planes, meshes, images and measurements – not the operations that made them. You change a model by running further commands on its geometry. Treat this as direct modelling.

| State | What you can change | Source |
|-----------------|-------------------------------------|-------------|
| A command is active | Values in the command dialog, the gizmo and handles, and the in-command keys on each card. | each command page |
| A command has been confirmed | Undo ([Ctrl+Z]{.key}) or redo ([Ctrl+Shift+Z]{.key}). [Shift+R]{.key} repeats the last command. The docs describe no way to reopen a confirmed command's settings. | General page |
| A finished body | Edit it with more commands, for example [Offset Face (Push Face)]{.cmd}, [Delete Face]{.cmd} or [Remove Fillets from Shell]{.cmd}. | command pages |
| Curves | Curves are objects of their own and can be edited, for example through their control points. The docs do not say that a body updates when you edit the curve it was built from. | Object Types page |
| Instances | Each instance references its master. A change to the master shows in every instance at once. Instances are read-only. [Realize Instances]{.cmd} turns them into independent, editable bodies. | Create Instance page |
| Constraints [STUDIO]{.studio} [26.2]{.ver} | Constraints stay enforced while you transform geometry in the current session. They are **not saved** in the project file. | Constraint System page; 26.2 notes |

**Persistence.** Save the document with [Ctrl+S]{.key}. *Quick save version* saves a copy with a timestamp appended to the file name. Autosave at an interval you set in Preferences was added in 2024.2 [24.2]{.ver}. Preferences › Backup gives the backup folders. From 26.2 you can right-click the file tab to browse backup files, or to revert to the last saved state [26.2]{.ver}. Importing a `.plasticity` file brings in meshes, images and instances [26.2]{.ver}. The docs do not say which other items (for example measurements) are saved with the file.

Tips:

- Because confirmed steps are hard to reopen, keep the curves you built a feature from (on a hidden or locked group) and save numbered versions at milestones. Then a design change means rebuilding one step, not the whole model [ADVICE]{.advice}.

## A first complete project

This project builds a small open tray, 80 × 50 × 30 mm, with 2 mm walls, rounded corners and a drain hole. It uses sketching, an extrusion, a hollow, fillets, a cut and an export. Each step names the card that has the details. For confirming and cancelling, see *Confirming, cancelling and repeating commands* in chapter 3.

### Set up {-}

1. Start a new document and set **Length** to Millimeter under the Grid and Units settings (official page *Grid and Units*).
2. Work on the default ground construction plane in a top view.

### 1 – Sketch the outline {-}

1. Start [Corner · Center · Three-Point Rectangle]{.cmd} from the toolbar. Click the first corner.
2. Press [Tab]{.key} to type the dimensions: 80 and 50. Confirm.
3. The closed rectangle encloses a **region**, shown in dark blue (official page *Object Types*).

### 2 – Make the solid {-}

1. Click the region. Selecting a region starts [Extrude]{.cmd}.
2. Type 30 in the **Distance** field, or drag the yellow dot. Confirm. You now have a box-shaped solid.

### 3 – Round the vertical corners {-}

1. Press [2]{.key} for Edge mode and click one vertical edge. Fillet starts ([Fillet Shell]{.cmd}; [B]{.key} if the auto-start is off).
2. [Ctrl]{.key}+click the other three vertical edges.
3. Type 8 in **Distance**. A positive value gives a fillet; a negative value gives a chamfer. Confirm.

### 4 – Hollow it into a tray {-}

1. Press [3]{.key} for Face mode and select the top face.
2. Run [Hollow]{.cmd} from the Command Palette ([F]{.key}). Selecting a face makes an *open* hollow solid.
3. Type 2 in **Thickness** and confirm. The docs do not say whether the wall is added inside or outside the original faces; you check this in Step 7. If Hollow fails, see *When geometry fails* below.

[Thicken · Thicken Face]{.cmd} is the counterpart for sheets: it gives a sheet a thickness.

### 5 – Cut the drain hole {-}

1. Draw a circle 10 mm across on the ground plane, inside the tray's footprint ([Center Circle · Two-Point Circle · Three-Point Circle]{.cmd}). Press [Tab]{.key} and type 10: in Center Circle the value is the diameter [25.1.9]{.tested}.
2. Click inside the circle to select its region. Extrude starts.
3. Press [W]{.key} for **Difference**, so that the extrusion cuts into the target body. If the tray is not picked as the target, use **Select target bodies** in the dialog.
4. Press [S]{.key} (Lock distances) to extrude by the same distance on both sides, and type 5. The tool now goes 5 mm below and above the 2 mm floor. It does not stop exactly on the floor's underside (see the Tips under [Boolean]{.cmd}). Confirm.

### 6 – Soften the rim {-}

1. In Edge mode, select the top edges of the wall. [Alt]{.key}+click selects an edge loop (official page *Selecting Objects*).
2. Fillet with a small Distance, for example 0.5. Smaller than the 8 mm corners, so it follows the large-to-small rule (official page *Fillet Order of Operations*).

### 7 – Check, save and export {-}

1. Check the important sizes with [Measure Distance]{.cmd} ([Ctrl+=]{.key}): outer length 80, wall 2. If the outside has grown to 84 × 54, the wall was added outside. Undo to Step 4 and decide which size matters: draw the outline 4 mm smaller, or keep it.
2. Save with [Ctrl+S]{.key}.
3. Select the tray and run [Export]{.cmd} ([Ctrl+Shift+E]{.key}). Choose **STEP** for other CAD programs, or **STL** or **3MF** for 3D printing. For STL you can set the length unit for the slicer [26.1]{.ver}.

Tips:

- The order above – main form, corner fillets, hollow, cut, small fillets last – is one common choice, not the only one. If Hollow fails on the filleted box, undo and try Hollow before Step 3 [ADVICE]{.advice}.

## When geometry fails

Use this order when a Boolean, fillet, hollow, thicken, join, region or import does not give a result, or gives a wrong one. Stop as soon as you find the cause.

1. **Look at what Plasticity shows.** From 26.2, a failed **Boolean**, **Hollow** or **Thicken** highlights the problem area in red [26.2]{.ver}. Loft marks guide curves that do not touch the profiles with a red dot [25.2]{.ver}. For other commands the docs describe no failure marker.
2. **Undo to the last good state** ([Ctrl+Z]{.key}). Save a copy (*Quick save version*) before you start experimenting.
3. **Isolate the parts involved** ([.]{.key}) so you can see them clearly.
4. **Check the inputs**, using the checks in the table below.
5. **Run a diagnostic.** Change one thing and see whether the command now works. For example, nudge the tool with [G]{.key} inside Boolean, reduce a radius, or reduce a thickness. A diagnostic tells you the *cause*; it is not the fix.
6. **Repair at the source, keeping your dimensions.** If the nudge worked, the cause was usually faces that coincide or only touch. Don't leave the model moved. Make the tool overshoot instead: lengthen it with Lock distances, or push its end face out with [Offset Face (Push Face)]{.cmd}. The target keeps its intended size. Confirm the result with [Measure Distance]{.cmd} [ADVICE]{.advice}.
7. **Simplify.** Do the operation in smaller steps: one tool at a time, or one group of fillet edges at a time.
8. **Ask for help.** If it still fails, the official support page lists a public Discord for everyone, including trial users. Include the file and the command settings.

| Symptom | Checks (documented unless marked) |
|----------------------|----------------------------------------------|
| Boolean fails or removes the wrong part | Red highlight [26.2]{.ver}. Target and tool the right way round (see [Boolean]{.cmd}). Faces that only touch, coincident or coplanar faces, tangent contact [ADVICE]{.advice}. |
| Fillet fails or gives bad corners | Go from large to small radii. **Y-Blend › Attempt** where three fillets meet. A radius bigger than a neighbouring face cannot fit [ADVICE]{.advice}. [Remove Fillets from Shell]{.cmd} to go back a step. |
| Hollow or Thicken fails | Red highlight [26.2]{.ver}. The **Max** mode of the Curvature shader shows regions that would self-intersect at a given offset distance [26.2]{.ver}. Try a smaller thickness than the tightest concave radius [ADVICE]{.advice}. |
| Sheets will not join | [Join Sheets]{.cmd} needs edges that are perfectly aligned. Look for a gap with [Measure Continuity]{.cmd} on G0 (it reports positional deviation). |
| A body is not solid | [Find Boundary Edges]{.cmd} selects the open edges. The Face direction shader shows reversed faces (blue outward, red inward). See [Reverse Sheet]{.cmd}. |
| No region appears | Regions need curves that enclose an area on a plane. Above about 700 curves per plane, regions are no longer displayed (also for SVG imports). Close gaps with [Join Curves]{.cmd} or snapping [ADVICE]{.advice}. |
| Import arrives as sheets or meshes | Run [Find Boundary Edges]{.cmd} and [Join Sheets]{.cmd} on sheets. Meshes are a separate object type; [PolySplines]{.cmd} [STUDIO]{.studio} converts meshes into NURBS. See chapter 9 for format limits. |

## Surface quality: continuity, combs, tolerances and reflections

### Three levels of continuity {-}

The levels describe how two curves or surfaces meet (official page *Continuity of Curves and Surfaces*):

- **G0** – positions match.
- **G1** – positions and tangents (directions) match.
- **G2** – positions, tangents and curvature match.

Each level includes the ones below: a G2 join is also G1 and G0. G0 alone *allows* a sharp kink but does not *require* one; a join that is only reported as G0 may still be smooth (general theory). Plasticity measures G0 to G2 at surface edges; it does not support G3.

### Two kinds of comb {-}

| | Curvature comb | Continuity (deviation) display |
|----------|------------------------------|------------------------------|
| Command | [Toggle Curvature (Measure Curvature)]{.cmd} | [Measure Continuity]{.cmd} [25.2]{.ver} |
| Shows | How sharply one curve or edge bends along its length. Line length is proportional to curvature (1/radius); the red envelope joins the tips. A straight segment shows no comb. | How far two adjoining edges are from meeting at G0, G1 or G2. **G0** reports positional deviation in your units, **G1** angular deviation in degrees, **G2** curvature deviation as a normalised value from 0.0 to 1.0. |
| Pass / fail | None. You read the shape of the comb. | Markers: green tick = within tolerance; yellow tick = G2 "flat" special case (deviation 1.0); yellow warning = this level passes but a lower one fails; red cross = out of tolerance. **Show maxes** shows the values. |
| Display control | **Comb scale** in the Curvature panel (default 0.1), or the autosize button | **G0 / G1 / G2 Scale** in the Curvature panel |

**Scale is not tolerance.** The Comb scale only changes how long the comb lines are drawn. For the G0/G1/G2 Scale fields the docs conflict. The Measure Continuity page says they adjust *the visual scale of combs and deviation plots*. The Edge Align page says they *adjust tolerance scales for respective continuity checks*. The docs give no numerical acceptance tolerances behind the markers. Until this is tested, don't change a scale to make a marker turn green.

### Exercise: G0 pass and G1 fail, G1 pass and G2 fail {-}

Write down your results in a table with these columns: pair, level, deviation shown, marker. The expected results come from general theory; this manual has not measured them.

1. **Pair A – a corner.** Draw a [Line]{.cmd}. Start a second Line at its end point, at an angle of about 30°. Extrude each line separately by the same distance in the same direction ([Extrude]{.cmd}), so that you get two sheets meeting along an edge.
2. Select the two touching edges and run [Measure Continuity]{.cmd}. Press [Tab]{.key} to cycle G0, G1 and G2, and turn on **Show maxes**. *Expected:* G0 within tolerance; G1 out of tolerance, with an angular deviation close to the angle you drew.
3. **Pair B – a fillet.** On a box, fillet one edge with **Shape** set to Conic, and another edge with Shape set to G2 ([Fillet Shell]{.cmd}). Measure the continuity between each fillet face and its flat neighbour. *Expected:* both are G1. The conic fillet fails at G2, because its curvature jumps from zero on the flat face to a non-zero value. The docs describe the G2 shape as curvature continuous with both neighbours, so it should pass. Whether Measure Continuity accepts the shared edge of a solid or needs separate sheets is not documented. If it needs sheets, use [Unjoin Faces · Unjoin Shells]{.cmd} on a copy.
4. **Combs.** Select the edge where each fillet meets the side face of the box, and run [Toggle Curvature (Measure Curvature)]{.cmd}. The side face does not count here: it is a plane, and a straight segment shows no comb. Compare the comb at the two ends of each fillet edge. Raise **Comb scale** and check that the markers from steps 2 and 3 do not change.
5. **Reflections.** Switch the shader to **Horizontal Zebra Reflection** or **Vertical Zebra Reflection**, then to **Isophote/Isoangle**, and set the stripe count under Material Options. In general, stripes break or jump at a G0 join, meet with a corner at a G1 join, and run on smoothly at G2. Compare that with your markers.
6. **Curvature shader** [26.2]{.ver}. Try **Mean** and **Max**. Extruded sheets bend in one direction only, so their Gaussian curvature is zero everywhere (general theory), and **Gaussian** mode shows little on Pair A.
7. Optionally turn on Render Mode and try different HDRIs, to see how the joins look under environment lighting. The docs describe the HDRIs as lighting, not as an analysis tool.

Tips:

- Before you buy, or before you rely on a format, check the current pages above. Licence terms and format support change between releases [ADVICE]{.advice}.
