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
  return is_in_doc[1] > 0 and is_in_doc[2] > 0 and vim.api.nvim_eval("vimtex#syntax#in_mathzone()") == 0
end

function ams_cond()
  return in_doc() and (vim.b.vimtex.packages['amsmath'] ~= nil or vim.b.vimtex.packages['mathtools'] ~= nil)
end

function tg_cond()
  return in_doc() and vim.b.vimtex.packages['textgreek'] ~= nil
end

local get_vis = function(args, parent)
  if (#parent.snippet.env.LS_SELECT_RAW > 0) then
    return sn(nil, i(1, parent.snippet.env.LS_SELECT_RAW))
  else  -- If LS_SELECT_RAW is empty, return a blank insert node
    return sn(nil, i(1))
  end
end

local s = ls.extend_decorator.apply(ls.snippet, { show_condition = in_doc, condition = in_doc })
local aus = ls.extend_decorator.apply(ls.snippet, { hidden = true, condition = in_doc, snippetType = 'autosnippet', wordTrig = false, trigEngine = 'pattern' })
local ams_aus = ls.extend_decorator.apply(ls.snippet, { hidden = true, condition = ams_cond, snippetType = 'autosnippet', wordTrig = false, trigEngine = 'pattern' })
local tg_aus = ls.extend_decorator.apply(ls.snippet, { hidden = true, condition = tg_cond, snippetType = 'autosnippet', wordTrig = false, trigEngine = 'pattern' })

M = {
  --s({trig = 'testDocument' }, t("document.lua LOADED")),
  ams_aus('=al', fmta(
    [[
    \begin{align}
      <>
    \end{align}
    ]], {i(0)}
  )),
  ams_aus('*al', fmta(
    [[
    \begin{align*}
      <>
    \end{align*}
    ]], {i(0)}
  )),
  aus('=eq', fmta(
    [[
    \begin{equation}<>\end{equation}
    ]], {i(1)}
  )),
  aus('*eq', fmta(
    [[
    \begin{equation*}<>\end{equation*}
    ]], {i(1)}
  )),
  ams_aus('=ga', fmta(
    [[
    \begin{gather}
      <>
    \end{gather}
    ]], {i(0)}
  )),
  ams_aus('*ga', fmta(
    [[
    \begin{gather*}
      <>
    \end{gather*}
    ]], {i(0)}
  )),
  aus('=it', fmta(
    [[
    \begin{itemize}
      \item <>
    \end{itemize}
    ]], {i(0)}
  )),
  ams_aus('=mu', fmta(
    [[
    \begin{multiline}
      <>
    \end{multiline}
    ]], {i(0)}
  )),
  ams_aus('*mu', fmta(
    [[
    \begin{multiline*}
      <>
    \end{multiline*}
    ]], {i(0)}
  )),
  aus('=tp', fmta(
    [[
    \begin{center}\begin{tikzpicture}[<>]
      <>
    \end{tikzpicture}\end{center}
    ]], {i(1), i(0)}
  )),
  aus('=tb', fmta(
    [[
    \begin{center}\begin{tabular}{<>}
      <>
    \end{tabular}\end{center}
    ]], {i(1), i(0)}
  )),
  aus('=nv', fmta(
    [[
    \begin{<>}
      <>
    \end{<>}
    ]], {i(1), i(0), rep(1)}
  )),
  aus({trig = '=S', priority = 997}, fmta([[\section{<>}]], i(1))),
  aus({trig = '==S', priority = 998}, fmta([[\subsection{<>}]], i(1))),
  aus({trig = '===S', priority = 999}, fmta([[\subsubsection{<>}]], i(1))),
  aus({trig = '=p', priority = 999}, fmta([[\paragraph{<>}]], i(1))),
  aus('-m', fmta([[\(<>\)]], i(1))),
  aus('-M', fmta([=[\[<>\]]=], i(1))),
  aus('=bb', fmta([[\textbf{<>}]], i(1))),
  aus('=ii', fmta([[\textit{<>}]], i(1))),
  aus('=sc', fmta([[\textsc{<>}]], i(1))),
  aus('=sf', fmta([[\textsf{<>}]], i(1))),
  aus('=ee', fmta([[\emph{<>}]], i(1))),
  aus('xmm', fmta([[\(<>\)]], d(1, get_vis))),
  aus('xMM', fmta([=[\[<>\]]=], d(1, get_vis))),
  aus('xbb', fmta([[\textbf{<>}]], d(1, get_vis))),
  aus('xii', fmta([[\textit{<>}]], d(1, get_vis))),
  aus('xsc', fmta([[\textsc{<>}]], d(1, get_vis))),
  aus('xsf', fmta([[\textsf{<>}]], d(1, get_vis))),
  aus('xee', fmta([[\emph{<>}]], d(1, get_vis))),
  aus('=SIG', fmta([[\vfill\hfill\oldpilcrowfive\LaTeX % <>\usepackage{fourier-orns}]], i(0))),
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
  ['F'] = 'Phi',
  ['vf'] = 'varphi',
  ['c'] = 'chi',
  ['y'] = 'psi',
  ['Y'] = 'Psi',
  ['o'] = 'omega',
  ['O'] = 'Omega',
}

local auto_expand = {
  ['a11y'] = 'accessibility',
  ['Dept'] = 'Department',
  ['dept'] = 'department',
  ['envt'] = 'environment',
  ['entmt'] = 'entertainment',
  ['govt'] = 'government',
  ['g11n'] = 'globalization',
  ['indep'] = 'independent',
  ['intl'] = 'international',
  ['i10n'] = 'integration',
  ['i18n'] = 'internationalization',
  ['lang'] = 'language',
  ['natl'] = 'national',
  ['thf'] = 'thermodynamically favorable',
  ['Thru'] = 'Through',
  ['thru'] = 'through',
  ['vvf'] = 'vector-valued function',
  ['w/'] = 'With',
  ['w/'] = 'with',
  ['wrt'] = 'with respect to',
}

local auto_greek_snippets = {}
for k, v in pairs(auto_greek) do 
  table.insert( auto_greek_snippets, tg_aus( { trig = ';' .. k, }, fmta([[{\text<>}]], {v}) ) )
end
vim.list_extend(M, auto_greek_snippets)

local auto_expand_snippets = {}
for k, v in pairs(auto_expand) do 
  table.insert( auto_expand_snippets, aus( { trig = k, trigEngine = 'plain' }, fmta('<>', {v}) ) )
end
vim.list_extend(M, auto_expand_snippets)
return M
