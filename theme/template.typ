// template.typ – pandoc template. Pandoc fills in the variables from book/metadata.yaml and puts the
// chapters (already turned into Typst calls by theme/filter/) at the end. (Do not write dollar signs
// in comments here: pandoc reads them as template variables.) Everything else lives in:
//   palette.typ     colours (version-tag colours come from versions.json)
//   components.typ  tags, command cards, note boxes, tables and figures used inside the chapters
//   style.typ       page, text, headings, cover and contents
// Requires Typst 0.12 or newer.

#set document(title: [$pdf-title$], author: "$author$")

#import "/theme/components.typ": *
#import "/theme/style.typ": manual

// Long cards may split across pages when book/metadata.yaml sets card-breakable: true.
#let command = command.with(card-breakable: $if(card-breakable)$true$else$false$endif$)

#show: manual.with(
  title: [$title$],
  subtitle: [$subtitle$],
  cover-lines: ($for(cover-lines)$[$cover-lines$], $endfor$),
  cover-notes: ($for(cover-notes)$[$cover-notes$], $endfor$),
  build-time: [$build-time$],
  header-left: [$header-left$],
  header-right: [$header-right$],
  footer: [$footer$],
)

$body$
