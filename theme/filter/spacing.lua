-- spacing.lua – exact vertical spacing between top-level blocks.
--
-- ReportLab ADDS the space after one block to the space before the next; Typst uses the
-- larger of the two. This pass groups the top-level blocks into units (paragraph, list,
-- heading, box, command card), then inserts the ReportLab gap between every two units as a
-- weak #v() (an explicit #v() replaces Typst's own block spacing; weak = dropped at page top).
-- A spacer written in Markdown (```{=typst} #v(4pt, weak: true) ```) is ADDED to that gap,
-- as in ReportLab.
--   gap = TAIL[previous unit] + HEAD[next unit] + spacers
--
-- Spacing scheme (points). TAIL = space a unit leaves after itself, HEAD = space a unit wants before
-- itself. Edit these two tables (together with the matching values in theme/style.typ and
-- theme/components.typ) to make the layout tighter or airier.
--   text: paragraph spaceAfter 6   list: last item spaceAfter 3   h1: spaceBefore 14, spaceAfter 10
--   h2: spaceBefore 16, spaceAfter 6   box (table, figure, note): 6 after   card: 10 after
local util = require('util')
local raw, rawtext = util.raw, util.rawtext

local M = {}

local TAIL = { text = 8.29, list = 5.29, h1 = 9.92, h2 = 6.74, box = 6, card = 10 }
local HEAD = { text = 2.11, list = 2.11, h1 = 14, h2 = 16, box = 0, card = 0 }
-- Typst adds about 8 pt of its own between two consecutive headings (measured on compiled PDFs),
-- so that transition is reduced by the same amount.
local PAIR_CORRECTION = { ['h1>h2'] = -8 }

function M.exact_spacing(doc)
  local units, cur, depth, pending = {}, nil, 0, 0
  local function push(kind, blocks)
    table.insert(units, { kind = kind, blocks = blocks, space = pending }); pending = 0
  end
  for _, b in ipairs(doc.blocks) do
    local t = rawtext(b)
    if depth > 0 then
      table.insert(cur.blocks, b)
      if t and t:match('%[%s*$') then depth = depth + 1
      elseif t and t:match('^%s*%]%s*$') then depth = depth - 1 end
      if depth == 0 then cur = nil end
    elseif t and t:match('^#v%(') then
      pending = pending + (tonumber(t:match('^#v%(%s*([%d%.]+)pt')) or 0)
    elseif t and t:match('%[%s*$') then
      local kind = t:match('^#command%(') and 'card' or 'box'
      push(kind, { b }); cur = units[#units]; depth = 1
    elseif t and t:match('^#flowblock[%[%(]') then push('box', { b })
    elseif t and t:match('^#pagebreak') then push('break', { b })
    elseif t and t:match('^#heading%(level: 1') then push('h1', { b })
    elseif t and t:match('^#heading%(level: 2') then push('h2', { b })
    elseif b.t == 'Header' then push(b.level == 1 and 'h1' or 'h2', { b })
    elseif b.t == 'Para' or b.t == 'Plain' then push('text', { b })
    elseif b.t == 'BulletList' or b.t == 'OrderedList' then push('list', { b })
    else push('other', { b }) end
  end
  -- a paragraph directly before a card stays on the page where the card starts
  for i, u in ipairs(units) do
    local nxt = units[i + 1]
    if u.kind == 'text' and nxt and nxt.kind == 'card' then
      table.insert(u.blocks, 1, raw('#block(sticky: true)['))
      table.insert(u.blocks, raw(']'))
    end
  end
  local out = {}
  for i, u in ipairs(units) do
    local prev = units[i - 1]
    if prev and TAIL[prev.kind] and HEAD[u.kind] then
      local gap = TAIL[prev.kind] + HEAD[u.kind] + u.space + (PAIR_CORRECTION[prev.kind .. '>' .. u.kind] or 0)
      table.insert(out, raw(string.format('#v(%.2fpt, weak: true)', gap)))
    elseif u.space > 0 then
      table.insert(out, raw(string.format('#v(%.2fpt, weak: true)', u.space)))
    end
    for _, b in ipairs(u.blocks) do table.insert(out, b) end
  end
  doc.blocks = out
  return doc
end

return M
