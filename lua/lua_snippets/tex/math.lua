local ls = require("luasnip")
local s = ls.snippet
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

function in_math() 
  return vim.api.nvim_eval("vimtex#syntax#in_mathzone()") == 1
end

function autobasic(tr, defi)
  return s({trig = tr, condition = in_math, show_condition = in_math, snippetType = 'autosnippet'}, t('{'..defi..'}'))
end

function sbasic(tr, defi)
  return s({trig = tr, condition = in_math, show_condition = in_math}, t('{'..defi..'}'))
end
-- i hate lua --

M = {
  s({trig = "testMath", condition = in_math, show_condition = in_math}, t("math.lua LOADED")),

  -- auto
  autobasic('pdX', '\\partial'),
  autobasic('dX', '\\mathrm{d}'),
  
  autobasic('exi', '\\exists'),
  autobasic('nexi', '\\nexists'),

  autobasic('ins', '\\in'),
  autobasic('nin', '\\notin'),
  autobasic('subs', '\\subset'),
  autobasic('sups', '\\supset'),
  autobasic('sube', '\\subseteq'),
  autobasic('supe', '\\supseteq'),
  autobasic('ssup', '\\sup'),
  autobasic('sinf', '\\inf'),

  autobasic('arrl', '\\leftarrow'),
  autobasic('arrr', '\\rightarrow'),
  autobasic('arrL', '\\Leftarrow'),
  autobasic('arrR', '\\Rightarrow'),

  autobasic('inf', '\\infty'),

  autobasic('inv', '^{-1}'),

  -- basic
  sbasic('qed', '\\blacksquare'),
  sbasic('thfr', '\\therefore'),
  sbasic('becs', '\\because'),
  
  -- derivative
  s({trig = "dddX", condition = in_math, show_condition = in_math, snippetType = 'autosnippet'}, fmta([[\frac{\mathrm{d}<>}{\mathrm{d}<>}]], {i(1), i(2)})),
  s({trig = "ddX", condition = in_math, show_condition = in_math, snippetType = 'autosnippet'}, fmta([[\frac{\mathrm{d}}{\mathrm{d}<>}]], {i(1)})),
  s({trig = "pppX", condition = in_math, show_condition = in_math, snippetType = 'autosnippet'}, fmta([[\frac{{\partial}<>}{{\partial}<>}]], {i(1), i(2)})),
  s({trig = "ppX", condition = in_math, show_condition = in_math, snippetType = 'autosnippet'}, fmta([[\frac{\partial}{{\partial}<>}]], {i(1)})),

  -- fraction & binomial
  s({trig = 'ff', condition = in_math, show_condition = in_math, snippetType = 'autosnippet'}, fmta([[\frac{<>}{<>}]], {i(1), i(2)})),
  s({trig = 'ncr', condition = in_math, show_condition = in_math, snippetType = 'autosnippet'}, fmta([[\binom{<>}{<>}]], {i(1), i(2)})),

  -- function
  s({trig = 'func', condition = in_math, show_condition = in_math, snippetType = 'autosnippet'}, fmta([[<> : <> \to <> ; <> \mapsto <> ]], {i(1, 'f'), i(2, '\\mathbb{R}'), i(3, '\\mathbb{R}'), i(4, 'x'), i(0)})),

  -- limit
  s({trig = 'lim', condition = in_math, show_condition = in_math, snippetType = 'autosnippet'}, fmta([[\lim_{<>\to{<>}}\left(<>\right)]], {i(1), i(2), i(0)})), 

  -- integral
  s({trig = 'int', condition = in_math, show_condition = in_math, snippetType='autosnippet'}, fmta([[\int_{<>}^{<>}<>\,\mathrm{d}<>]], {i(1), i(2), i(0), i(3)})),

  -- fonts
  s({trig = 'mtb', condition = in_math, show_condition = in_math, snippetType = 'autosnippet'}, fmta([[\mathbb{<>}]], {i(1)})), 
  s({trig = 'mtc', condition = in_math, show_condition = in_math, snippetType = 'autosnippet'}, fmta([[\mathcal{<>}]], {i(1)})), 
  s({trig = 'mtr', condition = in_math, show_condition = in_math, snippetType = 'autosnippet'}, fmta([[\mathrm{<>}]], {i(1)})), 
}

local auto_cmdparenth = {
  "arcsin",
  "sin",
  "arccos",
  "cos",
  "arctan",
  "tan",
  "csc",
  "sec",
  "cot",
  "log",
  "ln",
  "exp",
  "det",
  "max",
  "min",
  "argmax",
  "argmin",
  "det",
  "vec",
  "Im",
  "Re",
}

local auto_bigcmdparenth = {
  "sum",
  "prod",
  "coprod",
  "bigcap",
  "bigcup",
}

local auto_cmd = {
  "aleph",
  "ast",
  "star",
  "perp",
  "propto",
  "deg",
  "angle",
  "approx",
  "neq",
  "leq",
  "geq",
  "nabla",
  "neg",
  "emptyset",
  "forall",
}

local auto_greek = {
  ['a'] = 'alpha',
  ['A'] = 'Alpha',
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

local auto_cmdparenth_snippets = {}
for _, v in ipairs(auto_cmdparenth) do
  table.insert( auto_cmdparenth_snippets, s( { trig = v, condition = in_math, show_condition = in_math, snippetType = 'autosnippet' }, fmta([[\<>\left(<>\right)]], {v, i(0)}) ) )
end
vim.list_extend(M, auto_cmdparenth_snippets)

local auto_bigcmdparenth_snippets = {}
for _, v in ipairs(auto_bigcmdparenth) do
  table.insert( auto_bigcmdparenth_snippets, s( { trig = v, condition = in_math, show_condition = in_math, snippetType = 'autosnippet' }, fmta([[\<>_{<>}^{<>}]], {v, i(1), i(2)}) ) )
end
vim.list_extend(M, auto_bigcmdparenth_snippets)


local auto_cmd_snippets = {}
for _, v in ipairs(auto_cmd) do
  table.insert( auto_cmd_snippets, s( { trig = v, condition = in_math, show_condition = in_math, snippetType = 'autosnippet' }, fmta([[{\<>}]], {v}) ) )
end
vim.list_extend(M, auto_cmd_snippets)

local auto_greek_snippets = {}
for k, v in pairs(auto_greek) do 
  table.insert( auto_greek_snippets, s( { trig = ';' .. k, condition = in_math, show_condition = in_math, snippetType = 'autosnippet' }, fmta([[{\<>}]], {v}) ) )
end
vim.list_extend(M, auto_greek_snippets)

return M
