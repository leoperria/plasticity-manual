-- main.lua – pandoc Lua filter: turns the manual's Markdown conventions into Typst calls
-- (the functions they call are defined in theme/components.typ).
--
--   spans.lua    [Ctrl+R]{.key}, version and claim tags, [Name]{.cmd} links, image paths
--   cards.lua    ::: {.command ...} cards, their section labels and page-break rules
--   blocks.lua   note boxes, shortcut-card tables, centred blocks, headings, pipe tables, figures
--   spacing.lua  exact vertical spacing between top-level blocks
--   util.lua     shared helpers
--
-- The conventions themselves are documented for writers in docs/writing-guide.md.

-- load the modules from this file's folder
package.path = pandoc.path.directory(PANDOC_SCRIPT_FILE) .. '/?.lua;' .. package.path

local spans = require('spans')
local blocks = require('blocks')
local spacing = require('spacing')

-- Passes run in this order: inline elements (spans, images), tables, figures,
-- then divs and headings, then spacing over the whole document.
return {
  { Span = spans.span, Image = spans.image },
  { Table = blocks.table },
  { Para = blocks.para },
  { Div = blocks.div, Header = blocks.header },
  { Pandoc = spacing.exact_spacing },
}
