-- blocks.lua – fenced divs, headings, tables and figures.
--
--   ::: {.command ...}          -> see cards.lua
--   ::: {.note title="..."}     -> #notebox(...)[ ... ]   (.green, .history or .unresolved for other styles)
--   ::: card                    -> #cardtable[ ... ]      (shortcut card tables)
--   ::: center                  -> #align(center)[ ... ]
--   # Heading {.pagebreak}      -> page break before the heading
--   ## Heading {-}              -> unnumbered heading (still listed in the contents)
--   ![](book/figures/x.svg)     -> full-width figure when it is alone in a paragraph
--   pipe tables                 -> #table(...) with relative column widths taken from the
--                                  number of dashes in the separator line (same on every pandoc version)
local util = require('util')
local spans = require('spans')
local cards = require('cards')
local q, raw = util.q, util.raw

local M = {}

local NOTE_BREAKABLE = 1800   -- note boxes heavier than this may split across pages

local function wrap(open, el)
  local out = { raw(open) }
  for _, b in ipairs(el.content) do table.insert(out, b) end
  table.insert(out, raw(']'))
  return out
end

function M.div(el)
  if el.classes:includes('command') then
    return cards.command(el)
  elseif el.classes:includes('note') then
    local title = spans.inline_typst(el.attributes.title or '')
    local style = 'violet'
    for _, c in ipairs({ 'green', 'history', 'unresolved' }) do
      if el.classes:includes(c) then style = c end
    end
    -- long boxes may split across pages (they would otherwise leave a large gap)
    local brk = (util.total_weight(el.content) > NOTE_BREAKABLE) and ', breakable: true' or ''
    return wrap('#notebox(title: [' .. title .. '], style: ' .. q(style) .. brk .. ')[', el)
  elseif el.classes:includes('card') then
    return wrap('#cardtable[', el)
  elseif el.classes:includes('center') then
    return wrap('#align(center)[', el)
  end
end

local function blocks_typst(blocks)
  return (pandoc.write(pandoc.Pandoc(blocks), 'typst'):gsub('%s+$', ''))
end

function M.table(tbl)
  local widths, n = {}, #tbl.colspecs
  for i, cs in ipairs(tbl.colspecs) do
    local w = cs[2]
    if type(w) ~= 'number' or w <= 0 then w = 1 / n end
    widths[i] = string.format('%.3ffr', w)
  end
  local rows = 0
  for _, body in ipairs(tbl.bodies) do rows = rows + #body.body end
  -- short tables (8 rows or fewer) are not split across pages
  local lines = { (rows <= 8 and '#flowblock(breakable: false)[#table(' or '#flowblock[#table('),
                  '  columns: (' .. table.concat(widths, ', ') .. ',),' }
  local function row_cells(row)
    local cells = {}
    for _, c in ipairs(row.cells) do table.insert(cells, '[' .. blocks_typst(c.contents) .. ']') end
    return table.concat(cells, ', ')
  end
  local head = {}
  for _, r in ipairs(tbl.head.rows) do table.insert(head, row_cells(r)) end
  if #head > 0 then table.insert(lines, '  table.header(' .. table.concat(head, ', ') .. '),') end
  for _, body in ipairs(tbl.bodies) do
    for _, r in ipairs(body.head) do table.insert(lines, '  ' .. row_cells(r) .. ',') end
    for _, r in ipairs(body.body) do table.insert(lines, '  ' .. row_cells(r) .. ',') end
  end
  table.insert(lines, ')]')
  return raw(table.concat(lines, '\n'))
end

function M.header(el)
  local out = {}
  if el.classes:includes('pagebreak') then table.insert(out, raw('#pagebreak(weak: true)')) end
  if el.classes:includes('unnumbered') then
    table.insert(out, raw('#heading(level: ' .. el.level .. ', numbering: none)[' ..
                          spans.inline_typst(pandoc.utils.stringify(el.content)) .. ']'))
  else
    table.insert(out, el)
  end
  if #out == 1 and out[1] == el then return nil end
  return out
end

-- A paragraph that only holds an image becomes a full-width figure block.
function M.para(el)
  if #el.content == 1 and el.content[1].t == 'Image' then
    local img = el.content[1]
    local w = img.attributes.width
    local args = q(img.src) .. (w and (', width: ' .. w) or ', width: 100%')
    return raw('#flowblock[#image(' .. args .. ')]')
  end
end

return M
