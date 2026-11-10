-- spans.lua – inline markup: [text]{.class} spans and image paths.
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
--   ![](book/figures/x.svg)   -> image path made project-root relative (/book/figures/x.svg)
local util = require('util')
local q = util.q

local M = {}

-- class -> Typst call taking the span's text
local WITH_TEXT = { key = 'key', ver = 'ver', doc = 'docver', tested = 'tested', cmd = 'cmdref' }
-- class -> Typst call without arguments
local NO_TEXT = { unresolved = 'unresolvedtag', untested = 'untestedtag', advice = 'advicetag', studio = 'studiotag' }
-- classes are tried in this order (first match wins)
local ORDER = { 'key', 'ver', 'doc', 'tested', 'unresolved', 'untested', 'advice', 'cmd', 'studio' }

function M.span(el)
  for _, cls in ipairs(ORDER) do
    if el.classes:includes(cls) then
      if WITH_TEXT[cls] then
        return pandoc.RawInline('typst', '#' .. WITH_TEXT[cls] .. '(' .. q(pandoc.utils.stringify(el)) .. ');')
      end
      return pandoc.RawInline('typst', '#' .. NO_TEXT[cls] .. '();')
    end
  end
end

function M.image(el)
  if not el.src:match('^/') and not el.src:match('^%a[%w+.-]*:') then
    el.src = '/' .. el.src
  end
  return el
end

-- Parse a Markdown snippet stored in an attribute (card name, key, note title) and return Typst markup.
function M.inline_typst(s)
  if s == nil or s == '' then return '' end
  local doc = pandoc.read(s, 'markdown')
  doc = doc:walk({ Span = M.span })
  if #doc.blocks == 0 then return '' end
  local plain = pandoc.Pandoc({ pandoc.Plain(doc.blocks[1].content) })
  return (pandoc.write(plain, 'typst'):gsub('%s+$', ''))
end

return M
