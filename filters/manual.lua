-- manual.lua – turns the manual's Markdown conventions into Typst calls.
--
--   [Ctrl+R]{.key}            -> #key("Ctrl+R");
--   [25.2]{.ver}              -> #ver("25.2");      "Introduced in 25.2" (confirmed introduction)
--   [25.2]{.doc}              -> #docver("25.2");   "Documented in 25.2" (available, introduction unknown)
--   [26.2.0]{.tested}         -> #tested("26.2.0"); "Verified in 26.2.0" (tested in the application)
--   [UNRESOLVED]{.unresolved} -> #unresolvedtag();  documentation conflict / behaviour not established
--   [UNTESTED]{.untested}     -> #untestedtag();    documented but not tested in the application
--   [ADVICE]{.advice}         -> #advicetag();      general modelling advice, not a product claim
--   [Name]{.cmd}              -> #cmdref("Name");   link to the command card, with its page number
--   [STUDIO]{.studio}         -> #studiotag();
--   ::: {.command name=... key=... version=... studio="true"} ... :::
--                             -> #command(...)[ ... ]  (with "How to use:" etc. as labels)
--                                version="x.y" = introduced in; documented="x.y" instead when the
--                                introduction is unknown; optional tested="x.y.z"
--   ::: {.note title="..."}   -> #notebox(...)[ ... ]   (.green, .history or .unresolved for other styles)
--   ::: card                  -> #cardtable[ ... ]
--   ::: center                -> #align(center)[ ... ]
--   # Heading {.pagebreak}    -> page break before the heading
--   ## Heading {-}            -> unnumbered heading (still listed in the contents)
--   ![](figures/x.svg)        -> full-width figure when it is alone in a paragraph
--   ![](figures/x.svg)        -> image path made project-root relative (/figures/x.svg)
--   pipe tables               -> #table(...) with relative column widths taken from the
--                                number of dashes in the separator line (same on every pandoc version)

local function q(s)   -- Typst string literal
  return '"' .. s:gsub('\\', '\\\\'):gsub('"', '\\"') .. '"'
end

local function raw(s) return pandoc.RawBlock('typst', s) end

local function span(el)
  local text = pandoc.utils.stringify(el)
  if el.classes:includes('key') then
    return pandoc.RawInline('typst', '#key(' .. q(text) .. ');')
  elseif el.classes:includes('ver') then
    return pandoc.RawInline('typst', '#ver(' .. q(text) .. ');')
  elseif el.classes:includes('doc') then
    return pandoc.RawInline('typst', '#docver(' .. q(text) .. ');')
  elseif el.classes:includes('tested') then
    return pandoc.RawInline('typst', '#tested(' .. q(text) .. ');')
  elseif el.classes:includes('unresolved') then
    return pandoc.RawInline('typst', '#unresolvedtag();')
  elseif el.classes:includes('untested') then
    return pandoc.RawInline('typst', '#untestedtag();')
  elseif el.classes:includes('advice') then
    return pandoc.RawInline('typst', '#advicetag();')
  elseif el.classes:includes('cmd') then
    return pandoc.RawInline('typst', '#cmdref(' .. q(text) .. ');')
  elseif el.classes:includes('studio') then
    return pandoc.RawInline('typst', '#studiotag();')
  end
end

-- Parse a Markdown snippet stored in an attribute and return Typst markup.
local function inline_typst(s)
  if s == nil or s == '' then return '' end
  local doc = pandoc.read(s, 'markdown')
  doc = doc:walk({ Span = span })
  if #doc.blocks == 0 then return '' end
  local plain = pandoc.Pandoc({ pandoc.Plain(doc.blocks[1].content) })
  return (pandoc.write(plain, 'typst'):gsub('%s+$', ''))
end

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

-- ---------------------------------------------------------------------------
-- Page breaks inside cards (cards may split across pages).
-- Block "weight" approximates height in characters of card text (about 110 per line);
-- a diagram counts as WEIGHT_IMAGE.
--   * a card lighter than CARD_UNBREAKABLE never splits;
--   * its opening (intro and the first item of the first section, with any diagram) stays
--     together, so a card title is never stranded at the foot of a page;
--   * its ending (the last section, with short closing sections such as Older versions,
--     Unresolved and Related, plus enough of what precedes them to reach TAIL_MIN) stays
--     together, so a card never ends with a detached line or two at the top of a page.
local WEIGHT_IMAGE, CARD_UNBREAKABLE, TAIL_MIN, HEAD_MAX = 1100, 1800, 700, 2400

local TRAILING = { ['RELATED'] = true, ['OLDER VERSIONS'] = true, ['UNRESOLVED – NEEDS AN APPLICATION TEST'] = true }

local function weight(b)
  local w = 0
  pandoc.walk_block(pandoc.Div({ b }), { Image = function() w = w + WEIGHT_IMAGE end })
  local n = #pandoc.utils.stringify(b)
  return w + math.max(n, 110)  -- every block is at least a line
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

local function command(el)
  local a = el.attributes
  local shortcut = 'none'
  if a.key and a.key ~= '' then shortcut = '[' .. inline_typst(a.key) .. ']' end
  local status = 'version: ' .. q(a.version or '')
  if (a.version or '') == '' and a.documented then status = 'documented: ' .. q(a.documented) end
  if a.tested then status = status .. ', tested-in: ' .. q(a.tested) end
  local total = 0
  for _, b in ipairs(el.content) do total = total + weight(b) end
  local short = total < CARD_UNBREAKABLE
  local open = '#command(id: ' .. q(pandoc.utils.stringify(pandoc.read(a.name or '?', 'markdown').blocks)) ..
               ', name: [' .. inline_typst(a.name or '?') .. '], shortcut: ' .. shortcut ..
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

local function wrap(open, el)
  local out = { raw(open) }
  for _, b in ipairs(el.content) do table.insert(out, b) end
  table.insert(out, raw(']'))
  return out
end

local function div(el)
  if el.classes:includes('command') then
    return command(el)
  elseif el.classes:includes('note') then
    local title = inline_typst(el.attributes.title or '')
    local style = 'violet'
    for _, c in ipairs({ 'green', 'history', 'unresolved' }) do
      if el.classes:includes(c) then style = c end
    end
    -- long boxes may split across pages (they would otherwise leave a large gap)
    local w = 0
    for _, b in ipairs(el.content) do w = w + weight(b) end
    local brk = (w > 1800) and ', breakable: true' or ''
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

local function table_typst(tbl)
  local widths, n = {}, #tbl.colspecs
  for i, cs in ipairs(tbl.colspecs) do
    local w = cs[2]
    if type(w) ~= 'number' or w <= 0 then w = 1 / n end
    widths[i] = string.format('%.3ffr', w)
  end
  local rows = 0
  for _, body in ipairs(tbl.bodies) do rows = rows + #body.body end
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

local function header(el)
  local out = {}
  if el.classes:includes('pagebreak') then table.insert(out, raw('#pagebreak(weak: true)')) end
  if el.classes:includes('unnumbered') then
    table.insert(out, raw('#heading(level: ' .. el.level .. ', numbering: none)[' ..
                          inline_typst(pandoc.utils.stringify(el.content)) .. ']'))
  else
    table.insert(out, el)
  end
  if #out == 1 and out[1] == el then return nil end
  return out
end

-- A paragraph that only holds an image becomes a full-width figure block.
local function para(el)
  if #el.content == 1 and el.content[1].t == 'Image' then
    local img = el.content[1]
    local w = img.attributes.width
    local args = q(img.src) .. (w and (', width: ' .. w) or ', width: 100%')
    return raw('#flowblock[#image(' .. args .. ')]')
  end
end

local function image(el)
  if not el.src:match('^/') and not el.src:match('^%a[%w+.-]*:') then
    el.src = '/' .. el.src
  end
  return el
end

-- ---------------------------------------------------------------------------
-- Exact vertical spacing between top-level blocks.
-- ReportLab ADDS the space after one block to the space before the next; Typst uses the
-- larger of the two. This pass groups the top-level blocks into units (paragraph, list,
-- heading, box, command card), then inserts the ReportLab gap between every two units as a
-- weak #v() (an explicit #v() replaces Typst's own block spacing; weak = dropped at page top).
-- A spacer written in Markdown (```{=typst} #v(4pt, weak: true) ```) is ADDED to that gap,
-- as in ReportLab.
--   gap = TAIL[previous unit] + HEAD[next unit] + spacers
--
-- Spacing scheme (points). TAIL = space a unit leaves after itself, HEAD = space a unit wants before
-- itself. Edit these two tables (together with the matching values in template/manual.typ) to make
-- the layout tighter or airier.
--   text: paragraph spaceAfter 6   list: last item spaceAfter 3   h1: spaceBefore 14, spaceAfter 10
--   h2: spaceBefore 16, spaceAfter 6   box (table, figure, note): 6 after   card: 10 after
local TAIL = { text = 8.29, list = 5.29, h1 = 9.92, h2 = 6.74, box = 6, card = 10 }
local HEAD = { text = 2.11, list = 2.11, h1 = 14, h2 = 16, box = 0, card = 0 }
-- Typst adds about 8 pt of its own between two consecutive headings (measured on compiled PDFs),
-- so that transition is reduced by the same amount.
local PAIR_CORRECTION = { ['h1>h2'] = -8 }

local function rawtext(b) return (b.t == 'RawBlock' and b.format == 'typst') and b.text or nil end

local function exact_spacing(doc)
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

-- Inline elements first (spans, images), then blocks (divs, headers), then spacing.
return {
  { Span = span, Image = image },
  { Table = table_typst },
  { Para = para },
  { Div = div, Header = header },
  { Pandoc = exact_spacing },
}
