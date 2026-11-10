-- cards.lua – command cards.
--
--   ::: {.command name=... key=... version=... studio="true"} ... :::
--       -> #command(...)[ ... ]   section lines ("Step by step:" etc.) become #cmdlabel(...)
--   version="x.y" = introduced in; documented="x.y" instead when the introduction is unknown;
--   optional tested="x.y.z".
--
-- Page breaks inside cards (cards may split across pages):
--   * a card lighter than CARD_UNBREAKABLE never splits;
--   * its opening (intro and the first item of the first section, with any diagram) stays
--     together, so a card title is never stranded at the foot of a page;
--   * its ending (the last section, with short closing sections such as Older versions,
--     Unresolved and Related, plus enough of what precedes them to reach TAIL_MIN) stays
--     together, so a card never ends with a detached line or two at the top of a page.
-- Weights are measured with util.weight (characters of text; a diagram counts as util.WEIGHT_IMAGE).
local util = require('util')
local spans = require('spans')
local q, raw, weight = util.q, util.raw, util.weight

local M = {}

local CARD_UNBREAKABLE, TAIL_MIN, HEAD_MAX = 1800, 700, 2400

-- section line in the Markdown -> label printed in the card
local LABELS = {
  ['Before you start:'] = 'BEFORE YOU START',
  ['Step by step:'] = 'STEP BY STEP',
  ['Options explained:'] = 'OPTIONS EXPLAINED',
  ['Keys:'] = 'KEYS',
  ['Common problems:'] = 'COMMON PROBLEMS',
  ['Tips:'] = 'TIPS',
  ['Older versions:'] = 'OLDER VERSIONS',
  ['Unresolved:'] = 'UNRESOLVED – NEEDS AN APPLICATION TEST',
  ['Related:'] = 'RELATED',
}
-- Bullet lists under these labels use the compact tips style.
local TIPS_STYLE = { ['TIPS AND NOTES'] = true, ['TIPS'] = true, ['COMMON PROBLEMS'] = true,
                     ['OLDER VERSIONS'] = true, ['UNRESOLVED – NEEDS AN APPLICATION TEST'] = true }
-- Short closing sections that are kept together with the section before them.
local TRAILING = { ['RELATED'] = true, ['OLDER VERSIONS'] = true, ['UNRESOLVED – NEEDS AN APPLICATION TEST'] = true }

local function label_of(b)
  return (b.t == 'Para') and LABELS[pandoc.utils.stringify(b)] or nil
end

-- Emit card body blocks; labels become #cmdlabel, lists under tips-style labels get #tipslist.
local function emit(blocks, out, state)
  for _, b in ipairs(blocks) do
    local label = label_of(b)
    if label then
      local style = ''
      if label:match('^UNRESOLVED') then style = ', style: "unresolved"'
      elseif label == 'OLDER VERSIONS' then style = ', style: "history"' end
      table.insert(out, raw('#cmdlabel(' .. q(label) .. style .. ')'))
      state.tips = TIPS_STYLE[label] or false
    elseif state.tips and b.t == 'BulletList' then
      table.insert(out, raw('#tipslist['))
      table.insert(out, b)
      table.insert(out, raw(']'))
    else
      table.insert(out, b)
    end
  end
end

local function is_list(b) return b.t == 'BulletList' or b.t == 'OrderedList' end

-- split a list into two lists after item i (ordered lists keep their numbering)
local function split_list(b, i)
  local first, second = {}, {}
  for j, it in ipairs(b.content) do table.insert(j <= i and first or second, it) end
  if b.t == 'BulletList' then return pandoc.BulletList(first), pandoc.BulletList(second) end
  local la = b.listAttributes
  return pandoc.OrderedList(first, la),
         pandoc.OrderedList(second, pandoc.ListAttributes(la.start + i, la.style, la.delimiter))
end

local function item_weight(item)
  return math.max(#pandoc.utils.stringify(pandoc.Blocks(item)), 110)
end

local function slice(t, i, j)
  local r = {}
  for k = i, j do table.insert(r, t[k]) end
  return r
end

-- the ending of a card: see the header comment
local function split_tail(blocks)
  local labels = {}
  for i, b in ipairs(blocks) do if label_of(b) then table.insert(labels, i) end end
  if #labels == 0 then return blocks, {} end
  local k = #labels
  while k > 1 and TRAILING[label_of(blocks[labels[k]])] and TRAILING[label_of(blocks[labels[k - 1]])] do
    k = k - 1
  end
  local n = #blocks
  local cut = labels[k]           -- tail = blocks[cut..n]
  local w = 0
  for i = cut, n do w = w + weight(blocks[i]) end
  while cut > 2 and w < TAIL_MIN do
    local b = blocks[cut - 1]
    if is_list(b) and #b.content > 1 then
      local m, taken, lw = #b.content, 0, w
      while taken < m - 1 and lw < TAIL_MIN do
        taken = taken + 1
        lw = lw + item_weight(b.content[m - taken + 1])
      end
      if lw >= TAIL_MIN then      -- split this list: its last `taken` items join the tail
        local keep, move = split_list(b, m - taken)
        local head = slice(blocks, 1, cut - 2); table.insert(head, keep)
        local tail = { move }
        for i = cut, n do table.insert(tail, blocks[i]) end
        return head, tail
      end
    end
    w = w + weight(b)
    cut = cut - 1
  end
  while cut > 1 and label_of(blocks[cut - 1]) do cut = cut - 1 end  -- no label at the end of the head
  if cut <= 1 then return blocks, {} end
  return slice(blocks, 1, cut - 1), slice(blocks, cut, n)
end

-- the opening of a card: everything before the first label, the label and the first item after it
local function split_head(blocks)
  local first
  for i, b in ipairs(blocks) do if label_of(b) then first = i; break end end
  if not first or first + 1 > #blocks then return {}, blocks end
  local open, rest = {}, {}
  for j = 1, first do table.insert(open, blocks[j]) end
  local b = blocks[first + 1]
  if is_list(b) and #b.content > 1 then
    local a1, a2 = split_list(b, 1)
    table.insert(open, a1); table.insert(rest, a2)
  else
    table.insert(open, b)
  end
  for j = first + 2, #blocks do table.insert(rest, blocks[j]) end
  local w = 0
  for _, x in ipairs(open) do w = w + weight(x) end
  if w > HEAD_MAX or #rest == 0 then return {}, blocks end
  return open, rest
end

function M.command(el)
  local a = el.attributes
  local shortcut = 'none'
  if a.key and a.key ~= '' then shortcut = '[' .. spans.inline_typst(a.key) .. ']' end
  local status = 'version: ' .. q(a.version or '')
  if (a.version or '') == '' and a.documented then status = 'documented: ' .. q(a.documented) end
  if a.tested then status = status .. ', tested-in: ' .. q(a.tested) end
  local short = util.total_weight(el.content) < CARD_UNBREAKABLE
  local open = '#command(id: ' .. q(pandoc.utils.stringify(pandoc.read(a.name or '?', 'markdown').blocks)) ..
               ', name: [' .. spans.inline_typst(a.name or '?') .. '], shortcut: ' .. shortcut ..
               ', ' .. status ..
               ', studio: ' .. ((a.studio == 'true') and 'true' or 'false') ..
               (short and ', breakable: false' or '') .. ')['
  local out = { raw(open) }
  local state = { tips = false }
  if short then
    emit(el.content, out, state)
  else
    local blocks = {}
    for _, b in ipairs(el.content) do table.insert(blocks, b) end
    local opening, rest = split_head(blocks)
    local head, tail = split_tail(rest)
    if #opening > 0 then
      table.insert(out, raw('#keephead['))
      emit(opening, out, state)
      table.insert(out, raw(']'))
    end
    emit(head, out, state)
    if #tail > 0 then
      -- the tips state of the section the tail starts in carries over
      table.insert(out, raw('#keeptail['))
      emit(tail, out, state)
      table.insert(out, raw(']'))
    end
  end
  table.insert(out, raw(']'))
  return out
end

return M
