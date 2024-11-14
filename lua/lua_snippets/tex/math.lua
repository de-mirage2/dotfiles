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

function in_math() 
  return vim.api.nvim_eval("vimtex#syntax#in_mathzone()") == 1
end

local rs = ls.extend_decorator.apply(ls.snippet, { condition = in_math, show_condition = in_math, wordTrig = false, trigEngine = 'pattern' }) -- regex snippet
local s =  ls.extend_decorator.apply(ls.snippet, { condition = in_math, show_condition = in_math, wordTrig = false, trigEngine = 'pattern' }) --  plain snippet
local raus = ls.extend_decorator.apply(ls.snippet, { condition = in_math, show_condition = in_math, wordTrig = false, snippetType = 'autosnippet', trigEngine = 'pattern' }) -- regex autosnippet
local aus = ls.extend_decorator.apply(ls.snippet, { condition = in_math, show_condition = in_math, wordTrig = false, snippetType = 'autosnippet', trigEngine = 'plain' }) -- plain

-- i hate lua --

M = {
  -- s({trig = "testMath"}, t("math.lua LOADED")),

  -- power & subscript
  --aus({trig = "++"}, fmta([[^{<>}]], {i(1)})),
  --aus({trig = "--"}, fmta([[_{<>}]], {i(1)})),

  -- e^{}
  aus({trig = "eE"}, fmta([[e^{<>}]], {i(1)})),

  -- derivative
  aus({trig = "dydx"}, fmta([[\frac{\mathrm{d}<>}{\mathrm{d}<>}]], {i(1,'y'), i(2,'x')})),
  aus({trig = "ddx"}, fmta([[\frac{\mathrm{d}}{\mathrm{d}<>}]], {i(1,'x')})),
  aus({trig = "pypx"}, fmta([[\frac{{\partial}<>}{{\partial}<>}]], {i(1), i(2)})),
  aus({trig = "ppx"}, fmta([[\frac{\partial}{{\partial}<>}]], {i(1)})),

  -- fraction & binomial
  aus({trig = 'ff'}, fmta([[\frac{<>}{<>}]], {i(1), i(2)})),
  aus({trig = 'ncr'}, fmta([[\binom{<>}{<>}]], {i(1), i(2)})),

  -- function
  aus({trig = 'func'}, fmta([[<> : <> \to <> ; <> \mapsto <> ]], {i(1,'f'), i(2, '\\mathbb{R}'), i(3, '\\mathbb{R}'), i(4,'x'), i(0,'e^x')})),

  -- limit
  aus({trig = 'lmt'}, fmta([[\lim_{<>\to{<>}}\left(<>\right)]], {i(1), i(2,'\\infty'), i(0)})), 
  aus({trig = 'lms'}, fmta([[\limsup_{<>\to{<>}}\left(<>\right)]], {i(1), i(2), i(0)})), 
  aus({trig = 'lmi'}, fmta([[\liminf_{<>\to{<>}}\left(<>\right)]], {i(1), i(2), i(0)})), 

  -- integrals - indef and def w/ contour variations
  aus({trig = 'int'}, fmta([[\int_{<>}^{<>}<>\,\mathrm{d}<>]], {i(1), i(2), i(0), i(3,'x')})), -- definite integral
  aus({trig = 'Int'}, fmta([[\int<>\,\mathrm{d}<>]], {i(0), i(1,'x')})), -- indefinite integral
  aus({trig = 'inT'}, fmta([[\int_{<>}<>\,\mathrm{d}<>]], {i(1), i(0), i(2,'x')})), -- integral over space
  aus({trig = 'INT'}, fmta([[\int<>\,\mathrm{d}<>]], {i(2), i(1,'x')})), -- quick integral
  aus({trig = 'ont'}, fmta([[\oint_{<>}<>\,\mathrm{d}<>]], {i(1,'C'), i(0), i(2,'z')})), -- definite contour integral
  aus({trig = 'onT'}, fmta([[\oint<>\,\mathrm{d}<>]], {i(0), i(1,'z')})), -- indefinite contour integral

  -- fonts
  aus({trig = 'mtb'}, fmta([[\mathbb{<>}]], {i(1)})), -- blackboard bold
  aus({trig = 'mtc'}, fmta([[\mathcal{<>}]], {i(1)})), -- calligraphic
  aus({trig = 'mtr'}, fmta([[\mathrm{<>}]], {i(1)})),  -- roman

  -- left-right delimiters
  aus({trig = 'lrp'}, fmta([[\left(<>\right)]], {i(1)})),
  aus({trig = 'lr|'}, fmta([[\left|<>\right|]], {i(1)})),
  aus({trig = 'lrr'}, fmta([=[\left\[<>\right\]]=], {i(1)})),
  aus({trig = 'lre'}, fmta([[\left.<>\right\vert]], {i(1)})),
  aus({trig = 'lrn'}, fmta([[\left\Vert<>\right\Vert]], {i(1)})),
  aus({trig = 'lrb'}, fmta([[\left\{<>\right\}]], {i(1)})),
  aus({trig = 'lrv'}, fmta([[\left\langle<>\right\rangle]], {i(1)})),

  -- taylor-maclaurin
  aus({trig = 'tayl'}, fmta([[\sum_{n=0}^{<>}\frac{f^{(n)}\left(<>\right)}{n!}\left(x-<>\right)^n]], {i(1), i(2, 'c'), rep(2)})),
  aus({trig = 'macl'}, fmta([[\sum_{n=0}^{<>}\frac{f^{(n)}(0)x^n}{n!}]], {i(1)})),  

  -- common maclaurin series
  aus({trig = 'mace'}, fmta([[\sum_{n=0}^{\infty}\frac{<>^n}{n!}]], {i(1,'x')})), -- exp(x)
  aus({trig = 'macs'}, fmta([[\sum_{n=0}^{\infty}(-1)^n\frac{<>^{2n+1}}{(2n+1)!}]], {i(1,'x')})), -- sin(x)
  aus({trig = 'macc'}, fmta([[\sum_{n=0}^{\infty}(-1)^n\frac{<>^{2n}}{(2n)!}]], {i(1,'x')})), -- cos(x)
  aus({trig = 'maca'}, fmta([[\sum_{n=0}^{\infty}(-1)^n\frac{<>^{2n+1}}{2n+1}]], {i(1,'x')})), -- arctan(x)
  aus({trig = 'macS'}, fmta([[\sum_{n=0}^{\infty}\frac{<>^{2n+1}}{(2n+1)!}]], {i(1,'x')})), -- sinh(x)
  aus({trig = 'macC'}, fmta([[\sum_{n=0}^{\infty}\frac{<>^{2n}}{(2n)!}]], {i(1,'x')})), -- cosh(x)
  aus({trig = 'macA'}, fmta([[\sum_{n=0}^{\infty}\frac{<>^{2n+1}}{2n+1}]], {i(1,'x')})), -- arctanh(x)
  aus({trig = 'macn'}, fmta([[\sum_{n=1}^{\infty}(-1)^n\frac{<>^n}{n}]], {i(1,'x')})), -- ln(1+x)

  -- dot series
  aus({trig = 'dot', priority=1000}, fmta([[\dot{<>}]], {i(1)})),
  aus({trig = 'ddot', priority=1001}, fmta([[\ddot{<>}]], {i(1)})),
  aus({trig = 'dddot', priority=1002}, fmta([[\dddot{<>}]], {i(1)})),
  aus({trig = 'ddddot', priority=1003}, fmta([[\ddddot{<>}]], {i(1)})),
  
  raus({trig = '([%a%)%]%}])0(%d)'}, f( function(_, snip) return snip.captures[1].."_{"..snip.captures[2].."}" end )), -- a01 -> a_{1} and k08 -> k_{8}
}

local auto_cmdparenth = {
  "exp",
  "Im",
  "Re",
  "Pr",
  "gcd",
  "lcm",
}

local auto_cmdbracket = {
  "vec",
  "bar",
  "hat",
  "dot",
}

local auto_bigcmdparenth = {
  "sum",
  "prod",
  "coprod",
  "bigcap",
  "bigcup",
}

local auto_cmd = {
  "aleph", -- non-func
  "ast",
  "perp",
  "propto",
  "log", -- func
  "ln",
  "argmax",
  "argmin",
  "sqrt",
}

local auto_cmd_pair = {
  ['asin'] = 'arcsin',
  ['acos'] = 'arccos',
  ['atan'] = 'arctan',
  ['-='] = 'equiv',
  ['~='] = 'approx',
  ['~~'] = 'sim',
  ['!='] = 'neq',
  [':='] = 'definedas',
  ['>='] = 'geq',
  ['<='] = 'leq',
  ['**'] = 'cdot',
  ['xx'] = 'times',
  ['dP'] = 'partial',
  ['dD'] = 'mathrm{d}',
  ['EE'] = 'exists',
  ['NE'] = 'nexists',
  ['FA'] = 'forall',
  ['iN'] = 'in',
  ['NN'] = 'mathbb{N}',
  ['RR'] = 'mathbb{R}',
  ['ZZ'] = 'mathbb{Z}',
  ['QQ'] = 'mathbb{Q}',
  ['CC'] = 'mathbb{C}',
  ['OO'] = 'emptyset',
  ['nN'] = 'notin',
  ['cc'] = 'subset',
  ['qq'] = 'supset',
  ['cq'] = 'subseteq',
  ['qc'] = 'supseteq',
  ['::'] = 'colon',
  ['VV'] = 'lor',
  ['MM'] = 'land',
  ['UU'] = 'cup',
  ['nn'] = 'cap',
  ['ssup'] = 'sup',
  ['sinf'] = 'inf',
  ['ooo'] = 'infty',
  ['lll'] = 'ell',
  --['inV'] = '^{-1}',
  --['coM'] = '^\\complement'
  ['nB'] = 'nabla',
  ['qed'] = 'blacksquare',
  ['thfr'] = 'therefore',
  ['becs'] = 'because',
  ['|>'] = 'mapsto',
  ['|->'] = 'longmapsto',
  ['->'] = 'to',
  ['<-'] = 'gets',
  ['=>'] = 'implies',
  ['<='] = 'impliedby',
  ['iff'] = 'iff',
  ['<H>'] = 'rightleftharpoons'
  ['+-'] = 'pm',
  ['-+'] = 'mp',
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
  ['h'] = 'theta',
  ['H'] = 'Theta',
  ['vh'] = 'vartheta',
  ['k'] = 'kappa',
  ['l'] = 'lambda',
  ['L'] = 'Lambda',
  ['m'] = 'mu',
  ['n'] = 'nu',
  ['x'] = 'xi',
  ['X'] = 'Xi',
  ['pi'] = 'pi',
  ['Pi'] = 'Pi',
  ['r'] = 'rho',
  ['s'] = 'sigma',
  ['S'] = 'Sigma',
  ['t'] = 'tau',
  ['u'] = 'upsilon',
  ['U'] = 'Upsilon',
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
  table.insert( auto_cmdparenth_snippets, aus( { trig = v, }, fmta([[\<>\left(<>\right)]], {v, i(0)}) ) )
  --table.insert( auto_cmdparenth_snippets, aus( {regTrig = true, wordTrig = false, trig = [[(^\\)]]..v, }, fmta([[\<>\left(<>\right)]], {v, i(0)}) ) )
end
vim.list_extend(M, auto_cmdparenth_snippets)

local auto_cmdbracket_snippets = {}
for _, v in ipairs(auto_cmdbracket) do
  table.insert( auto_cmdbracket_snippets, aus( { trig = v, }, fmta([[\<>{<>}]], {v, i(1)}) ) )
end
vim.list_extend(M, auto_cmdbracket_snippets)

local auto_bigcmdparenth_snippets = {}
for _, v in ipairs(auto_bigcmdparenth) do
  table.insert( auto_bigcmdparenth_snippets, aus( { trig = v, }, fmta([[\<>_{<>}^{<>}]], {v, i(1), i(2)}) ) )
  --table.insert( auto_bigcmdparenth_snippets, aus( { regTrig = true, wordTrig = false, trig = [[(^\\)]]..v, }, fmta([[\<>_{<>}^{<>}]], {v, i(1), i(2)}) ) )
end
vim.list_extend(M, auto_bigcmdparenth_snippets)


local auto_cmd_snippets = {}
for _, v in ipairs(auto_cmd) do
  table.insert( auto_cmd_snippets, aus( { trig = v, }, fmta([[\<>]], {v}) ) )
  --table.insert( auto_cmd_snippets, aus( {regTrig = true, wordTrig = false, trig = [[(^\\)]]..v, }, fmta([[\<> ]], {v}) ) )
end
vim.list_extend(M, auto_cmd_snippets)

local auto_cmd_pair_snippets = {}
for k, v in pairs(auto_cmd_pair) do 
  table.insert( auto_cmd_pair_snippets, aus( { trig = k, }, fmta([[\<>]], {v}) ) )
end
vim.list_extend(M, auto_cmd_pair_snippets)

local auto_greek_snippets = {}
for k, v in pairs(auto_greek) do 
  table.insert( auto_greek_snippets, aus( { trig = ';' .. k, }, fmta([[\<>]], {v}) ) )
end
vim.list_extend(M, auto_greek_snippets)

return M
