-- util.lua – small helpers shared by the filter modules.
local M = {}

-- Typst string literal
function M.q(s)
  return '"' .. s:gsub('\\', '\\\\'):gsub('"', '\\"') .. '"'
end

-- a raw Typst block
function M.raw(s) return pandoc.RawBlock('typst', s) end

-- Block "weight": approximate height in characters of text (about 110 per line);
-- a diagram counts as WEIGHT_IMAGE. Used to decide which cards and note boxes may split across pages.
M.WEIGHT_IMAGE = 1100

function M.weight(b)
  local w = 0
  pandoc.walk_block(pandoc.Div({ b }), { Image = function() w = w + M.WEIGHT_IMAGE end })
  local n = #pandoc.utils.stringify(b)
  return w + math.max(n, 110)  -- every block is at least a line
end

-- total weight of a list of blocks
function M.total_weight(blocks)
  local w = 0
  for _, b in ipairs(blocks) do w = w + M.weight(b) end
  return w
end

-- the text of a raw Typst block, or nil
function M.rawtext(b) return (b.t == 'RawBlock' and b.format == 'typst') and b.text or nil end

return M
