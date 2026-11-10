# Navigation, interface and files

## Viewport navigation

| Action | Input | Notes |
|------------------|-----------------|-------------------------|
| Orbit | Middle mouse drag | A dot marks the orbit focus point [25.1]{.ver}. |
| Pan | Right mouse drag |  |
| Zoom in steps | Wheel |  |
| Zoom continuously | [Ctrl]{.key} + middle drag |  |
| Orbit snapping to axes and ortho views | [Alt]{.key} + middle drag | Snaps to world axes and diagonals. |
| Re-centre on cursor | [Alt]{.key} + middle click |  |
| Front, Right, Top | [Num 1]{.key}, [Num 3]{.key}, [Num 7]{.key} |  |
| Back, Left, Bottom | [Ctrl+Num 1]{.key}, [Ctrl+Num 3]{.key}, [Ctrl+Num 7]{.key} |  |
| Perspective ↔ orthographic | [Num 5]{.key} |  |
| Focus on selection | [/]{.key} | Zooms to the selection. |
| Isolate selection | [.]{.key} | Temporarily hides everything else. |
| Navigate to selection | [Space]{.key} | Also sets the CPlane (see 1.5). |
| Home View [26.2]{.ver} | Right-click view cube / *Viewport: Home View* | Standard isometric view; no default key. |
| Arcball rotation mode [26.1]{.ver} | Preferences | Free rotation on all three axes. |

Mouse behaviour can be changed in Preferences. Also available: the interface **Zoom Factor** [25.2]{.ver}; up to six interface languages [25.3]{.ver}; SpaceMouse buttons bound through keymap.json [25.1]{.ver}; a **Lock Horizon** SpaceMouse option [26.1]{.ver}; **Regular Edge Color** and **Instance Edge Color** in Preferences › Appearance [26.2]{.ver}.

::: {.note .history title="Older versions"}
Up to 25.1 the default perspective FOV was 50; from 25.2 it is 35. Wheel zoom was made faster in 25.3. In 26.1 the SpaceMouse up/down directions were reversed and its default speed recalibrated.
:::

```{=typst}
#v(16pt, weak: true)
```

### Moving around the scene {-}

1. **Orbit:** hold the middle mouse button and drag. A dot shows the point the view turns around. Hold [Alt]{.key} as well to snap to the world axes and the diagonals between them.
2. **Pan:** hold the right mouse button and drag.
3. **Zoom:** turn the wheel to zoom in steps, or hold [Ctrl]{.key} and drag up or down with the middle button for smooth zooming.
4. **Look at your work:** select it and press [/]{.key} (*Viewport: focus*) to fill the viewport with it. [Space]{.key} (*Viewport: navigate to selection*) puts it in the centre of the screen instead, and also sets the construction plane. [Alt]{.key} + middle click re-centres the view on the cursor.
5. **Square up:** [Num 1]{.key}, [Num 3]{.key} and [Num 7]{.key} show the front, right and top views; with [Ctrl]{.key}, the back, left and bottom views. [Num 5]{.key} switches between perspective and orthographic.
6. **Start again:** right-click the view cube › **Home View**, or run *Viewport: Home View*, to return to the standard isometric view [26.2]{.ver}.

By default the view zooms towards the cursor and rotates around the cursor position (*Zoom to cursor* and *Rotate around cursor*, below).

```{=typst}
#v(16pt, weak: true)
```

### Using the view cube {-}

The view cube in the corner of the viewport shows which way you are looking and turns the camera with one click.

- **Face:** click it to look straight at that face. From 26.2 the camera turns to the closest matching orientation [26.2]{.ver}. Click the same face again (a double-click, in the current docs) to see the opposite side.
- **Edge or corner:** click it for a view from that edge or corner (the docs call it an isometric perspective).
- **Axis arrows:** **X** gives the Right view, **Y** the Back view and **Z** the Top view.
- **Right-click** opens a menu with the view commands and their keys, **Home View** [26.2]{.ver}, **Camera Roll** (rolls the view 90° around the current viewing direction) and **Camera Rotation** (turns the camera 90°).

The cube's size is set by **Viewport Gizmo Size** in Preferences › Appearance.

![](book/figures/c02-view-cube.svg)

```{=typst}
#v(16pt, weak: true)
```

### Navigation settings {-}

Open Preferences ([Ctrl+,]{.key}, or P-Menu › Preferences) and go to **Navigation**:

- **Rotation Mode:** **Tumble** (default) turns the view around a fixed vertical axis, so the view never rolls or turns upside down. **Arcball** [26.1]{.ver} rotates freely in all three axes, as if you were turning a ball around the scene.
- **Zoom to cursor** and **Rotate around cursor** (both on by default) zoom towards, and rotate around, the cursor position.
- **Zoom vertical** (on) zooms by dragging up and down with [Ctrl]{.key} + middle button. **Invert zoom direction** and **Invert wheel direction** are off by default.
- **Navigation Presets** make the controls match other 3D programs. The docs do not list which presets exist.

The **Camera Settings** panel in the right sidebar sets the **FOV** (field of view; 35 by default in perspective, lower is narrower) and **Squish** (compresses the view to control optical distortion; 1.0 by default). For keyboard-only navigation, the Command Palette has *Orbit: dolly in / out*, *Orbit: pan up / down / left / right* and *Orbit: rotate up / down / left / right*; the docs list no default keys for them, so assign your own. SpaceMouse speeds (pan, rotate, zoom) are under Preferences › SpaceMouse; the docs confirm the SpaceMouse Compact, Pro and Enterprise on Windows and macOS, while Linux is unconfirmed.

## Interface and general

| Function | Key | Function | Key |
|---------------|---------------|---------------|---------------|
| Command Palette | [F]{.key} | Repeat last command | [Shift+R]{.key} |
| Suggested Commands [25.1]{.ver} | [Shift+F]{.key} | Undo | [Ctrl+Z]{.key} |
| Toggle left sidebar | [Ctrl+B]{.key} | Redo | [Ctrl+Shift+Z]{.key} |
| Toggle right sidebar | [Ctrl+Shift+B]{.key} | Copy | [Ctrl+C]{.key} |
| Preferences | [Ctrl+,]{.key} | Paste | [Ctrl+V]{.key} |
| X-ray | [Alt+Z]{.key} | Overlays | [Alt+Shift+Z]{.key} |

```{=typst}
#v(16pt, weak: true)
```

### Finding your way around the screen {-}

- **Top left:** the **P** (P-Menu) for files and Preferences, and the selection-mode buttons.
- **Left sidebar** ([Ctrl+B]{.key}, or the icon to the right of the P-Menu): Outliner, Materials and Assets (see chapter 1).
- **Right sidebar** ([Ctrl+Shift+B]{.key}, or the icon above View Mode): panels that open as menus – View Mode, Shader Mode, Camera Settings, Grid and Units, Snap, Planes and Curvature. The **Selection** menu at the bottom right shows information about the selection, such as an object's mass.
- **Bottom:** the command bar with the most common commands and Suggested Commands.
- **View Mode** (the button at the top right) holds Section Analysis, the orthographic camera ([Num 5]{.key}), overlays ([Alt+Shift+Z]{.key}, which also switches the grid display), X-ray ([Alt+Z]{.key}, which makes hidden lines visible and selectable) and Render Mode (which shows the material settings).

```{=typst}
#v(16pt, weak: true)
```

### Preferences {-}

Preferences ([Ctrl+,]{.key}) has sections for Navigation, Performance (GPU rendering and CPU facet quality, ambient occlusion), Language, Appearance (UI and viewport colours, sizes of points, edges and the view cube, Zoom Factor), Backup, Network (Blender Bridge, Web Publishing, update check), SpaceMouse and Commands (the auto-start switches). Language changes apply at once; for other settings the Preferences page says to restart Plasticity.

## Files, import and export

| Command | Key | What it does |
|-------------|------------|-----------------------------------|
| New | [Ctrl+N]{.key} | Clears the scene for a new document. |
| New Window | – | Opens a second Plasticity window. |
| Open | [Ctrl+O]{.key} | Opens a .plasticity document (large files show a progress indicator [25.1]{.ver}). |
| Import / Append | [Ctrl+Shift+O]{.key} | Brings another file into the current scene; appended .plasticity files keep groups, names and materials, and also bring in meshes, images and instances [26.2]{.ver}. |
| Save | [Ctrl+S]{.key} | Saves the document; thumbnails can be saved with files [25.1]{.ver}. Optional autosave interval in Preferences [24.2]{.ver}. |
| Save as | [Ctrl+Shift+S]{.key} | Saves the document under a new name. |
| Quick save version | – | Saves a copy with the same name plus a timestamp. |
| File tab menu [26.2]{.ver} | Right-click the file tab | Reveal the file location, browse backups, or revert to the last saved state. |
| Save as startup scene | – | Uses the current document as the start-up scene (loading the previous session at start-up can be disabled [25.1]{.ver}). |
| Export | [Ctrl+Shift+E]{.key} | Exports files (chapter 9). Export OBJ exports the selection, or everything visible when nothing is selected [25.3]{.doc}, and offers mesh settings such as Max Width, Edge/Face Angle Tolerance and Inflect. |
| Quit | [Ctrl+Q]{.key} |  |

```{=typst}
#v(3pt, weak: true)
```

**File formats:** see chapter 9 for import/export formats and options by version.

```{=typst}
#v(16pt, weak: true)
```

### Saving your work {-}

1. Press [Ctrl+S]{.key} to save the document, or [Ctrl+Shift+S]{.key} (Save as) to save it under a new name. From 26.1 Plasticity asks whether to save unsaved changes [26.1]{.ver}.
2. Before a risky change, use **Quick save version** in the P-Menu. It keeps a copy with a timestamp added to the file name, so you can go back to it later.
3. Turn on **autosave** in Preferences and set how often it saves, in minutes [24.2]{.ver}.
4. Right-click the file tab to reveal the file in your file browser, browse its backups, or revert to the last saved state when the file has unsaved changes [26.2]{.ver}.

A dot marks unsaved changes, and opening a file warns you about them [24.1]{.ver}.

```{=typst}
#v(16pt, weak: true)
```

### Recovering a backup {-}

If unsaved work seems to be missing, the Preferences page (**Backup**) says to look in these folders:

- Windows: `C:\Users\<UserName>\AppData\Local\Temp\plasticity` or `C:\Users\<UserName>\AppData\Local\Temp\plasticity-backup`
- macOS: `/var/folders/<random>/T/plasticity` or `/var/folders/<random>/T/plasticity-backup`
- Linux: `/tmp/plasticity` or `/tmp/plasticity-backup`

1. **Locate** the backup: right-click the file tab › browse the backup files [26.2]{.ver}, or open one of the folders above in your file browser.
2. **Copy** the backup file to a normal folder before you do anything else. These are temporary folders of the operating system, which it may clear [ADVICE]{.advice}.
3. **Open** the copy with **Open** ([Ctrl+O]{.key}). The docs do not say what the backup files are called, which format they have, or whether Open reads them directly.
4. **Check** it: look through the Outliner and the viewport for the objects you expected before you rely on it [ADVICE]{.advice}.
5. **Save** it under a new name with **Save as** ([Ctrl+Shift+S]{.key}), so that the original file and the backup stay as they were.

The docs do not say where autosave writes its files, or whether autosaved files are the same as the backups above.

```{=typst}
#v(16pt, weak: true)
```

### Opening, importing and appending {-}

- **Open** ([Ctrl+O]{.key}) opens a .plasticity document. **Recent Files** in the P-Menu lists the files you worked on; hover over the list to see thumbnails of them.
- **Import/Append** ([Ctrl+Shift+O]{.key}) adds a file to the scene you have open. You can also drag a file into the viewport, or drag a file from Recent Files into the viewport [25.1]{.ver}.
- An appended .plasticity file keeps its groups, names and materials [24.2]{.ver}, and also its meshes, images and instances [26.2]{.ver}.
- An asset pack (.plasticitypack) opened with Import/Append appears in the Outliner, with its objects marked as assets.
- Images (PNG, JPG) come in as reference images and meshes (OBJ, STL, FBX, 3MF) as reference meshes; both are picked in Body mode and can be snapped to. An SVG with more than about 700 curves on one plane does not show its regions.

```{=typst}
#v(16pt, weak: true)
```

### New windows and the start-up scene {-}

- **New Window** opens a second Plasticity window with a randomly changed accent colour, so you can tell the windows apart. You can copy and paste between windows.
- **Save as startup scene** saves the current document as the scene that opens automatically the next time Plasticity starts. A preference stops Plasticity from loading the previous session at start-up [25.1]{.ver}.
- The P-Menu also holds Preferences, licence management (**Manage licenses**), the current version, **Publish to Plasticity Share** and **Manage my shared documents** (chapter 9).
