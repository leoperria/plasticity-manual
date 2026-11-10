// components.typ – the building blocks the Lua filter (theme/filter/) emits into the chapters:
// inline tags, links to command cards, command cards, note boxes, tables and figures.
// Sizes and spacing reproduce the original ReportLab edition; see the conversion notes in style.typ.

#import "palette.typ": *

// ------------------------------------------------------------------ inline markup
// Keyboard shortcut: DejaVu Sans Mono Bold, violet, same size as the surrounding text
#let key(k) = text(font: ("DejaVu Sans Mono",), weight: "bold", fill: accent, k)
// Version and evidence labels (DejaVu Sans Bold 6.5 pt):
//   ver     "Introduced in 25.2"  – the release notes confirm the feature was added in that release
//   docver  "Documented in 25.2"  – documented as available in that release; introduction date unknown
//   tested  "Verified in 26.2.0"  – behaviour tested in that application build
// Versions without a colour show "?" in red.
#let ver-col(v) = ver-colours.at(v, default: red)
#let ver-txt(v) = if v in ver-colours { v } else { v + "?" }
#let ver(v) = text(size: 6.5pt, weight: "bold", fill: ver-col(v), "Introduced in " + ver-txt(v))
#let docver(v) = text(size: 6.5pt, weight: "bold", fill: grey, "Documented in " + ver-txt(v))
#let tested(v) = text(size: 6.5pt, weight: "bold", fill: newgreen, "Verified in " + v)
// Claim-status tags
#let unresolvedtag() = box(fill: unresolved-light, inset: (x: 2pt, y: 1pt), outset: (y: 0.5pt), radius: 1.5pt,
  text(size: 6.5pt, weight: "bold", fill: unresolved-col, "UNRESOLVED"))
#let untestedtag() = text(size: 6.5pt, weight: "bold", fill: unresolved-col, "NOT APP-TESTED")
#let advicetag() = text(size: 6.5pt, weight: "bold", fill: grey, "GENERAL ADVICE")
// Studio-licence tag
#let studiotag() = text(size: 6.5pt, weight: "bold", fill: studio-col, "STUDIO")
// Link to a command card by its name, with the card's page number (used by the tool index)
#let cmd-label(id) = label("cmd:" + id)
#let cmdref(id) = context {
  let hits = query(cmd-label(id))
  if hits.len() == 0 { text(fill: red, id + " (?)") } else {
    let loc = hits.first().location()
    [#link(loc)[#id] #box(text(fill: grey)[·~p.~#counter(page).at(loc).first()])]
  }
}

// ------------------------------------------------------------------ tables and figures
// Container for every table and figure (filter output): 7.4 pt from the previous baseline
// (short tables are not split: the filter passes breakable: false)
#let flowblock(breakable: true, body) = block(width: 100%, breakable: breakable, above: 8.29pt, below: 8.11pt, body)

// ------------------------------------------------------------------ command card
// Box 0.6 pt + left rule 2.2 pt violet; padding 7 / 7 / 8; title DejaVu Bold 10.2 / 13;
// body 8.2 / 12 (spaceAfter 2); list items spaceAfter 1, bullet at 2 pt, text at 11 pt;
// labels DejaVu Bold 7.4 / 10 violet, spaceBefore 5; 10 pt after each card (filter).
// card-breakable: whether long cards may split across pages (set from book/metadata.yaml by template.typ);
// breakable: per-card override from the filter (short cards never split).
#let command(card-breakable: false, id: "", name: [], shortcut: none, version: "", documented: "", tested-in: "",
              studio: false, breakable: auto, body) = block(
  width: 100%,
  breakable: if breakable == auto { card-breakable } else { breakable },
  inset: (left: 7pt, right: 7pt, top: 9.45pt, bottom: 9.83pt),
  stroke: (left: 2.2pt + accent, top: 0.6pt + rule-col, right: 0.6pt + rule-col, bottom: 0.6pt + rule-col),
  above: 8.29pt,
  below: 10pt,
)[
  #set text(size: 8.8pt)
  #set par(leading: 4pt, spacing: 6pt)
  #set block(spacing: 5.8pt)
  #set list(marker: [•], indent: 1.28pt, body-indent: 4.88pt, spacing: 4.8pt)
  #set enum(indent: 2pt, body-indent: 1.18pt, spacing: 4.8pt)
  #show list: set block(above: 3.5pt)
  #show enum: set block(above: 3.5pt)
  #block(width: 100%, above: 0pt, below: 5.32pt, sticky: true, grid(
    columns: (118mm, 1fr),
    align: (left + horizon, right + horizon),
    [#text(size: 10.2pt, weight: "bold")[#name]#metadata(id)#cmd-label(id) #h(2pt)#if version != "" [#ver(version)] else if documented != "" [#docver(documented)] else [#text(size: 6.5pt, weight: "bold", fill: red)[version not given]]#if tested-in != "" [ · #tested(tested-in)]#if studio [ · #studiotag()]],
    if shortcut == none { text(fill: grey, "no default key") } else { shortcut },
  ))
  #body
]

// Card section label ("STEP BY STEP", ...)
// sticky: a card title or label never ends a page on its own (only matters for breakable cards)
#let cmdlabel(t, style: "normal") = block(above: 10.1pt, below: 3.5pt, sticky: true,
  text(size: 7.4pt, weight: "bold",
    fill: if style == "unresolved" { unresolved-col } else if style == "history" { grey } else { accent }, t))

// Opening and ending of a long card, each kept on one page (see theme/filter/cards.lua)
#let keephead(body) = block(width: 100%, breakable: false, above: 0pt, below: 0pt, body)
#let keeptail(body) = block(width: 100%, breakable: false, above: 0pt, below: 0pt, body)

// Tips use a › marker (RL bulletText "›")
#let tipslist(body) = {
  set list(marker: [›], body-indent: 6.44pt)
  body
}

// ------------------------------------------------------------------ note box
// Fill, 2.5 pt left rule, padding 8 / 8 / 6, body style 8.8 / 13.2, title bold coloured
// Styles: violet (default), green, history (grey: older behaviour, compatibility notes),
// unresolved (amber: documentation conflicts and behaviour that still needs an application test)
#let notebox(title: none, style: "violet", breakable: false, body) = {
  let (c, bg) = (
    violet: (accent, accent-light), green: (newgreen, newgreen-light),
    history: (grey, history-light), unresolved: (unresolved-col, unresolved-light),
  ).at(style)
  block(width: 100%, breakable: breakable, fill: bg, stroke: (left: 2.5pt + c),
        inset: (left: 8pt, right: 8pt, top: 10.11pt, bottom: 8.29pt), above: 8.29pt, below: 6pt)[
    #if title != none { block(above: 0pt, below: 10.4pt, sticky: true, text(weight: "bold", fill: c, title)) }
    #body
  ]
}

// ------------------------------------------------------------------ shortcut card
// Padding 3 / 3, rows centred vertically, first column regular,
// 0.8 pt rules after the 2nd and 4th columns.
#let cardtable(body) = {
  set table(
    inset: (left: 3pt, right: 3pt, top: 4.82pt, bottom: 3.98pt),
    align: left + horizon,
    stroke: (x, y) => (
      bottom: 0.4pt + rule-col,
      right: if x == 1 or x == 3 { 0.8pt + rule-col } else { none },
    ),
  )
  show table.cell.where(x: 0): set text(weight: "regular")
  show table.cell.where(y: 0): set text(weight: "bold")
  body
}
