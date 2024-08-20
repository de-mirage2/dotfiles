local ls = require("luasnip")
-- local s = ls.snippet
local sn = ls.snippet_node
local isn = ls.indent_snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local events = require("luasnip.util.events")
local ai = require("luasnip.nodes.absolute_indexer")
local extras = require("luasnip.extras")
local l = extras.lambda
local rep = extras.rep
local p = extras.partial
local m = extras.match
local n = extras.nonempty
local dl = extras.dynamic_lambda
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local conds = require("luasnip.extras.expand_conditions")
local postfix = require("luasnip.extras.postfix").postfix
local types = require("luasnip.util.types")
local parse = require("luasnip.util.parser").parse_snippet
local ms = ls.multi_snippet
local k = require("luasnip.nodes.key_indexer").new_key

function in_doc() 
  local is_in_doc = vim.fn["vimtex#env#is_inside"]("document")
  return (is_in_doc[1] > 0 and is_in_doc[2] > 0 and (vim.api.nvim_eval("vimtex#syntax#in_mathzone()") == 0))
end

local s = ls.extend_decorator.apply(ls.snippet, { show_condition = in_doc, condition = in_doc })
local aus = ls.extend_decorator.apply(s, { snippetType = 'autosnippet', wordTrig = false, trigEngine = 'pattern' })

M = {
  --s({trig = 'testDocument' }, t("document.lua LOADED")),
  aus({trig = '=ali'}, fmta(
    [[
    \begin{ali}
      <>
    \end{ali}
    ]], {i(0)}
  )),
  aus({trig = '=env'}, fmta(
    [[
    \begin{<>}
      <>
    \end{<>}
    ]], {i(1,'gather'), i(0), rep(1)}
  )),
  aus({trig = '=sec'}, fmta([[\section{<>}]], i(1))),
  aus({trig = '=ssec'}, fmta([[\subsection{<>}]], i(1))),
  aus({trig = '=sssec'}, fmta([[\subsubsection{<>}]], i(1))),
  aus({trig = '=mm'}, fmta([[\(<>\)]], i(1))),
  aus({trig = '=MM'}, fmta([=[\[<>\]]=], i(1))),
  --[=[s({trig = "tablelab(%d)x(%d)", regTrig = true, snippetType = 'autosnippet', show_condition = in_doc, condition = in_doc},
    f(function(args, snip)
      local r, c = snip.capture[1], snip.capture[2] -- rows and columns

      local str = [[
  \begin{center}\begin{spreadtab}{{tabular}{lc}}]] .. string.rep('c',c) .. [[l}}
    \toprule
  &@\multicolumn{]] .. tostring(c+1) .. [[}{c}{Trial Data}& \\
    \cmidrule(lr){2-]] .. tostring(c+2) .. [[}
  @ $x$ (units) & @ ]] 
      for x=1,c,1 do
        str = str .. tostring(x) .. ' & @ '
      end
      str = str .. [[avg. \\]]
      local lin = [[  0.0 & ]]
      for x=1,c,1 do 
        lin = lin .. tostring(x/10) .. [[ & ]]
      end
      lin = lin .. [[:={sum(b]]
      for x=1,r,1 do 
        str = str .. string.char(10) .. lin .. tostring(1+x) .. [[:[-1,0])/]] .. tostring(c) .. [[} \\]]
      end
      str = str .. [[

    \bottomrule\\
  \end{spreadtab}\end{center}]]

      return str
    end )),
  ]=]
}

local auto_expand = {
  ['indep'] = 'independent',
  ['govt'] = 'government',
}

local auto_greek = {
  ['a'] = 'alpha',
  ['b'] = 'beta',
  ['g'] = 'gamma',
  ['G'] = 'Gamma',
  ['d'] = 'delta',
  ['D'] = 'Delta',
  ['ep'] = 'epsilon',
  ['ve'] = 'varepsilon',
  ['z'] = 'zeta',
  ['et'] = 'eta',
  ['th'] = 'theta',
  ['Th'] = 'Theta',
  ['l'] = 'lambda',
  ['L'] = 'Lambda',
  ['m'] = 'mu',
  ['x'] = 'xi',
  ['X'] = 'Xi',
  ['r'] = 'rho',
  ['s'] = 'sigma',
  ['t'] = 'tau',
  ['ph'] = 'phi',
  ['vp'] = 'varphi',
  ['Ph'] = 'Phi',
  ['x'] = 'chi',
  ['ps'] = 'psi',
  ['Ps'] = 'Psi',
  ['o'] = 'omega',
  ['O'] = 'Omega',
}

local auto_greek_snippets = {}
for k, v in pairs(auto_greek) do 
  table.insert( auto_greek_snippets, aus( { trig = '=g' .. k, }, fmta([[\(\<>\)]], {v}) ) )
end
vim.list_extend(M, auto_greek_snippets)

return M