# Quick-reference shortcut card {.pagebreak}

Current default keys in Plasticity 26.2 (Windows/Linux). Every binding is written out in full: "[Ctrl+Shift+S]{.key}" means hold Ctrl and Shift and press S; "[O]{.key}, then [O]{.key}" means press O twice in a row. "or" separates two bindings for the same action. Defaults changed in earlier versions are listed separately under *Changed defaults*; keys that only work while a command is running are under *Keys inside a running command*. Any binding can be changed from the Command Palette ([F]{.key}): right-click a command and assign a new key.

::: card
| View and interface |  | Select and edit |  | Model |  |
|----------|----------|-----------|---------|----------|----------|
| Command Palette | [F]{.key} | Control-point mode | [1]{.key} | Extrude | [E]{.key} |
| Suggested Commands | [Shift+F]{.key} | Edge mode | [2]{.key} | Boolean | [Q]{.key} |
| Orbit | drag with middle button | Face mode | [3]{.key} | Cut | [C]{.key} |
| Pan | drag with right button | Solid mode | [4]{.key} | Fillet | [B]{.key} |
| Zoom in steps | mouse wheel | All selection modes | [5]{.key} | Loft | [L]{.key} |
| Zoom continuously | [Ctrl]{.key} + middle-button drag | Toggle one mode | [Shift+1]{.key} … [Shift+4]{.key} | Pipe | [P]{.key} |
| Front · Right · Top | [Num 1]{.key} · [Num 3]{.key} · [Num 7]{.key} | Convert selection | [Ctrl+1]{.key} … [Ctrl+5]{.key} | Sweep | [Shift+P]{.key} |
| Back · Left · Bottom | [Ctrl+Num 1]{.key} · [Ctrl+Num 3]{.key} · [Ctrl+Num 7]{.key} | Select all | [A]{.key} | Offset (unified) | [O]{.key} |
| Perspective ↔ orthographic | [Num 5]{.key} | Invert selection | [Alt+A]{.key} | Slot | [O]{.key}, then [O]{.key} |
| Focus on selection | [/]{.key} | Select adjacent | [Ctrl+Shift+=]{.key} | Join | [J]{.key} |
| Isolate | [.]{.key} | Deselect all | [Esc]{.key} | Unjoin | [Alt+J]{.key} |
| CPlane from selection, align camera | [Space]{.key} | Hide selected | [H]{.key} | Trim | [T]{.key} |
| CPlane from selection, keep camera | [Shift+Space]{.key} | Hide unselected | [Shift+H]{.key} | Project | [I]{.key} |
| CPlane from camera, through origin | [Ctrl+Space]{.key} | Unhide all | [Alt+H]{.key} | Imprint | [Shift+I]{.key} |
| CPlane from camera, at a point | [Ctrl+Shift+Space]{.key} | Invert hidden | [Ctrl+H]{.key} | Raise Degree | [Shift+S]{.key} |
| X-ray | [Alt+Z]{.key} | Group selected | [Ctrl+G]{.key} | Slide CV | [Shift+G]{.key} |
| Overlays | [Alt+Shift+Z]{.key} | Ungroup selected | [Alt+G]{.key} | Isoparam | [Ctrl+R]{.key} |
| Left sidebar | [Ctrl+B]{.key} | Delete | [Shift+Backspace]{.key} (see note) | Untrim | [Alt+T]{.key} |
| Right sidebar | [Ctrl+Shift+B]{.key} | Dissolve | [Backspace]{.key} (see note) | Line | [Shift+A]{.key} |
| Repeat last command | [Shift+R]{.key} | Delete Face | [Shift+X]{.key} or [Shift+Delete]{.key} | Measure Distance | [Ctrl+=]{.key} |
| Undo | [Ctrl+Z]{.key} | Move | [G]{.key} | Dimension | [=]{.key} |
| Redo | [Ctrl+Shift+Z]{.key} | Rotate | [R]{.key} | Offset Face (Push Face) | select a face (auto-start) |
| Preferences | [Ctrl+,]{.key} | Scale | [S]{.key} | Set Material | [M]{.key} |
| New | [Ctrl+N]{.key} | Mirror | [Alt+X]{.key} | Remove Material | [Alt+M]{.key} |
| Open | [Ctrl+O]{.key} | Duplicate | [Shift+D]{.key} | Fork Material | [Shift+M]{.key} |
| Save | [Ctrl+S]{.key} | Alternative Duplicate | [Alt+D]{.key} | Copy with Placement | [Ctrl+Shift+C]{.key} |
| Save as | [Ctrl+Shift+S]{.key} | Place | [Ctrl+D]{.key} | Paste with Placement | [Ctrl+Shift+V]{.key} |
| Import / Append | [Ctrl+Shift+O]{.key} | Outliner search | [Ctrl+F]{.key} | Select previous source objects | [Ctrl+T]{.key} |
| Export | [Ctrl+Shift+E]{.key} | Quit | [Ctrl+Q]{.key} | Select next source objects | [Ctrl+Shift+T]{.key} |
:::

## Keys inside a running command {-}

These keys depend on which command is active. The command cards list each command's own keys.

| Key | What it does | Where it applies |
|------------|----------------------------------|----------------------------------|
| [Tab]{.key} | type an exact value | drawing tools; from 26.1 also the gizmo commands Move, Rotate, Scale, Push Face, Extrude and Thicken [26.1]{.ver}. For Push Face the command page instead says [Tab]{.key} switches the Grow mode |
| [S]{.key} | Lock distances (equal distance on both sides) | Offset Planar Curve, Offset Region, Offset Face Loop, Offset Edge, Thicken, Thicken Face, Extrude [26.1]{.ver} |
| [X]{.key}, [Y]{.key}, [Z]{.key} | lock movement to an axis | while drawing and moving |
| hold [Ctrl]{.key} | temporarily turn object snapping on | while drawing or moving (snapping is on automatically while drawing curves) |
| [Shift+X]{.key} | temporarily turn off the snap you are locked onto; press again to step through snap types | while snapping |
| right-click, or OK in the command dialog | confirm | most commands; see *Confirming, cancelling and repeating commands* in chapter 3 |

## Changed defaults {-}

Earlier defaults, for users coming from older versions or old tutorials. The current default is the one on the card above. To get the old All-modes key back, search the Command Palette for *Selection mode: set all*, right-click it and assign [Tab]{.key}.

| Action | Up to 25.3 | From 26.1 | Source |
|------------------|--------------|--------------|------------------------|
| All selection modes | [Tab]{.key} | [5]{.key} | Migration Guide v26.1 |
| Lock distances (offset, thicken and extrude commands) | [Tab]{.key} | [S]{.key} | Migration Guide v26.1 |
| Exact distance in gizmo commands | – | [Tab]{.key} | 2026.1 release notes |


## Tool index {-}

Every command card in this guide, from A to Z, with its default key, the chapter it is in and its page (click a name to go to the card). A dash (–) means there is no default key: run the tool from the Command Palette ([F]{.key}). The index is generated from the cards by `tools/index.py`.

<!-- index:start -->

| Tool | Default key | Chapter |
|------------------------------------------|--------------------|--------------------------|
| [Alternative Duplicate]{.cmd} | [Alt+D]{.key} | Common commands (curves and bodies) |
| [Boolean]{.cmd} | [Q]{.key} | Solid and surface commands |
| [Bridge Curve]{.cmd} | – | Curve (sketch) commands |
| [Bridge Surface]{.cmd} | – | Solid and surface commands |
| [Bridge Vertex · Bridge Edge]{.cmd} | – | Curve (sketch) commands |
| [Center Circle · Two-Point Circle · Three-Point Circle]{.cmd} | – | Sketching and primitive tools |
| [Center-Point Arc · Three-Point Arc]{.cmd} | – | Sketching and primitive tools |
| [Complete Edge]{.cmd} | – | Common commands (curves and bodies) |
| [Constrained Surface]{.cmd} | – | Solid and surface commands |
| [Control Point Curve]{.cmd} | – | Sketching and primitive tools |
| [Convert Vertex]{.cmd} | – | Curve (sketch) commands |
| [Copy / Paste with Placement]{.cmd} | [Ctrl+Shift+C]{.key} (copy), [Ctrl+Shift+V]{.key} (paste) | Common commands (curves and bodies) |
| [Corner · Center · Three-Point Box]{.cmd} | – | Sketching and primitive tools |
| [Corner · Center · Three-Point Rectangle]{.cmd} | – | Sketching and primitive tools |
| [Create Instance]{.cmd} | – | Common commands (curves and bodies) |
| [Curve Array]{.cmd} | – | Common commands (curves and bodies) |
| [Cut]{.cmd} | [C]{.key} | Solid and surface commands |
| [Cut Curve]{.cmd} | – | Curve (sketch) commands |
| [Cylinder]{.cmd} | – | Sketching and primitive tools |
| [Deform (Solid and Sheet)]{.cmd} | – | Solid and surface commands |
| [Deform Curve]{.cmd} | – | Curve (sketch) commands |
| [Delete Face]{.cmd} | [Shift+X]{.key} or [Shift+Delete]{.key} or [Shift+Backspace]{.key} | Face and edge commands |
| [Delete Redundant Topology]{.cmd} | – | Curve (sketch) commands |
| [Dimension]{.cmd} | [=]{.key} | Sketching and primitive tools |
| [Draft Face]{.cmd} | – | Face and edge commands |
| [Duplicate]{.cmd} | [Shift+D]{.key} | Common commands (curves and bodies) |
| [Ellipse]{.cmd} | – | Sketching and primitive tools |
| [Export]{.cmd} | [Ctrl+Shift+E]{.key} | Import, export and sharing |
| [Export Hidden Line]{.cmd} | – | Import, export and sharing |
| [Export OBJ]{.cmd} | – | Import, export and sharing |
| [Export SVG]{.cmd} | – | Import, export and sharing |
| [Extend Curve]{.cmd} | – | Curve (sketch) commands |
| [Extend Sheet]{.cmd} | – | Solid and surface commands |
| [Extrude]{.cmd} | [E]{.key} | Solid and surface commands |
| [Fillet Curve · Fillet Vertex]{.cmd} | [B]{.key} | Curve (sketch) commands |
| [Fillet Shell]{.cmd} | [B]{.key} | Solid and surface commands |
| [Find Boundary Edges]{.cmd} | – | Solid and surface commands |
| [Fork Material]{.cmd} | [Shift+M]{.key} | Common commands (curves and bodies) |
| [Hollow]{.cmd} | – | Solid and surface commands |
| [Import / Append]{.cmd} | [Ctrl+Shift+O]{.key} | Import, export and sharing |
| [Imprint Body-Body]{.cmd} | [Shift+I]{.key} | Face and edge commands |
| [Imprint Curve-Body]{.cmd} | [Shift+I]{.key} | Face and edge commands |
| [Insert Knot (Insert CV at Point)]{.cmd} | – | Curve (sketch) commands |
| [Isoparam]{.cmd} | [Ctrl+R]{.key} | Face and edge commands |
| [Join Curves]{.cmd} | [J]{.key} | Curve (sketch) commands |
| [Join Sheets]{.cmd} | [J]{.key} | Solid and surface commands |
| [Line]{.cmd} | [Shift+A]{.key} | Sketching and primitive tools |
| [Loft]{.cmd} | [L]{.key} | Solid and surface commands |
| [Match Face]{.cmd} | – | Face and edge commands |
| [Measure Continuity]{.cmd} | – | Sketching and primitive tools |
| [Measure Distance]{.cmd} | [Ctrl+=]{.key} | Sketching and primitive tools |
| [Measure Radius]{.cmd} | – | Sketching and primitive tools |
| [Mirror]{.cmd} | [Alt+X]{.key} | Common commands (curves and bodies) |
| [Move]{.cmd} | [G]{.key} | Common commands (curves and bodies) |
| [Offset Curve (unified)]{.cmd} | [O]{.key} | Curve (sketch) commands |
| [Offset Edge]{.cmd} | [O]{.key} | Face and edge commands |
| [Offset Face (Push Face)]{.cmd} | – | Face and edge commands |
| [Offset Face Loop]{.cmd} | [O]{.key} | Face and edge commands |
| [Offset Planar Curve]{.cmd} | [O]{.key} | Curve (sketch) commands |
| [Offset Region]{.cmd} | [O]{.key} | Curve (sketch) commands |
| [Offset Vertex]{.cmd} | [O]{.key} | Curve (sketch) commands |
| [Patch]{.cmd} | – | Solid and surface commands |
| [Pipe]{.cmd} | [P]{.key} | Solid and surface commands |
| [Place]{.cmd} | [Ctrl+D]{.key} | Common commands (curves and bodies) |
| [PolySplines]{.cmd} | – | Solid and surface commands |
| [Project (unified)]{.cmd} | [I]{.key} | Curve (sketch) commands |
| [Project Align]{.cmd} | – | Solid and surface commands |
| [Project Body-Body · Project Curve-Curve]{.cmd} | [I]{.key} | Curve (sketch) commands |
| [Project Curve-Body]{.cmd} | [I]{.key} | Curve (sketch) commands |
| [Project Outline · Create Outline · Duplicate Curve and Project]{.cmd} | [Alt+D]{.key} (via Alternative Duplicate) | Curve (sketch) commands |
| [Publish to Plasticity Share]{.cmd} | – | Import, export and sharing |
| [Radial Array]{.cmd} | – | Common commands (curves and bodies) |
| [Raise Curve Degree]{.cmd} | [Shift+S]{.key} | Curve (sketch) commands |
| [Raise Surface Degree]{.cmd} | [Shift+S]{.key} | Solid and surface commands |
| [Realize Instances]{.cmd} | – | Common commands (curves and bodies) |
| [Rebuild Curve]{.cmd} | – | Curve (sketch) commands |
| [Rebuild Face]{.cmd} | – | Solid and surface commands |
| [Rectangular Array]{.cmd} | – | Common commands (curves and bodies) |
| [Regular Polygon]{.cmd} | – | Sketching and primitive tools |
| [Remove Fillets from Shell]{.cmd} | – | Solid and surface commands |
| [Remove Material]{.cmd} | [Alt+M]{.key} | Common commands (curves and bodies) |
| [Remove Nominal Surface]{.cmd} | – | Solid and surface commands |
| [Reverse Curve]{.cmd} | – | Curve (sketch) commands |
| [Reverse Sheet]{.cmd} | – | Solid and surface commands |
| [Revolve]{.cmd} | – | Solid and surface commands |
| [Rotate]{.cmd} | [R]{.key} | Common commands (curves and bodies) |
| [Scale]{.cmd} | [S]{.key} | Common commands (curves and bodies) |
| [Section Analysis]{.cmd} | – | Sketching and primitive tools |
| [Set Material]{.cmd} | [M]{.key} | Common commands (curves and bodies) |
| [Slide Curve CV]{.cmd} | [Shift+G]{.key} | Curve (sketch) commands |
| [Slide Surface CV]{.cmd} | [Shift+G]{.key} | Solid and surface commands |
| [Slot]{.cmd} | [O]{.key}, then [O]{.key} | Curve (sketch) commands |
| [Sphere]{.cmd} | – | Sketching and primitive tools |
| [Spiral]{.cmd} | – | Sketching and primitive tools |
| [Spline Curve]{.cmd} | – | Sketching and primitive tools |
| [Split Segment (Split Curve at Point)]{.cmd} | – | Curve (sketch) commands |
| [Square]{.cmd} | – | Solid and surface commands |
| [Subdivide]{.cmd} | – | Common commands (curves and bodies) |
| [Surface Align (Edge Align)]{.cmd} | – | Solid and surface commands |
| [Sweep]{.cmd} | [Shift+P]{.key} | Solid and surface commands |
| [Tangent Arc]{.cmd} | – | Sketching and primitive tools |
| [Tangent Circle]{.cmd} | – | Sketching and primitive tools |
| [Text]{.cmd} | – | Sketching and primitive tools |
| [Thicken · Thicken Face]{.cmd} | – | Solid and surface commands |
| [Toggle Curvature (Measure Curvature)]{.cmd} | – | Sketching and primitive tools |
| [Toggle Points]{.cmd} | – | Curve (sketch) commands |
| [Trim]{.cmd} | [T]{.key} | Curve (sketch) commands |
| [Unjoin Curves]{.cmd} | [Alt+J]{.key} | Curve (sketch) commands |
| [Unjoin Faces · Unjoin Shells]{.cmd} | [Alt+J]{.key} | Solid and surface commands |
| [Untrim]{.cmd} | [Alt+T]{.key} | Solid and surface commands |
| [Unwrap Face]{.cmd} | – | Face and edge commands |
| [Vertex Align (Edge Align)]{.cmd} | – | Curve (sketch) commands |
| [XNurbs]{.cmd} | – | Solid and surface commands |

<!-- index:end -->

## Sources and accuracy notes {-}

### What the labels mean {-}

| Label | Meaning |
|------------------|------------------------------------------------------------|
| [26.1]{.ver} | The release notes of that version announce the feature, option or default as new or changed. |
| [1.3]{.doc} | Documented as available in that version (the earliest release notes or manual page that mention it). It may be older: the introduction date is not known. |
| Verified in *build* | Behaviour tested in that application build. **No statement in this edition has been application-tested**, so this label does not appear. |
| no label | Statements in a card's normal sections are officially documented (see the sources below). |
| **Tips**, [ADVICE]{.advice} | General modelling advice, not a claim about how Plasticity behaves. |
| **Older versions**, grey boxes | Historical behaviour and defaults, kept for users of older versions and old tutorials. |

A tag next to an option or key dates that option or key only. Option names follow the 26.2 manual.

### Sources {-}

This guide is unofficial. It paraphrases the official Plasticity manual and release notes; it was not reviewed by Plastic Software. All sources were accessed on 21/10/2026.

- Official manual: [doc.plasticity.xyz](https://doc.plasticity.xyz). Each command card follows the command's own page, e.g. [Boolean](https://doc.plasticity.xyz/solid/boolean), [Offset Region](https://doc.plasticity.xyz/sketch/offset-region), [Measure Continuity](https://doc.plasticity.xyz/tool/measure-continuity).
- Manual source repository: [KioArts/plasticity-document-revisions](https://github.com/KioArts/plasticity-document-revisions), revision [570fdda](https://github.com/KioArts/plasticity-document-revisions/tree/570fdda9d764df8381118316cb98c6d3d6689890) (20/10/2026). Its Markdown sources were used for exact wording.
- Shortcut lists: [Plasticity Essentials](https://doc.plasticity.xyz/all-commands/plasticity-essentials), [Sketching and Primitive Tools](https://doc.plasticity.xyz/all-commands/tool-commands), [Common Commands](https://doc.plasticity.xyz/all-commands/common-commands), [Sketch Commands](https://doc.plasticity.xyz/all-commands/sketch-commands), [Solid Commands](https://doc.plasticity.xyz/all-commands/solid-commands).
- Release notes: [1.3](https://doc.plasticity.xyz/release-notes/whats-new-1-3), [1.4](https://doc.plasticity.xyz/release-notes/whats-new-1-4), [2024.1](https://doc.plasticity.xyz/release-notes/whats-new-2024.1), [2024.2](https://doc.plasticity.xyz/release-notes/whats-new-2024.2), [2025.1](https://doc.plasticity.xyz/release-notes/whats-new-2025.1), [2025.2](https://doc.plasticity.xyz/release-notes/whats-new-2025.2), [2025.3](https://doc.plasticity.xyz/release-notes/whats-new-2025.3), [2026.1](https://doc.plasticity.xyz/release-notes/whats-new-2026.1), [2026.2](https://doc.plasticity.xyz/release-notes/whats-new-2026.2), and the [Migration Guide v26.1](https://doc.plasticity.xyz/migration-26.1).
- Licences and Studio-only features: [Licence types and features](https://doc.plasticity.xyz/getting-started/license-types-and-features); installation and system requirements: [Download and install](https://doc.plasticity.xyz/getting-started/download-and-install).
- General CAD and geometry theory (B-rep, NURBS, continuity, flattening, file formats) is standard textbook material and is marked as general where it goes beyond Plasticity's documentation.

### Accuracy {-}

The reference version is Plasticity 26.2.0. This edition was corrected on 21/10/2026 against the sources above and has not been tested in the application. Corrections are welcome.
