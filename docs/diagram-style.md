# Diagram style

Hand-written SVG with real text (DejaVu Sans, embedded by Typst). Keep every new diagram consistent with these rules.

- **Canvas:** `width="510.2362"` (full text width, 180 mm), `viewBox="0 0 510.2362 H"`, `font-family="DejaVu Sans"`. Usual height 125.
- **Panels:** 2, 3 or 4 side by side, `fill #f6f6fa`, `stroke #d9dbe3` 0.8, `rx 5`, 8.5–9 units apart.
  - 3 panels: x = 0.5 / 173.6 / 346.7, width 163.
  - 2 panels: x = 0.5 / 259.7, width 250.5.
  - 4 panels: x = 0.5 / 130.1 / 259.7 / 389.3, width 120.5.
- **Captions:** bold 8 pt `#1d1f24` at y = H − 19, plus a grey 6.5 pt `#6b7080` line at y = H − 8, centred on the panel.
- **Colours:**

| Use | Colour |
|---|---|
| Existing geometry | `#1d1f24` (stroke 1.2, white fill) |
| Changed or resulting geometry | `#5b3df5` (stroke 1.6–1.8), light fill `#efecff` |
| Selected faces or edges | `#e8a400` (stroke 3), yellow handle dot `#f5c518` |
| New edges | `#0f8a5f` (stroke 1.8–3) |
| Original position, guides | `#6b7080` (stroke 0.8, dashed `3 2`) |
| Small labels | 6 pt, same colour as the thing they name |

- **Arrows:** a `<marker>` with `markerUnits="userSpaceOnUse"`, filled triangle 6 × 6.
- **Content:** draw only what the official docs state. If behaviour is ambiguous, describe it in the text instead of drawing a guess.
