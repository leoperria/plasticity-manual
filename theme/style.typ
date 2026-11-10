// style.typ – page layout, text, headings, tables, cover and contents.
// Used by template.typ as `#show: manual.with(...)`. Requires Typst 0.12 or newer.
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
// more space before headings. Gaps between top-level blocks are set in theme/filter/spacing.lua (TAIL/HEAD).

#import "palette.typ": *

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

#let baseline-text(..args) = text(top-edge: "baseline", bottom-edge: "baseline", ..args)

// ------------------------------------------------------------------ the whole book
#let manual(title: [], subtitle: [], cover-lines: (), cover-notes: (), build-time: [],
            header-left: [], header-right: [], footer: [], body) = {

  // ---------------------------------------------------------------- base text  (body: 8.8 / 13.2, spaceAfter 6)
  set text(font: ("DejaVu Sans",), size: 9.4pt, fill: ink, lang: "en", region: "gb",
           hyphenate: false, top-edge: "ascender", bottom-edge: "descender")
  set par(leading: 4.6pt, spacing: 10.8pt, justify: false)
  set block(spacing: 10.4pt)
  // Body bullets (bullet at 1 pt, text at 10 pt, spaceAfter 3)
  set list(marker: [•], indent: 0.28pt, body-indent: 4.53pt, spacing: 7.4pt)
  set enum(indent: 1pt, body-indent: 3.81pt, spacing: 7.4pt)

  // ---------------------------------------------------------------- headings
  set heading(numbering: (..nums) => {
    let n = nums.pos()
    if n.len() == 1 { str(n.first()) + "." } else { n.map(str).join(".") }
  })
  // h1: DejaVu Bold 17 / 21, spaceBefore 14, spaceAfter 10
  show heading.where(level: 1): set text(size: 17pt, weight: "bold", fill: ink)
  show heading.where(level: 1): set block(above: 22.29pt, below: 12.03pt, inset: (top: 4.08pt))
  // h2: DejaVu Bold 11.5 / 15, violet, spaceBefore 16, spaceAfter 6
  show heading.where(level: 2): set text(size: 11.5pt, weight: "bold", fill: accent)
  show heading.where(level: 2): set block(above: 24.29pt, below: 8.85pt, inset: (top: 2.76pt))

  // ---------------------------------------------------------------- tables  (cell 7.6 / 10.4, padding 4 / 4)
  set table(
    stroke: (x, y) => (bottom: 0.4pt + rule-col),
    inset: (left: 4pt, right: 4pt, top: 5.82pt, bottom: 4.98pt),
    fill: (x, y) => if y == 0 { ink } else if calc.even(y) { zebra } else { none },
    align: left + top,
  )
  show table.cell: set text(size: 8pt)
  show table.cell: set par(leading: 2.8pt, spacing: 2.8pt)
  show table.cell.where(x: 0): set text(weight: "bold")
  show table.cell.where(y: 0): set text(fill: white, weight: "bold")

  // ---------------------------------------------------------------- page, header and footer
  // RL: text frame 15 mm from the bottom, 16 mm from the top; header text baseline 10 mm from the
  // top with a 0.6 pt rule at 12 mm; footer rule 12 mm and text baseline 8 mm from the bottom.
  let page-deco = {
    place(top + left, dx: 15mm, dy: 12mm, line(length: 180mm, stroke: 0.6pt + rule-col))
    place(top + left, dx: 15mm, dy: 10mm,
      baseline-text(size: 7.5pt, weight: "bold", fill: accent)[#header-left])
    place(top + right, dx: -15mm, dy: 10mm,
      baseline-text(size: 7.5pt, fill: grey)[#header-right])
    place(top + left, dx: 15mm, dy: 285mm, line(length: 180mm, stroke: 0.6pt + rule-col))
    place(top + left, dx: 15mm, dy: 289mm,
      baseline-text(size: 7.5pt, fill: grey)[#footer])
    place(top + right, dx: -15mm, dy: 289mm,
      baseline-text(size: 7.5pt, fill: grey, context counter(page).display()))
  }
  set page(paper: "a4", margin: (left: 15mm, right: 15mm, top: 16mm, bottom: 15mm),
           header: none, footer: none, background: page-deco)

  // ---------------------------------------------------------------- cover
  // RL: title 40 pt bold, baseline 62 mm from the top; subtitle 16 pt at 75 mm; feature lines
  // 9.5 pt from 92 mm, 5.5 mm apart; notes 8 pt at 267 mm and 272 mm; all 20 mm from the left.
  page(margin: 0pt, fill: ink, background: image("/theme/cover.svg", width: 100%, height: 100%))[
    #place(top + left, dx: 20mm, dy: 62mm,
      baseline-text(size: 40pt, weight: "bold", fill: white)[#title])
    #place(top + left, dx: 20mm, dy: 75mm,
      baseline-text(size: 16pt, fill: rgb("#c9c3ff"))[#subtitle])
    #for (i, l) in cover-lines.enumerate() {
      place(top + left, dx: 20mm, dy: 92mm + i * 5.5mm, baseline-text(size: 9.5pt, fill: rgb("#b8bcc8"), l))
    }
    #for (i, l) in cover-notes.enumerate() {
      place(top + left, dx: 20mm, dy: 267mm + i * 5mm, baseline-text(size: 8pt, fill: rgb("#8a8fa0"), l))
    }
    #place(top + left, dx: 20mm, dy: 267mm + cover-notes.len() * 5mm,
      baseline-text(size: 8pt, fill: rgb("#8a8fa0"))[Built #build-time])
  ]

  // ---------------------------------------------------------------- contents
  block(above: 0pt, below: 7.92pt, inset: (top: 4.08pt), text(size: 17pt, weight: "bold")[Contents])
  toc()
  pagebreak()

  // ---------------------------------------------------------------- chapters
  body
}
