# Selection and editing

| Command | Key | What it does |
|------------------|-------------|----------------------------|
| Select All | [A]{.key} | Selects everything selectable in the active mode(s); locked items are skipped [25.2]{.ver}. |
| Invert Selection | [Alt+A]{.key} | Deselects what is selected and selects the rest. |
| Deselect All | [Esc]{.key} | Outside a command. Inside some commands [Esc]{.key} ends the command instead (see below). |
| Selection modes | [1]{.key}, [2]{.key}, [3]{.key}, [4]{.key} | Control Point, Edge, Face, Body. |
| All selection modes | [5]{.key} [26.1]{.ver} | Enables every mode at once. |
| Toggle a mode | [Shift+1]{.key} to [Shift+4]{.key} | Adds or removes one mode, so several are active. |
| Convert selection | [Ctrl+1]{.key} to [Ctrl+5]{.key} | To CVs, edges, faces, solids, or the whole group. |
| Select all Curves | – | Selects every curve visible in the viewport. |
| Select All Constraints [26.2]{.ver} | – | Selects every constraint in the scene ([STUDIO]{.studio}). |
| Group | [Ctrl+G]{.key} | Creates an Outliner group from the selection. |
| Ungroup | [Alt+G]{.key} | Removes the selected objects from their group. |
| Hide, hide unselected | [H]{.key}, [Shift+H]{.key} | Hides the selection, or everything else. |
| Unhide all, invert hidden | [Alt+H]{.key}, [Ctrl+H]{.key} | Shows everything, or swaps hidden and visible. |
| Lock Selected | – | Makes the selection unselectable (unlock from the Outliner). |
| Delete | [Shift+Backspace]{.key}, [Shift+X]{.key} or [Shift+Delete]{.key} | Removes the selection; deleting a group removes its children. |
| Dissolve | [X]{.key} or [Backspace]{.key} | Removes the selection; dissolving a group keeps its items. |
| Delete Face | [Shift+X]{.key}, [Shift+Delete]{.key} or [Shift+Backspace]{.key} | With faces selected: removes them (chapter 8). |

```{=typst}
#v(4pt, weak: true)
```

::: {.note .history title="Older versions"}
Up to 25.3 the key for all selection modes was [Tab]{.key}; from 26.1 it is [5]{.key} (Migration Guide v26.1). The Selection Mode page of the docs still shows [Tab]{.key}; the migration guide and the All Commands list show [5]{.key}. To get the old key back, search *Selection mode: set all* in the Command Palette, right-click it and assign [Tab]{.key}.
:::

Most work in Plasticity starts with a selection: it decides which command starts (chapter 1, smart commands) and what the command works on. First choose the selection mode for the kind of item you want (chapter 1), then pick the items as described below.

```{=typst}
#v(16pt, weak: true)
```

### Clicking and box selection {-}

1. Choose the selection mode: [1]{.key} to [4]{.key}, or [5]{.key} for all modes.
2. Click an item to select it.
3. To select several items at once, drag a box:
   - **from right to left** (green box): everything the box touches is selected;
   - **from left to right** (purple box): only items completely inside the box are selected.
4. Press [Esc]{.key} to deselect everything.

![](book/figures/c03-box-select.svg)

```{=typst}
#v(16pt, weak: true)
```

### Viewport, command and Outliner selection {-}

Plasticity selects in three places, and the docs give different modifiers for each.

| Where | Add | Remove | Replace |
|----------------|-----------------------|-----------------------|-------------------|
| Viewport, no command running | | | [Esc]{.key}, then select again |
| Loft, Sweep (guides) | [Shift]{.key}+click | [Ctrl]{.key}+click | – |
| Draft Face (faces to draft) | [Shift]{.key}+click | [Ctrl]{.key}+click | – |
| Fillet Shell (edges) | [Ctrl]{.key}+click | [Ctrl]{.key}+click again | – |
| Outliner | hold [Shift]{.key} while you click (Rename section of the Outliner page) | | |

```{=typst}
#v(4pt, weak: true)
```

- **Viewport selection** (no command running) is what the Selecting Objects page describes: click, box selection, the [Alt]{.key}+click and [Ctrl+Alt]{.key}+click selections and the overlap menu below, [A]{.key}, [Alt+A]{.key} and [Esc]{.key}. The page does not say what a plain click does to an existing selection, or which modifier adds or removes an item.
- **Command selection** is the selection a running command uses for its inputs, such as the guide curves of a Loft or the extra edges of a fillet. It follows the command's own keys, which differ between commands (table above), so check the *Keys* list in each card.
- **Outliner selection:** click a name to select the object. Right-click a section label (Solids, Sheets, Curves …) › **Select all** selects everything in that section; right-click a group › **Select all** selects everything in the group; [Alt]{.key}+click a folder selects all objects in that section. With the cursor over the Outliner, [/]{.key} scrolls to the object selected in the viewport, and [.]{.key} collapses every group except the one holding the selected object – the same keys do something else in the viewport (see *Keys that depend on context*, below).

```{=typst}
#v(16pt, weak: true)
```

### Selecting loops, rings and related items {-}

Hold [Alt]{.key}, or [Ctrl+Alt]{.key}, while you click to select a whole set of related items in one go:

| Click | On | Selects |
|-----------------|--------------------|---------------------------------|
| [Alt]{.key}+click | CV hull | The row (loop) of CVs; a preview shows the direction before you click [25.2]{.ver}. |
| [Alt]{.key}+click | Edge | The edge loop. |
| [Ctrl+Alt]{.key}+click | Edge | The edge ring. |
| [Alt]{.key}+click | Curve | All curves on the same plane. |
| [Alt]{.key}+click | Region | All regions on the same plane. |
| [Alt]{.key}+click | Face | All related faces. |
| [Ctrl+Alt]{.key}+click | Face | All parallel faces. |
| [Ctrl+Alt]{.key}+click | Cylindrical face | All parallel cylindrical faces. |
| [Alt]{.key}+click | Solid, sheet or empty | All solids, sheets or empties in the same group. |

```{=typst}
#v(4pt, weak: true)
```

**Select Adjacent** ([Ctrl+Shift+=]{.key}) adds the items next to the current selection.

```{=typst}
#v(16pt, weak: true)
```

### Picking one of several overlapping items {-}

1. Hold [Ctrl+Shift]{.key} and left-click, or left-click while turning the wheel, where the items overlap [25.2]{.ver}.
2. A menu lists what lies under the cursor: CV, CV hull, edge, curve, face, or sheet and solid.
3. Click the one you want.

```{=typst}
#v(16pt, weak: true)
```

### Converting, inverting and reusing a selection {-}

- **Convert** the selection to related items with [Ctrl]{.key} and a number. [Ctrl+1]{.key} selects the points of the selected curves; [Ctrl+2]{.key} the edges of the selected solids, sheets, faces and regions; [Ctrl+3]{.key} the faces of the selected solids and sheets; [Ctrl+4]{.key} the solids or sheets of the selected faces and edges; [Ctrl+5]{.key} all objects in the group of the selected objects. For example, select a solid and press [Ctrl+2]{.key} to select all its edges.
- **Invert** with [Alt+A]{.key}: what was selected is deselected and the rest is selected. It also works on edges and faces [25.2]{.ver}.
- **Select by type** with the palette commands *Select All Curves*, *Select All Sheets*, *Select All Solids* and *Select All Measurements*. They select every item of that type in the visible viewport.
- **Reuse the inputs of the last operation:** [Ctrl+T]{.key} (*Select Previous Entity Collection*) selects the source objects used in the last operation; press it again to step back through earlier operations. [Ctrl+Shift+T]{.key} (*Select Next Entity Collection*) steps forward again.

```{=typst}
#v(16pt, weak: true)
```

### Confirming, cancelling and repeating commands {-}

Most command cards in this guide do not repeat these steps; they mention confirmation only when a command works differently.

- **Start** a command by selecting something it auto-starts on (chapter 1), with its key, or from the Command Palette ([F]{.key}: type the name, pick it with the arrow keys or the wheel, then press [Enter]{.key}). [Shift+R]{.key} (*Edit: repeat last command*) runs the last command again.
- **Confirm** most commands with **OK** in the command dialog or a right-click. Exceptions documented in the command pages:
  - Line, Control Point Curve and Spline Curve: click the points, then right-click after the last point.
  - Circle, arc and rectangle tools: one left-click or one press of [Enter]{.key} confirms [24.1]{.ver}. Primitives sized with the cursor (box, sphere, cylinder …) are confirmed with a click.
  - Dimension: press [Tab]{.key}, type the value, then press [Enter]{.key}.
- **Type an exact value:** [Tab]{.key} opens numeric input in the drawing tools, and from 26.1 in the gizmo commands such as Move and Rotate [26.1]{.ver}.
- **Undo** a finished command with [Ctrl+Z]{.key} and redo it with [Ctrl+Shift+Z]{.key}. Inside Line, Control Point Curve and Spline Curve, [Ctrl+Z]{.key} cancels only the last click, so you can correct a point without starting again.
- **Repeated placement:** Place ([Ctrl+D]{.key}) keeps running after each copy. Click to confirm a copy, click the next destination point for another one, and press [Esc]{.key} to exit. Paste with Placement works the same way, but each copy is confirmed with a right-click.
- **Cancel:** the docs do not describe how to cancel a running command without applying it. If a command has already been applied, [Ctrl+Z]{.key} takes it back.

**What [Esc]{.key} does.** With no command running, [Esc]{.key} is *Deselect All*. In Place, Copy with Placement and Paste with Placement it ends the command. The docs do not say what it does in other commands, or what happens to a copy that is not yet confirmed when you press it.

```{=typst}
#v(4pt, weak: true)
```

**Keys that depend on context.** Some keys do different things inside and outside a command, or over the Outliner:

| Key | No command running | Inside a command, or elsewhere |
|-------------|---------------------------|------------------------------------------|
| [Esc]{.key} | Deselect All | ends Place, Copy with Placement and Paste with Placement |
| [X]{.key} | Dissolve | while drawing: locks to the X axis; in Place and Paste with Placement: sets the duplication axis |
| [Shift+X]{.key} | Delete (Delete Face with faces selected) | while snapping, turns off the snap you are locked onto |
| [Ctrl]{.key} | – | held while drawing or moving: turns snapping on; in Fillet Shell: adds or removes edges |
| [/]{.key} | Viewport: focus | cursor over the Outliner: scrolls to the selected object |
| [.]{.key} | Isolate | Outliner: collapses all groups except the selected object's |

```{=typst}
#v(16pt, weak: true)
```

### Hiding, locking and isolating {-}

- **Hide** the selection with [H]{.key}, or everything else with [Shift+H]{.key}. [Alt+H]{.key} shows everything again; [Ctrl+H]{.key} swaps hidden and visible objects. To hide all the curves on one plane, select their regions and press [H]{.key}.
- **Lock** objects you must not touch: run *Lock Selected* from the Command Palette, or click the lock icon in the Outliner. Locked objects cannot be selected or changed, and Select All skips them. *Unlock All* releases every lock [25.2]{.ver}.
- **Disable** heavy objects with the disable icon in the Outliner: they leave the viewport and are no longer processed, which reduces the load. Hidden objects, by contrast, are still processed.

To work on a few objects without the rest of the scene in the way, isolate them:

1. Select the objects and press [.]{.key} (*Isolate*). Only they are shown, and an indicator at the top centre of the screen shows that you are in Isolate mode.
2. To narrow down further, select some of the isolated objects and press [.]{.key} again. The number by the indicator shows the level, for example *2 Isolated*.
3. To go back one level, press [.]{.key} with nothing selected, or click the **Isolated** button.
4. To show everything at once, press [Alt+.]{.key} (*Unisolate*). It does not step back through the levels.

While you are isolated, right-click an object in the Outliner › **Add to Isolation** to bring it into the current level [26.2]{.ver}. [/]{.key} (*Viewport: focus*) zooms to the selection without hiding anything.

```{=typst}
#v(16pt, weak: true)
```

### Delete or Dissolve {-}

Both remove what is selected. The documented difference is what happens to a selected group:

- **Delete** ([Shift+Backspace]{.key}, [Shift+X]{.key} or [Shift+Delete]{.key}, General Functions page) removes the group **and every object in it**.
- **Dissolve** ([X]{.key} or [Backspace]{.key}) removes only the group: the objects inside are kept.

1. Select the group, for example by clicking it in the Outliner.
2. Press [Shift+Backspace]{.key} to delete it with its contents, or [Backspace]{.key} to dissolve it and keep the contents. In the Outliner, right-click the group › **Delete recursively** or **Dissolve** does the same.
3. If the result is not what you wanted, press [Ctrl+Z]{.key}.

![](book/figures/c03-delete-dissolve.svg)

**Faces.** Select one or more faces in Face mode ([3]{.key}) and press [Shift+X]{.key}, [Shift+Delete]{.key} or [Shift+Backspace]{.key}: *Delete Face* removes them (chapter 8). For redundant faces, the Command Palette has *Dissolve Face* (“delete selected redundant faces”) and *Delete Redundant Topology* (for solids and sheets); neither has a default key.

**Edges.** In 24.2 the Rebuild Edge command was removed and replaced by deleting edges with [X]{.key}, [Shift+X]{.key}, [Delete]{.key} or [Shift+Delete]{.key}; the release notes say this lets you join more fractured edges [24.2]{.ver}. Select the edges in Edge mode ([2]{.key}) and press one of those keys. *Delete Edge* and *Delete Control Point* are also palette commands without a default key.

**Regions.** Deleting a region also deletes the curves around it [25.1]{.ver}.
