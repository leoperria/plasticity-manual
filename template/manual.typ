// manual.typ – Typst template for the Plasticity reference manual (used by pandoc).
// Pandoc fills the template variables from metadata.yaml and inserts the chapters at the end.
// Requires Typst 0.12 or newer.
//
// The measurements reproduce the original ReportLab edition. ReportLab measures line spacing
// baseline-to-baseline; Typst measures between text boxes. Typst reads DejaVu's box as
// 0.76 em above and 0.24 em below the baseline (1.0 em, verified against a compiled PDF).
// ReportLab puts the first baseline one font size below the top of a paragraph, so:
//   Typst leading  = RL leading − size
//   gap A → B      = A.leading − 1.24 × A.size + A.spaceAfter + B.spaceBefore + 0.24 × B.size
//   text at top of a box: extra 0.24 × size inset
// Values below are already converted. Since manual 3.1 the spacing is deliberately airier than the
// ReportLab edition: body 8.8 / 13.2 (spaceAfter 6), cards 8.2 / 12, cells 7.6 / 10.4 with 4 pt padding,
// more space before headings. Gaps between top-level blocks are set in filters/manual.lua (TAIL/HEAD).

#set document(title: [$pdf-title$], author: "$author$")

// ------------------------------------------------------------------ colours
#let ink = rgb("#1d1f24")
#let accent = rgb("#5b3df5")
#let accent-light = rgb("#e8e3ff")
#let grey = rgb("#6b7080")
#let rule-col = rgb("#d9dbe3")
#let zebra = rgb("#f6f6fa")
#let newgreen = rgb("#0f8a5f")
#let newgreen-light = rgb("#e5f6ef")
#let studio-col = rgb("#b4561b")

// Version-tag colours. Add a line when a new Plasticity release is documented
// (tools/check.py reads this list).
#let ver-colours = (
  "1.3": rgb("#6b7080"),
  "1.4": rgb("#6b7080"),
  "24.1": rgb("#6b7080"),
  "24.2": rgb("#6b7080"),
  "25.1": rgb("#0f8a5f"),
  "25.2": rgb("#1d6fd1"),
  "25.3": rgb("#8a3ffc"),
  "26.1": rgb("#2e4a7d"),
  "26.2": rgb("#006d77"),
)

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
#let unresolved-col = rgb("#b45309")
#let unresolved-light = rgb("#fdf1e3")
#let history-light = rgb("#efeff3")
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

// ------------------------------------------------------------------ base text  (body: 8.8 / 13.2, spaceAfter 6)
#set text(font: ("DejaVu Sans",), size: 9.4pt, fill: ink, lang: "en", region: "gb",
          hyphenate: false, top-edge: "ascender", bottom-edge: "descender")
#set par(leading: 4.6pt, spacing: 10.8pt, justify: false)
#set block(spacing: 10.4pt)
// Body bullets (bullet at 1 pt, text at 10 pt, spaceAfter 3)
#set list(marker: [•], indent: 0.28pt, body-indent: 4.53pt, spacing: 7.4pt)
#set enum(indent: 1pt, body-indent: 3.81pt, spacing: 7.4pt)

// ------------------------------------------------------------------ headings
#set heading(numbering: (..nums) => {
  let n = nums.pos()
  if n.len() == 1 { str(n.first()) + "." } else { n.map(str).join(".") }
})
// h1: DejaVu Bold 17 / 21, spaceBefore 14, spaceAfter 10
#show heading.where(level: 1): set text(size: 17pt, weight: "bold", fill: ink)
#show heading.where(level: 1): set block(above: 22.29pt, below: 12.03pt, inset: (top: 4.08pt))
// h2: DejaVu Bold 11.5 / 15, violet, spaceBefore 16, spaceAfter 6
#show heading.where(level: 2): set text(size: 11.5pt, weight: "bold", fill: accent)
#show heading.where(level: 2): set block(above: 24.29pt, below: 8.85pt, inset: (top: 2.76pt))

// ------------------------------------------------------------------ tables  (cell 7.6 / 10.4, padding 4 / 4)
#set table(
  stroke: (x, y) => (bottom: 0.4pt + rule-col),
  inset: (left: 4pt, right: 4pt, top: 5.82pt, bottom: 4.98pt),
  fill: (x, y) => if y == 0 { ink } else if calc.even(y) { zebra } else { none },
  align: left + top,
)
#show table.cell: set text(size: 8pt)
#show table.cell: set par(leading: 2.8pt, spacing: 2.8pt)
#show table.cell.where(x: 0): set text(weight: "bold")
#show table.cell.where(y: 0): set text(fill: white, weight: "bold")

// Container for every table and figure (filter output): 7.4 pt from the previous baseline
// (short tables are not split: the filter passes breakable: false)
#let flowblock(breakable: true, body) = block(width: 100%, breakable: breakable, above: 8.29pt, below: 8.11pt, body)

// ------------------------------------------------------------------ command card
// Box 0.6 pt + left rule 2.2 pt violet; padding 7 / 7 / 8; title DejaVu Bold 10.2 / 13;
// body 8.2 / 12 (spaceAfter 2); list items spaceAfter 1, bullet at 2 pt, text at 11 pt;
// labels DejaVu Bold 7.4 / 10 violet, spaceBefore 5; 10 pt after each card (filter).
// Long cards may split across pages when metadata sets card-breakable: true.
#let card-breakable = $if(card-breakable)$true$else$false$endif$
#let command(id: "", name: [], shortcut: none, version: "", documented: "", tested-in: "", studio: false,
              breakable: auto, body) = block(
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

// Card label ("HOW TO USE", ...)
// sticky: a card title or label never ends a page on its own (only matters for breakable cards)
#let cmdlabel(t, style: "normal") = block(above: 10.1pt, below: 3.5pt, sticky: true,
  text(size: 7.4pt, weight: "bold",
    fill: if style == "unresolved" { unresolved-col } else if style == "history" { grey } else { accent }, t))

// Opening and ending of a long card, each kept on one page (see "Page breaks inside cards" in filters/manual.lua)
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

// ------------------------------------------------------------------ table of contents
// RL TableOfContents: level 1 DejaVu Bold 9.6 / 13.5; level 2 DejaVu 8 / 10.4 grey,
// indented 14 pt, dotted leader " . "; 3 pt cell padding above and below each entry.
#let toc() = context {
  for hd in query(heading.where(outlined: true)) {
    if hd.level > 2 { continue }
    let loc = hd.location()
    let num = if hd.numbering != none { numbering(hd.numbering, ..counter(heading).at(loc)) + " " } else { "" }
    let pg = str(counter(page).at(loc).first())
    if hd.level == 1 {
      block(above: 0pt, below: 0pt, inset: (top: 5.3pt, bottom: 4.6pt))[
        #set text(size: 9.6pt, weight: "bold")
        #link(loc)[#num#hd.body] #h(1fr) #pg
      ]
    } else {
      block(above: 0pt, below: 0pt, inset: (left: 14pt, top: 4.92pt, bottom: 3.48pt))[
        #set text(size: 8pt, fill: grey)
        #link(loc)[#num#hd.body]#box(width: 1fr, repeat[#h(2.54pt);.#h(2.54pt)])#pg
      ]
    }
  }
}

// ------------------------------------------------------------------ page, header and footer
// RL: text frame 15 mm from the bottom, 16 mm from the top; header text baseline 10 mm from the
// top with a 0.6 pt rule at 12 mm; footer rule 12 mm and text baseline 8 mm from the bottom.
#let baseline-text(..args) = text(top-edge: "baseline", bottom-edge: "baseline", ..args)
#let page-deco = {
  place(top + left, dx: 15mm, dy: 12mm, line(length: 180mm, stroke: 0.6pt + rule-col))
  place(top + left, dx: 15mm, dy: 10mm,
    baseline-text(size: 7.5pt, weight: "bold", fill: accent)[$header-left$])
  place(top + right, dx: -15mm, dy: 10mm,
    baseline-text(size: 7.5pt, fill: grey)[$header-right$])
  place(top + left, dx: 15mm, dy: 285mm, line(length: 180mm, stroke: 0.6pt + rule-col))
  place(top + left, dx: 15mm, dy: 289mm,
    baseline-text(size: 7.5pt, fill: grey)[$footer$])
  place(top + right, dx: -15mm, dy: 289mm,
    baseline-text(size: 7.5pt, fill: grey, context counter(page).display()))
}
#set page(paper: "a4", margin: (left: 15mm, right: 15mm, top: 16mm, bottom: 15mm),
          header: none, footer: none, background: page-deco)

// ------------------------------------------------------------------ cover
// RL: title 40 pt bold, baseline 62 mm from the top; subtitle 16 pt at 75 mm; feature lines
// 9.5 pt from 92 mm, 5.5 mm apart; notes 8 pt at 267 mm and 272 mm; all 20 mm from the left.
#let cover-lines = ($for(cover-lines)$[$cover-lines$], $endfor$)
#let cover-notes = ($for(cover-notes)$[$cover-notes$], $endfor$)
#page(margin: 0pt, fill: ink, background: image("/template/cover.svg", width: 100%, height: 100%))[
  #place(top + left, dx: 20mm, dy: 62mm,
    baseline-text(size: 40pt, weight: "bold", fill: white)[$title$])
  #place(top + left, dx: 20mm, dy: 75mm,
    baseline-text(size: 16pt, fill: rgb("#c9c3ff"))[$subtitle$])
  #for (i, l) in cover-lines.enumerate() {
    place(top + left, dx: 20mm, dy: 92mm + i * 5.5mm, baseline-text(size: 9.5pt, fill: rgb("#b8bcc8"), l))
  }
  #for (i, l) in cover-notes.enumerate() {
    place(top + left, dx: 20mm, dy: 267mm + i * 5mm, baseline-text(size: 8pt, fill: rgb("#8a8fa0"), l))
  }
  #place(top + left, dx: 20mm, dy: 267mm + cover-notes.len() * 5mm,
    baseline-text(size: 8pt, fill: rgb("#8a8fa0"))[Built $build-time$])
]

// ------------------------------------------------------------------ contents
#block(above: 0pt, below: 7.92pt, inset: (top: 4.08pt), text(size: 17pt, weight: "bold")[Contents])
#toc()
#pagebreak()

// ------------------------------------------------------------------ chapters
$body$
