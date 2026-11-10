# Import, export and sharing

These tools move your work in and out of Plasticity: bring in files from other programs, save the model in formats that other CAD, rendering and 3D-printing software can read, make technical drawings, and share a view-only 3D preview through a web link. Most of them live in the P-Menu or the Command Palette ([F]{.key}).

| I want to… | Use |
|--------------------------------|------------------|
| Bring a STEP, Parasolid, mesh, SVG or image file into the scene | Import / Append |
| Merge another Plasticity document into the open one | Import / Append |
| Save the model as STEP, Parasolid, STL, 3MF, IGES or SAT | Export |
| Turn solids and sheets into a polygon mesh for rendering or games | Export OBJ |
| Save flat 2D curves as a vector file | Export SVG |
| Make a technical drawing of a 3D model, with hidden lines and hatching | Export Hidden Line |
| Show a 3D model to someone through a web link | Publish to Plasticity Share |

**File formats by licence.** The official Import/Export page lists these formats. ✓ = Indie and Studio licences; [STUDIO]{.studio} = Studio licence only; – = not supported. *Export command* is the format's own command in the Command Palette, as named on that page.

| Format | Files | Import | Export | Export command | Notes |
|--------------|--------------|-------|-------|--------------|------------------------------------|
| Plasticity | .plasticity | ✓ | ✓ | – | Import also brings in meshes, images and instances [26.2]{.ver} |
| STEP | .stp, .step | ✓ | ✓ | Export STEP | |
| Parasolid | .x\_t, .x\_b | ✓ | ✓ | Export Parasolid | |
| Wavefront OBJ | .obj | ✓ | ✓ | Export Obj | Export options: see Export OBJ |
| STL | .stl | ✓ | ✓ | Export Stl | Unit asked on import; unit override on export |
| FBX | .fbx | ✓ | – | – | |
| Vector image (SVG) | .svg | ✓ | ✓ | Export Svg | Import: above 700 curves on one plane, that region's overlay is not displayed |
| Image | .png, .jpg, .jpeg | ✓ | – | – | Reference images |
| 3MF | .3mf | ✓ | ✓ | Export 3mf | |
| IGES | .igs, .iges | [STUDIO]{.studio} | [STUDIO]{.studio} | Export Iges | |
| SAT (ACIS) | .sat | [STUDIO]{.studio} | [STUDIO]{.studio} | Export SAT | |
| Rhino | .3dm | [STUDIO]{.studio} | – | – | BREP, NURBS and curve data only |
| DXF / DWG | .dxf, .dwg | [STUDIO]{.studio} | – | – | 2D curves only; Windows only |

::: {.command name="Import / Append" key="[Ctrl+Shift+O]{.key}" documented="1.3"}
Brings a file from another program, or another Plasticity document, into the document you have open. Use it to start from a supplier's STEP model, to model over a reference image or scan mesh, or to reuse parts saved in another .plasticity file. The file is added to the current scene; nothing in your document is replaced.

Appending a .plasticity file keeps its groups, names and materials [24.2]{.ver}, and also brings in its meshes, images and instances, so a file with many objects comes in as it was saved [26.2]{.ver}.

Before you start:

- Check the format table at the start of this chapter. IGES, SAT, Rhino and DXF/DWG import need a Studio licence.
- For a reference image, first choose the plane it should lie on: the XY, YZ or XZ plane, or a construction plane. (The official page prints "XY, YX, and XZ"; YX is not a separate plane.)

Step by step:

1. Open the P-Menu and choose **Import/Append**, or press [Ctrl+Shift+O]{.key}. You can also drag a file into the 3D viewport, or drag a file from the **Recent Files** list into the viewport [25.1]{.ver}.
2. In the file dialog, select the file and confirm.
3. For an OBJ or STL file, confirm the units when Plasticity asks [24.1]{.ver}.
4. The objects appear in the viewport and the Outliner. Imported images and OBJ files are named after the file [24.1]{.ver}. Meshes and images have their own sections in the Outliner [24.2]{.ver}.

Options explained:

What you get depends on the format:

- **Plasticity (.plasticity)** – merged into the open document with groups, names and materials [24.2]{.ver}; meshes, images and instances [26.2]{.ver}.
- **STEP** – keeps the colours [24.2]{.ver}.
- **Parasolid (.x\_t, .x\_b)** – keeps colours, names and assemblies [24.2]{.ver}.
- **SVG** – brings in curves [24.2]{.ver}. If one plane holds more than 700 curves, the region on that plane is not displayed, because drawing its blue overlay becomes too costly. The docs describe a display limit for the region overlay; they do not say that curves are left out.
- **Meshes** – OBJ, STL (STL [1.3]{.ver}), FBX [1.4]{.ver} and 3MF [24.2]{.ver} come in as mesh objects, for reference. You can snap to their vertices and faces [24.2]{.ver}.
- **STL units** – an STL file stores bare coordinates with no standard length unit (general file-format fact; some programs write a unit into the free-text header, but readers need not use it). That is why Plasticity asks which unit the numbers are in [24.1]{.ver}.
- **Images: PNG, JPG/JPEG** – placed on the plane you chose, as an *Image* object in the Outliner. You can snap to their corners [24.2]{.ver}.
- **Studio only** [STUDIO]{.studio} – IGES, SAT (ACIS), Rhino (.3dm, BREP/NURBS/curve data only; Rhino 8 files [24.1]{.ver}) and DXF/DWG (2D curves only).

Keys:

- [Ctrl+Shift+O]{.key} Import/Append. With an imported image selected, [M]{.key} opens its material settings (see Tips).

Common problems:

- IGES, SAT, Rhino or DXF/DWG files cannot be imported → they need a Studio licence.
- DXF/DWG import is missing on your system → the current Import/Export page limits it to Windows (see Older versions).
- Part of an imported SVG shows no blue region → more than 700 curves lie on one plane. First check whether the curves are there (Outliner, or select them); the documented limit concerns the region overlay. To bring the region back, reduce the number of curves on that plane, for example by deleting paths you do not need or joining many short segments into fewer paths in the drawing program. Splitting the SVG into several files is not a guaranteed fix: if the files land on the same plane, that plane still holds the same curves.
- An imported mesh is the wrong size → STL and OBJ carry no reliable unit; choose the unit the file was written in when Plasticity asks [24.1]{.ver}. A factor of 10, 25.4 or 1000 points to a mm/cm/inch/metre mix-up.
- A mesh cannot be filleted or pushed like a solid → meshes are reference objects, not NURBS bodies. **PolySplines** [STUDIO]{.studio} converts mesh objects into editable NURBS surfaces [26.1]{.ver}.

Tips:

- Reference images: select the image and press [M]{.key}. **Depth** sets how it mixes with the model (*Normal*: hidden by objects in front, hides objects behind; *Front*: always visible, needs **Opacity** below 1; *Behind*: objects are always drawn in front of it). **Opacity** (tick the checkbox) sets the transparency. **Culling** shows it from the front only or from both sides. Confirm with OK or right-click.
- **Viewport: Toggle Images** and **Viewport: Toggle Meshes** hide or show all images or meshes in the viewport without changing their visibility in the Outliner [26.2]{.ver}.
- When you snap to a mesh, a partial wireframe highlights the triangle you are snapping to [26.2]{.ver}.
- After importing an STL, measure a dimension you know (for example the overall length from the supplier's drawing) before modelling on it.

Older versions:

- The 1.4 release notes announced DXF/DWG import for Windows and Linux (Studio). The current Import/Export page says Windows only; the docs do not say when Linux support ended, or whether the page is wrong.

Related:

Export, PolySplines, Set Material, Place.
:::

::: {.command name="Export" key="[Ctrl+Shift+E]{.key}" documented="1.3"}
Saves your model in another file format, so that other CAD programs, 3D printers, renderers or drawing programs can use it. **Save As** ([Ctrl+Shift+S]{.key}) saves a Plasticity document; Save As and Export are separate commands [1.4]{.ver}.

What gets exported: for OBJ, the docs say the selected solids and sheets are exported, or all displayed solids and sheets when nothing is selected; the 25.3 notes add mesh objects and unrealised instances [25.3]{.ver}. For the other formats the docs do not say what is exported with an empty selection, or how hidden objects and instances are treated, so check the file (see Tips).

Before you start:

- Select the objects to export.
- Check the format table at the start of this chapter: IGES and SAT export need a Studio licence.

Step by step:

1. Select the objects.
2. Open the P-Menu and choose **Export**, or press [Ctrl+Shift+E]{.key}. You can also run the format's own command from the Command Palette, for example **Export STEP** or **Export SAT** [STUDIO]{.studio} [25.2]{.ver} (all of them are listed in the format table).
3. In the save dialog, enter a file name and choose the file type. The dialog suggests the last file name you used [24.1]{.ver}.
4. For some formats a second dialog with options appears (OBJ, STEP, STL; see below). Set the options and confirm with OK.

Options explained:

- **STEP** – keeps colours, and keeps groups as assemblies [24.2]{.ver}. The STEP export dialog can convert analytic surfaces to NURBS and lets you choose the STEP version [24.1]{.ver}. The docs do not list the STEP versions on offer.
- **STL** – lets you override the length unit written for the file: millimetre, centimetre, metre, inch or foot [26.1]{.ver}. Because STL has no standard unit field, the receiving program still has to be told (or assume) the same unit.
- **OBJ** – a full set of mesh options; see Export OBJ.
- **SVG** – exports 2D sketches only; see Export SVG. For drawings of 3D bodies use Export Hidden Line.
- **Parasolid, 3MF, IGES, SAT** – the docs describe no export options.

Keys:

- [Ctrl+Shift+E]{.key} Export; [Ctrl+Shift+S]{.key} Save As (Plasticity document).

Common problems:

- The file holds more or less than you expected → check the selection and what is visible, then re-import the file to see what it contains.
- IGES or SAT is not offered → these formats need a Studio licence.
- An STL file is the wrong size in the slicer → set the length unit in the STL export to the unit the slicer expects [26.1]{.ver}, and check the slicer's own import unit.

Tips:

- As a rule of thumb: STEP or Parasolid for other CAD programs (they keep exact surfaces), STL or 3MF for 3D printing, OBJ for rendering, game engines and sculpting.
- If another program has trouble reading your STEP file, try the option to convert analytic surfaces to NURBS, or another STEP version.
- Before you send a file, check: the right objects are selected; nothing you need is hidden and nothing you do not want is visible; instances come through as you expect (realise them with **Realize Instances** if the receiver cannot handle instances); the unit and up axis suit the receiver. Then import the file into an empty document and compare (see *Checking an export: a round-trip exercise* at the end of this chapter).

Related:

Import / Append, Export OBJ, Export SVG, Export Hidden Line, Realize Instances.
:::

::: {.command name="Export OBJ" documented="1.3"}
Turns solids and sheets into a polygon mesh and saves it as a Wavefront OBJ file, for rendering, game engines, sculpting or other 3D programs. Plasticity models with exact NURBS surfaces, so the mesh is always an approximation: the options decide how many polygons are used and how closely they follow the curved surfaces. The file includes UVs and an MTL file [24.2]{.ver}. The diagram is schematic: it shows the effect of the settings, not Plasticity's exact polygon counts.

![](figures/c09-obj-density.svg)

Before you start:

- Select the solids or sheets to export. If nothing is selected, all displayed solids and sheets are exported.
- Find out which unit and up axis the target program uses (see the table under **Scale** below).

Step by step:

1. Select the objects.
2. Open the P-Menu and choose **Export** ([Ctrl+Shift+E]{.key}); the OBJ page calls it *Export/Save as…*. The Command Palette also has **Export Obj**.
3. In the save dialog, enter a file name and choose **Wavefront OBJ (\*.obj)** as the file type.
4. The **Export OBJ** dialog appears. Turn on **Show Wireframe** to see the polygons, set **Density** first, then fine-tune with the other options.
5. Click OK. The OBJ file is exported.

Options explained:

- **Topology** – the shape of the polygons:
  - **Tris** – triangles only.
  - **Quads** – quadrilaterals and triangles.
  - **Ngons** – polygons with any number of sides, including quads and tris.
- **Show Wireframe** – shows the wireframe of the mesh, so you can judge topology, density and surface quality before exporting. The preview can use the current matcap, and the wireframe can be turned off while you inspect it [24.1]{.ver}.
- **Density** – overall polygon density, and the only value that adjusts the other settings automatically. Lower gives fewer polygons and a rougher shape; higher gives more polygons and more detail.
- **Min Width** – the smallest polygon size. Increase it to avoid crowds of tiny polygons, for example on small fillets.
- **Max Width** – the largest polygon size. Decrease it to avoid very large polygons or to make polygon sizes more even. This is a *size* limit, not an accuracy limit: on a flat face any polygon size meets a deviation tolerance (general theory), so Max Width is the setting the docs give for limiting polygon size there.
- **Edge Plane Tolerance** – the largest allowed deviation of edges, in cm. Like Face Plane Tolerance, but it affects edges and face boundaries more than face centres.
- **Face Plane Tolerance** – the largest allowed deviation, in cm: how far the mesh may stray from the true surface. Lower gives more polygons and more detail; higher gives fewer polygons and a rougher shape. One of the most effective ways to control the polygon count. The docs recommend low poly 0.01 and high poly 0.0001, and also say that if you need less than 0.001 you should decrease **Max Width** instead. These two recommendations conflict (see the note after this card).
- **Edge Angle Tolerance** – the largest allowed angular deviation of edges, in radians. Like Face Angle Tolerance, but it affects edges and face boundaries more than face centres. Recommended: low poly 0.35, high poly 0.15.
- **Face Angle Tolerance** – the largest allowed angular deviation, in radians. Lower follows curved surfaces faithfully with more polygons; higher follows them roughly with fewer. Recommended: low poly 0.35, high poly 0.15.

The **Advanced** group of the dialog:

- **Curve Max Length** – the largest allowed length of a curve segment. The docs say no more.
- **Plane Angle** – the largest allowed ratio between plane tolerance and max width; useful for getting more quadrangles or polygons.
- **Remove Small Features** [25.3]{.ver} – leaves out details smaller than a bounding-box size you set. Useful for high-poly to low-poly work with texture baking, and for general mesh clean-up.
- **Inflect** [24.1]{.ver} – adds detail where curved surfaces change from convex to concave, to keep surface quality. The 24.1 release notes call it *Inflexion* and say it adds extra cuts for higher resolution; turn it off for more even topology.
- **Simplify Radial Surfaces** [25.3]{.ver} – lines up spheres, cylinders, tori and cones along a common axis so that edge flow is more predictable and edges stay continuous. Works best on fairly simple shapes.
- **Convex Ngons Only** [25.3]{.ver} – only with Topology set to **Ngons**. Forces every ngon to be convex, adding extra faces where needed. Programs such as RizomUV and 3ds Max can show wrong normals or shading with concave ngons; this gives reliable topology and shading for a few more ngons.
- **Scale** [26.1]{.ver} – multiplies all exported coordinates, so that the units come out right in the target program.
- **Up Axis** [26.1]{.ver} – sets which axis points up, to match the target program.

The 26.1 release notes give these values:

| Target program | Its default unit | Scale (working in cm) | Scale (working in mm) | Up Axis |
|--------------|--------------|--------------|--------------|--------------|
| Blender | metre | 0.01 | 0.001 | Z up |
| Unreal Engine | centimetre | 1.0 | 0.1 | Z up |
| Maya | centimetre | 1.0 | 0.1 | Y up |
| Unity | metre | 0.01 | 0.001 | Y up |
| 3ds Max | inch | 0.3937 | 0.03937 | Z up |
| Cinema 4D | centimetre | 1.0 | 0.1 | Y up |

Common problems:

- The mesh is too heavy → lower **Density**, or raise **Face Plane Tolerance** and the angle tolerances towards the low-poly values.
- Curved surfaces look faceted → lower **Face Angle Tolerance** and **Edge Angle Tolerance** towards 0.15.
- Crowds of tiny polygons on small fillets → increase **Min Width**, or use **Remove Small Features**.
- Very large or uneven polygons on big flat faces → decrease **Max Width**.
- The model is the wrong size or lies on its side in the other program → set **Scale** and **Up Axis** (table above).
- Shading errors in RizomUV, 3ds Max and similar programs with Ngons → turn on **Convex Ngons Only**.

Tips:

- Export OBJ also exports mesh objects (the 25.3 notes call them "empty meshes (e.g., STL, FBX, OBJ)"; before 24.2 the Outliner listed meshes as empties) and instances that have not been realised. If nothing is selected, everything visible is exported [25.3]{.ver}.
- Max Width, the angle tolerances and Inflect have tooltips with images that show their effect [25.1]{.ver}.
- For Blender, the Blender Bridge add-on transfers meshes directly, without an OBJ file in between [1.3]{.ver}.
- *Looks smooth* is not the same as *is accurate*. Smooth shading and normals can make a coarse mesh look round, and a faceted mesh can still be within a small distance of the true surface. Judge appearance in the wireframe preview; judge dimensions by measuring (general theory).
- The UVs in the OBJ come from a NURBS model, where each face has its own U/V parameters. A surface parameterisation is not the same as a production texture layout (seams placed, islands packed without overlap, even texel density). The docs do not describe how Plasticity lays the UVs out; check them in your UV editor before texturing and re-unwrap if needed (general theory).

Related:

Export, Create Instance, Realize Instances, Import / Append.
:::

::: {.command name="Export SVG" version="25.3"}
Saves 2D sketches as an SVG vector file, which you can open in drawing programs or send to a cutter. It exports only 2D sketches that are relatively flat along an axis, and it works with or without a selection of curves. Sketches that lie on different planes or axes are saved as separate files. Rotated or tilted sketches are exported too, but the result is sometimes unreliable.

For drawings of 3D bodies, with hidden lines and hatching, use **Export Hidden Line** instead.

Before you start:

- Draw or place the sketch flat on a plane, ideally one of the main planes or a construction plane.
- Save the document if you want the SVG next to it (see step 2).

Step by step:

1. Select the sketch you want to export.
2. Start the export in one of two ways:
   - Open the P-Menu and choose **Export**, or press [Ctrl+Shift+E]{.key}. Choose where to save the SVG file and confirm.
   - Run **Export Svg** from the Command Palette. The SVG is saved automatically in the folder of the saved document; if the document is untitled, it goes to your Documents folder.
3. The SVG file is exported.

Common problems:

- You get several SVG files → the sketches lie on different planes or axes, and each is saved separately. Move them onto one plane for a single file.
- A tilted sketch comes out wrong → rotated or tilted sketches are sometimes unreliable. Lay the sketch flat on a main plane before exporting.
- You cannot find the file after **Export Svg** → it is in the document's folder, or in Documents if the document has never been saved.

Tips:

- **Technical drawings from curves:** set up the view with a construction plane, then use **Alternative Duplicate** on solid edges to project curves onto the current construction plane, and export those curves (official Export SVG page).

Related:

Export Hidden Line, Alternative Duplicate, Export, Import / Append.
:::

::: {.command name="Export Hidden Line" version="26.1"}
Makes a technical drawing from your 3D model, like the drawing export of traditional CAD programs. It renders the objects from a chosen view and saves the result as an SVG file: views, hidden (occluded) edges, line styling, line colours from materials, the object shader as a shaded background, hatching, and grid views you can use as 2D templates. Unlike **Export SVG**, which exports flat 2D sketches only, it works from 3D objects.

![](figures/c09-hidden-line-types.svg)

Before you start:

- Save the document if you want the SVG next to it. Otherwise Plasticity asks where to save it.
- For **Section Hatching**, cut the model first with **Section Analysis**.
- To colour lines by material, assign materials first (**Set Material**, [M]{.key}).
- The docs do not say whether the export uses the selection or all visible objects; check the preview.

Step by step:

1. Open the Command Palette ([F]{.key}), search for **Export Hidden Line** and run it.
2. Choose a **Standard View**, or set up the view you want in the viewport and press [S]{.key} to capture it. The preview window updates.
3. Set the line styles, hidden lines and hatching in the command dialog (see below).
4. Confirm. If the document has a name and has been saved, the SVG is saved in the same folder; if it is untitled, choose where to save it.
5. The SVG file is exported. Complex models take some time, because the export is computationally intensive.

Options explained:

- **Standard Views** – sets the camera angle before export. There are nine choices:
  - **Top Left**, **Top Right** – isometric views from above, showing the top, the left or right side, and the front.
  - **Top** – orthographic view from above.
  - **Left**, **Front**, **Right** – straight orthographic views of that side.
  - **Bottom Left**, **Bottom Right** – isometric views from below, showing the bottom, the left or right side, and the front.
  - **Bottom** – orthographic view from below.
- **Style** – the line types and their thickness, from 0.00 to 10.00. Setting a thickness to zero hides that type:
  - **Visible Stroke** – hard edges where surfaces meet or change direction (convex or concave), as far as the camera can see them.
  - **Silhouette** – the outline of each object as seen from the camera, including the edges of overlapping objects. The docs warn that it may not give a clean outline in every case.
  - **Smooth** – the soft edges between surfaces that blend smoothly, such as the seam where a fillet meets a tangent face. They come from the object's construction geometry, and include surface imprint lines.
  - **Use Colors** – draws the lines of objects with a material in the material's colour instead of black.
- **Shaded Background** – adds the shaded look of the object behind the lines. **Pixel Scale** sets its resolution.
- **Hidden Lines** – shows the edges hidden behind visible surfaces, dashed:
  - **Stroke Width** – the width of each dash. It does not affect hidden smooth edges; those follow the **Smooth** setting in Style.
  - **Dash Length** – the length of each dash. At 0.0 the lines become dots.
  - **Dash Gap** – the space between dashes. At 0.0 hidden lines look continuous.
- **Planar Hatching** – hatching lines across all surfaces, made by intersecting them with a set of parallel planes. **Spacing** sets the distance between lines; **Axis XYZ** rotates the pattern about the X, Y and Z axes of the hatching plane.
- **Section Hatching** – hatching only on surfaces cut by **Section Analysis**. **Spacing** and **Axis XYZ** work as in Planar Hatching, on the section plane.
- **Radial Hatching** – hatching applied automatically to spheres and cylinders:
  - **Around** – density of the lines that run from pole to pole.
  - **Along** – density of the lines that run across the geometry, parallel to the equator.
  - **About** – density of the lines that wrap around the pole, spreading out from the top.
  - The official illustration shows *Around* on both spheres and cylinders, *Along* as rings on cylinders and *About* as rings around a sphere's pole.
- **Parametric Hatching** – hatching that follows the surface's own U and V isoparameter lines. Mainly useful for spline surfaces with a clean CV layout, but it can be applied to any surface. **U Spacing** and **V Spacing** set the line density in each direction.
- **Tolerance** – **Curve Chord Tolerance** and **Curve Chord Angle**. The docs do not describe them.

All hatching methods can be combined.

![](figures/c09-hatching.svg)

Keys:

- [S]{.key} Capture Screen: captures the current viewport view and updates the preview. Works in perspective, orthographic and isometric views.

Common problems:

- A line type is missing from the drawing → its thickness in **Style** is 0.
- Hidden lines look solid → **Dash Gap** is 0.0; increase it.
- Hidden lines are dotted → **Dash Length** is 0.0; increase it.
- Some hidden edges ignore **Stroke Width** → they are smooth edges; set them with **Smooth** in Style.
- No section hatching → it only appears on surfaces cut by **Section Analysis**; run that first.
- The outline is not clean → the docs note that **Silhouette** may not give a clean outline in every case.
- The export seems to hang → complex models take time; wait, or hide objects you do not need.

Tips:

- For a custom view, orbit the viewport to the angle you want and press [S]{.key}.
- Use **Use Colors** with materials to tell parts apart in the drawing.

Related:

Export SVG, Section Analysis, Set Material, Isoparam.
:::

::: {.command name="Publish to Plasticity Share" version="25.3"}
Uploads a view-only version of your model to the cloud and opens it in a new browser tab, with a unique link you can send to anyone. The docs say only the mesh representation is published, with no CAD geometry or source files, and that the Plasticity Share viewer offers no download or editing; this also keeps storage use low. Material information from the Assets menu is included.

What the recipient sees is a mesh made from your model, not the model itself: an approximation of the NURBS surfaces, without the exact geometry, the editable bodies or the document structure behind it.

Before you start:

- The feature is off by default. Turn on **Preferences › Web Publishing › Enable**, which lets Plasticity connect to the Web Publishing service.
- Select the object you want to publish.
- Every user gets 5 GB of cloud storage, whatever the licence.

Step by step:

1. Select the object.
2. Open the Command Palette, type **Publish To Plasticity Share** and run it. It is also in the P-Menu.
3. Plasticity asks "Are you sure you want to share to the web?". Click **Yes**.
4. A new browser tab opens with the published object, and a unique URL is created for it.
5. Copy the URL and share it.

**The web viewer:** the page shows the model as mesh data. **See all documents** lists everything you have published; **Sign Out** ends the web session. The panel on the right gives access to Shader Mode, Render Mode, Camera and Grid and Unit settings.

**Managing what you have shared:** choose **Manage my shared documents** in the P-Menu, or open the Plasticity Share page (share.plasticity.xyz/me/). Each document shows a thumbnail, the folder of the .plasticity file on your computer, a cloud storage indicator (how much is left) and a revision indicator (how many revisions are online). A document can have several revisions; you can manage and delete them there.

Keys:

- No default key. In the web viewer, middle mouse button orbits and right mouse button pans, as in Plasticity.

Common problems:

- The command does not work → Web Publishing is off by default; enable it in Preferences.
- The browser says "Not signed in" → share a document from Plasticity and refresh the tab to sign in.
- Storage is running out → delete old documents or revisions on the Plasticity Share page.
- The recipient wants an editable or exact file → Plasticity Share publishes a view-only mesh. Send a STEP or Parasolid file from **Export** instead.

Tips:

- The link is private when created, but once you share it, it is public: anyone who has it can view the model.
- "No download" is a feature of the viewer, not protection of the data. To display the model, the mesh has to reach the viewer's browser, so a determined person may be able to capture it (general web fact). Do not publish anything you would not want copied as a mesh.
- The thumbnail page shows the local folder of your .plasticity file; keep that in mind if folder names are confidential.
- Assign materials before publishing so that the preview shows them.

Related:

Export, Export OBJ, Set Material.
:::

### Checking an export: a round-trip exercise {-}

A round trip — export, import the file into an empty document, compare — is the quickest way to find unit, selection and accuracy problems before someone else does. This is an exercise: no measured values are given here, because none have been verified for this edition. Record your own.

1. Model a test part with known dimensions, for example a 100 mm × 60 mm × 20 mm box with a 10 mm fillet on one edge and a 20 mm diameter hole. Note the document unit.
2. Add one hidden body and one unrealised instance, and select only the box.
3. Export it as STEP, as STL (note the unit you choose) and as OBJ (note Density, Face Plane Tolerance and Max Width).
4. Open a new document and import each file in turn; for the STL and OBJ, choose the unit you exported with.
5. For each file, record: which objects arrived (did the hidden body or the instance come along?); the overall length, width and height; the hole diameter measured across two opposite points; and, for the meshes, the polygon count.
6. Repeat the OBJ export with a lower Face Plane Tolerance and compare the hole diameter and polygon count with step 5.

What to expect in general: STEP should give back exact surfaces, so its dimensions should match your model. A mesh hole measured across facet corners and across facet flats gives slightly different diameters; the difference shrinks as the tolerance gets smaller. A result that is off by a round factor (10, 25.4, 1000) is a unit problem, not a tessellation problem.
