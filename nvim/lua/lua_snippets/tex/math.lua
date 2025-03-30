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
-- local ms = ls.multi_snippet
local k = require("luasnip.nodes.key_indexer").new_key

function in_math() 
  return vim.api.nvim_eval("vimtex#syntax#in_mathzone()") == 1
end

function amath()
  return in_math() and vim.b.vimtex.packages['amsmath'] ~= nil
end

function asymb_cond()
  return in_math() and vim.b.vimtex.packages['amssymb'] ~= nil
end

local s =  ls.extend_decorator.apply(ls.snippet, { condition = in_math, show_condition = in_math, wordTrig = false, trigEngine = 'plain' }) -- plain snippet
local rs = ls.extend_decorator.apply(ls.snippet, { condition = in_math, show_condition = in_math, wordTrig = false, trigEngine = 'pattern' }) -- regex snippet
local ms = ls.extend_decorator.apply(ls.multi_snippet, { condition = in_math, show_condition = in_math, wordTrig = false, trigEngine = 'plain' }) -- plain multisnippet

local aus = ls.extend_decorator.apply(ls.snippet, { condition = in_math, show_condition = in_math, wordTrig = false, snippetType = 'autosnippet', trigEngine = 'plain' }) -- plain autosnippet
local raus = ls.extend_decorator.apply(ls.snippet, { condition = in_math, show_condition = in_math, wordTrig = false, snippetType = 'autosnippet', trigEngine = 'pattern' }) -- regex autosnippet
local maus = ls.extend_decorator.apply(ls.multi_snippet, { common = { condition = in_math, show_condition = in_math, wordTrig = false, snippetType = 'autosnippet', trigEngine = 'plain'} }) -- plain multiautosnippet

local ams_aus = ls.extend_decorator.apply(ls.snippet, { condition = amath, show_condition = amath, wordTrig = false, snippetType = 'autosnippet', trigEngine = 'plain' }) -- plain amsmath autosnippet
local asymb_aus = ls.extend_decorator.apply(ls.snippet, { condition = asymb_cond, show_condition = asymb_cond, wordTrig = false, snippetType = 'autosnippet', trigEngine = 'plain' }) -- plain amssymb autosnippet

M = {
  -- s({trig = "testMath"}, t("math.lua LOADED")),

  --aus({trig = "++"}, fmta([[^{<>}]], {i(1)})),
  --aus({trig = "--"}, fmta([[_{<>}]], {i(1)})),
  
  maus({',e','eE'}, fmta([[e^{<>}]], {i(1)})),
  maus({',T','tT','TT'}, t('^{\\mathsf{T}}')),
  maus({',I','iI','inV'}, t('^{-1}')),
  ams_aus(',c', t('^{\\complement}')),

  aus(';1', fmta([[\sin{<>}]], {i(1)})),
  aus(';2', fmta([[\cos{<>}]], {i(1)})),
  aus(';3', fmta([[\tan{<>}]], {i(1)})),
  aus(';4', fmta([[\sec{<>}]], {i(1)})),
  aus(';5', fmta([[\csc{<>}]], {i(1)})),
  aus(';6', fmta([[\cot{<>}]], {i(1)})),
  aus(';7', fmta([[\log{<>}]], {i(1)})),
  aus(';8', fmta([[\log_2{<>}]], {i(1)})),
  aus(';9', fmta([[\log_{10}{<>}]], {i(1)})),
  aus(';0', fmta([[\ln{<>}]], {i(1)})),

  aus('DD', fmta([[\frac{\mathrm{d}<>}{\mathrm{d}<>}]], {i(1,'y'), i(2,'x')})),
  aus('dD', fmta([[\frac{\mathrm{d}}{\mathrm{d}<>}]], {i(1,'x')})),
  aus('PP', fmta([[\frac{{\partial}<>}{{\partial}<>}]], {i(1), i(2)})),
  aus('pP', fmta([[\frac{\partial}{{\partial}<>}]], {i(1)})),
  
  aus(',i', fmta([[\int{<>}\,\mathrm{d}{<>}]], {i(2,'f(x)'), i(1,'x')})),
  aus('int', fmta([[\int_{<>}^{<>}{<>}\,\mathrm{d}{<>}]], {i(2,'-\\infty'), i(3,'\\infty'), i(4,'f(x)'), i(1,'x')})),
  aus('inT', fmta([[\int_{<>}<>\,{\mathrm{d}<>}]], {i(2,'\\Omega'), i(3,'f(x)'), i(1,'x')})),
  aus('InT', fmta([[\int\limits_{<>}<>\,{\mathrm{d}<>}]], {i(2,'x\\in\\Omega'), i(3,'f(x)'), i(1,'x')})),
  ams_aus('i2nt', fmta([[\iint{<>}\,{\mathrm{d}<>}]], {i(2,'f(x)'), i(1,'^2x')})),
  ams_aus('i2nT', fmta([[\iint_{<>}{<>}\,{\mathrm{d}<>}]], {i(2,'\\mathbb{R}^2'), i(3,'f(x,y)'), i(1,[[x\,\mathrm{d}y]])})),
  ams_aus('I2nT', fmta([[\iint\limits_{<>}{<>}\,{\mathrm{d}<>}]], {i(2,'\\mathbb{R}^2'), i(3,'f(x,y)'), i(1,[[x\,\mathrm{d}y]])})),
  ams_aus('i2NT', fmta([[\int_{<>}^{<>}\!\!\int_{<>}^{<>}{<>}\,{\mathrm{d}<>}]], {i(4,'0'), i(5,'2\\pi'), i(2,'-\\infty'), i(3,'\\infty'), i(6,'f(r,\\theta)r'), i(1,[[r\,\mathrm{d}\theta]])})),
  ams_aus('i3nt', fmta([[\iiint{<>}\,{\mathrm{d}<>}]], {i(2,'f(x)'), i(1,'^3x')})),
  ams_aus('i3nT', fmta([[\iiint_{<>}{<>}\,{\mathrm{d}<>}]], {i(2,'\\mathbb{R}^3'),i(3,'f(x,y,z)'), i(1,[[x\,\mathrm{d}y\,\mathrm{d}z]])})),
  ams_aus('I3nT', fmta([[\iiint\limits_{<>}{<>}\,{\mathrm{d}<>}]], {i(2,'\\mathbb{R}^3'),i(3,'f(x,y,z)'), i(1,[[x\,\mathrm{d}y\,\mathrm{d}z]])})),
  ams_aus('i3NT', fmta([[\int_{<>}^{<>}\!\!\int_{<>}^{<>}\!\!\int_{<>}^{<>}{<>}\,{\mathrm{d}<>}]], {i(6,'0'),i(7,'2\\pi'), i(4,'0'), i(5,'2\\pi'), i(2,'-\\infty'), i(3,'\\infty'), i(8,[[f(\rho,\theta,\phi)\]]), i(1,[[\rho\,\mathrm{d}\theta\,\mathrm{d}\phi]])})),
  aus('ont', fmta([[\oint_{<>}<>\,{\mathrm{d}<>}]], {i(2,'C'), i(3,'f(z)'), i(1,'z')})),
  aus('onT', fmta([[\oint{<>}\,{\mathrm{d}<>}]], {i(2,'f(z)'), i(1,'z')})),

  aus({trig = 'ff', priority=999}, fmta([[\frac{<>}{<>}]], {i(1), i(2)})),
  aus({trig = 'Ff', priority=999}, fmta([[\frac<>{<>}]], {i(1), i(2)})),
  aus({trig = 'fF', priority=999}, fmta([[\frac{<>}]], {i(1)})),
  aus({trig = 'FF', priority=999}, t([[\frac]])),
  aus({trig = 'nCr', priority=999}, fmta([[\binom{<>}{<>}]], {i(1), i(2)})),

  aus('Surj', fmta([[<> : <> \to <> ; <> \mapsto <> ]], {i(1,'f'), i(2, '\\mathbb{R}'), i(3, '\\mathbb{R}_{>0}'), i(4,'x'), i(0,'e^x')})),
  aus('Suj', fmta([[<> : <> \to <>]], {i(1,'f'), i(2, '\\mathbb{R}'), i(3, '\\mathbb{R}_{>0}')})),

  aus('lmi', fmta([[\liminf_{<>\to{<>}}]], {i(1), i(2)})), 
  aus('lms', fmta([[\limsup_{<>\to{<>}}]], {i(1), i(2)})), 
  maus({',l', 'lmt'}, fmta([[\lim_{<>\to{<>}}]], {i(1, 'x'), i(2,'\\infty')})), 
  aus(',L', fmta([[\limits_{<>}^{<>}]], {i(1, '-\\infty'), i(2,'\\infty')})), 

  aus('amax', fmta([[\argmax_{<>}{<>}]], {i(1, 'x'), i(2)})),
  aus('amin', fmta([[\argmin_{<>}{<>}]], {i(1, 'x'), i(2)})),

  aus('mtb', fmta([[\mathbf{<>}]], {i(1)})),
  aus('mti', fmta([[\mathit{<>}]], {i(1)})),
  aus('mtr', fmta([[\mathrm{<>}]], {i(1)})),
  aus('mts', fmta([[\mathsf{<>}]], {i(1)})),
  aus('mtt', fmta([[\mathtt{<>}]], {i(1)})),

  ams_aus('mtB', fmta([[\mathbb{<>}]], {i(1)})),
  ams_aus('mtC', fmta([[\mathcal{<>}]], {i(1)})),
  ams_aus('mtF', fmta([[\mathfrak{<>}]], {i(1)})),

  maus({'lra','lr|' }, fmta([[\left|<>\right|]], {i(1)})),
  maus({'lrb','lr[]'}, fmta([=[\left[<>\right]]=], {i(1)})),
  maus({'lrc','lrs','lr{}'}, fmta([[\left\{<>\right\}]], {i(1)})),
  maus({'lre','lr.' }, fmta([[\left.{<>}\right\vert]], {i(1)})),
  maus({'lrn','lrm' }, fmta([[\left\Vert{<>}\right\Vert]], {i(1)})),
  maus({'lrp','lr()'}, fmta([[\left(<>\right)]], {i(1)})),
  maus({'lrv','lr<','lr>'}, fmta([[\left\langle{<>}\right\rangle]], {i(1)})),

  aus('tayl', fmta([[\sum_{n=0}^{<>}\frac{f^{(n)}\left(<>\right)}{n!}\left(x-<>\right)^n]], {i(1), i(2, 'c'), rep(2)})),
  aus('macl', fmta([[\sum_{n=0}^{<>}\frac{f^{(n)}(0)x^n}{n!}]], {i(1)})),  

  aus('macexp', fmta([[\sum_{n=0}^{\infty}\frac{<>^n}{n!}]], {i(1,'x')})),
  aus('macsin', fmta([[\sum_{n=0}^{\infty}(-1)^n\frac{<>^{2n+1}}{(2n+1)!}]], {i(1,'x')})),
  aus('maccos', fmta([[\sum_{n=0}^{\infty}(-1)^n\frac{<>^{2n}}{(2n)!}]], {i(1,'x')})),
  aus('macatan', fmta([[\sum_{n=0}^{\infty}(-1)^n\frac{<>^{2n+1}}{2n+1}]], {i(1,'x')})),
  aus('macsnh', fmta([[\sum_{n=0}^{\infty}\frac{<>^{2n+1}}{(2n+1)!}]], {i(1,'x')})),
  aus('maccsh', fmta([[\sum_{n=0}^{\infty}\frac{<>^{2n}}{(2n)!}]], {i(1,'x')})),
  aus('macatnh', fmta([[\sum_{n=0}^{\infty}\frac{<>^{2n+1}}{2n+1}]], {i(1,'x')})),
  aus('macln', fmta([[\sum_{n=1}^{\infty}(-1)^n\frac{<>^n}{n}]], {i(1,'x')})),

  aus({trig = 'dot', priority=996}, fmta([[\dot{<>}]], {i(1)})),
  aus({trig = 'ddot', priority=997}, fmta([[\ddot{<>}]], {i(1)})),
  aus({trig = 'dddot', priority=998}, fmta([[\dddot{<>}]], {i(1)})),
  aus({trig = 'ddddot', priority=999}, fmta([[\ddddot{<>}]], {i(1)})),
 
  -- subscript digital
  raus({trig = '([%a%)%]%}])0(%d)'}, f( function(_, snip) return snip.captures[1].."_{"..snip.captures[2].."}" end )), -- a01 -> a_{1} and k08 -> k_{8}
}

local auto_loglike_pairs = {
  ['Pr'] = 'Pr',
  ['Im'] = 'Im',
  ['Re'] = 'Re',
  ['arG'] = 'arg',
  ['deT'] = 'det',
  ['diM'] = 'dim',
  ['exP'] = 'exp',
  ['keR'] = 'ker',
  ['miN'] = 'min',
  ['maX'] = 'max',
  ['gcD'] = 'gcd',

  ['lG'] = 'lg',
  ['lN'] = 'ln',
  ['loG'] = 'log',

  ['siN'] = 'sin',
  ['snH'] = 'sinh',
  ['asin'] = 'arcsin',
  ['coS'] = 'cos',
  ['csH'] = 'cosh',
  ['acos'] = 'arccos',
  ['taN'] = 'tan',
  ['tnH'] = 'tanh',
  ['seC'] = 'sec',
  ['csC'] = 'csc',
  ['coT'] = 'cot',
  ['ctH'] = 'coth',
}

local auto_bigcmdparenth = {
  'sum',
  'prod',
  'coprod',
  'bigcap',
  'bigcup',
}

local auto_cmdbracket = {
  'vec',
  'bar',
  'hat',
  'tilde',
  'sqrt',
}

local auto_cmd = {
  'aleph',
  'perp',
}

local auto_cmd_pair = {
  [',p'] = 'partial',
  [',d'] = 'mathrm{d}',
  ['VD'] = 'nabla',

  ['lll'] = 'ell',
  ['hh'] = 'hbar',
  ['II'] = 'imath',
  ['JJ'] = 'jmath',
  ['ii'] = 'hat{\\imath}',
  ['jj'] = 'hat{\\jmath}',
  ['kk'] = 'hat{k}',
  ['ooo'] = 'infty',

  ['+-'] = 'pm',
  ['-+'] = 'mp',

  ['**'] = 'ast',
  ['XX'] = 'star',
  ['..'] = 'cdot',
  ['##'] = 'times',

  ['.l'] = 'ldots',
  ['.c'] = 'cdots',

  [',='] = 'equiv',
  ['~='] = 'approx',
  ['~~'] = 'sim',
  ['!='] = 'neq',
  ['>='] = 'geq',
  ['<='] = 'leq',

  ['!!'] = 'neg',
  ['EE'] = 'exists',
  ['FA'] = 'forall',
  ['ee'] = 'in',
  ['!e'] = 'notin',
  ['O/'] = 'emptyset',
  ['cc'] = 'subset',
  ['qq'] = 'supset',
  ['cq'] = 'subseteq',
  ['qc'] = 'supseteq',
  ['VV'] = 'lor',
  ['MM'] = 'land',
  ['uu'] = 'cup',
  ['nn'] = 'cap',
  ['ssup'] = 'sup',
  ['sinf'] = 'inf',
  ['|>'] = 'mapsto',
  ['|->'] = 'longmapsto',
  ['->'] = 'to',
  ['<-'] = 'gets',
  ['=>'] = 'implies',
  ['<='] = 'impliedby',
  ['iff'] = 'iff',
  ['<H>'] = 'rightleftharpoons',
  ['::'] = 'colon',
}

local ams_auto_cmd_pair = {
  ['CC'] = 'mathbb{C}',
  ['HH'] = 'mathbb{H}',
  ['NN'] = 'mathbb{N}',
  ['QQ'] = 'mathbb{Q}',
  ['RR'] = 'mathbb{R}',
  ['ZZ'] = 'mathbb{Z}',
  ['!E'] = 'nexists',
  ['thfr'] = 'therefore',
  ['becs'] = 'because',
  [':='] = 'coloneq',
  ['qed'] = 'blacksquare',
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
  ['i'] = 'iota',
  ['k'] = 'kappa',
  ['l'] = 'lambda',
  ['L'] = 'Lambda',
  ['m'] = 'mu',
  ['n'] = 'nu',
  ['x'] = 'xi',
  ['X'] = 'Xi',
  ['p'] = 'pi',
  ['P'] = 'Pi',
  ['r'] = 'rho',
  ['s'] = 'sigma',
  ['S'] = 'Sigma',
  ['t'] = 'tau',
  ['u'] = 'upsilon',
  ['U'] = 'Upsilon',
  ['f'] = 'phi',
  ['vf'] = 'varphi',
  ['F'] = 'Phi',
  ['c'] = 'chi',
  ['y'] = 'psi',
  ['Y'] = 'Psi',
  ['o'] = 'omega',
  ['O'] = 'Omega',
}

local auto_loglike_snippets = {}
for _, v in ipairs(auto_loglike_pairs) do
  table.insert( auto_loglike_snippets, aus( { trig = v, }, fmta([[\<>{<>}]], {v, i(1)}) ) )
end
vim.list_extend(M, auto_loglike_snippets)

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

local ams_auto_cmd_pair_snippets = {}
for k, v in pairs(ams_auto_cmd_pair) do 
  table.insert( ams_auto_cmd_pair_snippets, ams_aus( { trig = k, }, fmta([[\<>]], {v}) ) )
end
vim.list_extend(M, ams_auto_cmd_pair_snippets)

local auto_greek_snippets = {}
for k, v in pairs(auto_greek) do 
  table.insert( auto_greek_snippets, aus( { trig = ';' .. k, }, fmta([[\<>]], {v}) ) )
end
vim.list_extend(M, auto_greek_snippets)

return M
