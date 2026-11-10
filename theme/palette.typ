// palette.typ – the manual's colours. Imported by components.typ and style.typ.

#let ink = rgb("#1d1f24")
#let accent = rgb("#5b3df5")
#let accent-light = rgb("#e8e3ff")
#let grey = rgb("#6b7080")
#let rule-col = rgb("#d9dbe3")
#let zebra = rgb("#f6f6fa")
#let newgreen = rgb("#0f8a5f")
#let newgreen-light = rgb("#e5f6ef")
#let studio-col = rgb("#b4561b")
#let unresolved-col = rgb("#b45309")
#let unresolved-light = rgb("#fdf1e3")
#let history-light = rgb("#efeff3")

// Version-tag colours: Plasticity version -> colour, from theme/versions.json.
// Add a line there when a new Plasticity release is documented (tools/check.py reads the same file).
#let ver-colours = {
  let d = (:)
  for (v, c) in json("/theme/versions.json") { d.insert(v, rgb(c)) }
  d
}
