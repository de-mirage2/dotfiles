local ls = require("luasnip")
-- local s = ls.snippet
local sn = ls.snippet_node
local isn = ls.indent_snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
-- local d = ls.dynamic_node
-- local r = ls.restore_node
-- local events = require("luasnip.util.events")
-- local ai = require("luasnip.nodes.absolute_indexer")
-- local extras = require("luasnip.extras")
-- local l = extras.lambda
-- local rep = extras.rep
-- local p = extras.partial
-- local m = extras.match
-- local n = extras.nonempty
-- local dl = extras.dynamic_lambda
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local conds = require("luasnip.extras.expand_conditions")
local postfix = require("luasnip.extras.postfix").postfix
local types = require("luasnip.util.types")
local parse = require("luasnip.util.parser").parse_snippet
local ms = ls.multi_snippet
local k = require("luasnip.nodes.key_indexer").new_key

function in_pre() 
  local is_in_doc = vim.fn["vimtex#env#is_inside"]("document")
  return (is_in_doc[1] == 0 or is_in_doc[2] == 0)
end

local s = ls.extend_decorator.apply(ls.snippet, {show_condition = in_pre, condition = in_pre})

-- it's texy time --

M = {
  s({trig = "testPreamble"}, t("preamble.lua LOADED")),
  s({trig = ";doc", snippetType = 'autosnippet'}, fmta(
    [[
    \begin{document}
      <>
    \end{document}
    ]], {i(0)}
  )),
  s({trig = "TemplatePhysics", show_condition = in_pre, condition = in_pre},
    fmta(
      [[ 
      \documentclass[12pt,a4paper]{article}
      \usepackage[a4paper,margin=2cm]{geometry}
      \usepackage[mathtools,booktabs,enumitem,siunitx,spreadtab,graphicx]
      \usepackage{fancyhdr,fourier-orns}\renewcommand{\headrulewidth}{0pt}\setlength{\headheight}{14.5pt}
      \usepackage{tikz}
      \usetikzlibrary{arrows.meta,calc,decorations}
      \usepackage{pgfplots}
      \usepackage{pgfplotstable}

      \newcommand{\disptwo}[2]{\makebox[8cm]{#1\\dotfill}#2}
      \newcommand{\stepexpl}[1]{\parbox[t]{5cm}{\raggedright #1}}
      \newcommand{\FU}{\\si{\meter\per\square\second}} % final units

      \title{<>}
      \author{Miraj Parikh\thanks{in collaboration with lab partners <>}}
      \date{\today}

      \STautoround{3}
      \begin{document}
      \fancyhf{}\pagestyle{fancy}\fancyhead[R]{Parikh \\thepage}
      \maketitle\thispagestyle{fancy}\tableofcontents
      <>
      \abstract{Abstracts are a summary of the experiment as a whole and should familiarize the reader with the purpose of the research. Abstracts will always be written last, even though they are the first paragraph of a lab report. Briefly include methods and results.}

      \section{Materials}
      \begin{itemize}
        \item \dispTwo{Meterstick}{Measure projectile initial height}
        \item \dispTwo{}{}
      \end{itemize}

      \section{Procedure}
      \begin{enumerate}[label=(\Roman*)]
        \item Arrange the... 
        \item Repeat the following 3 times: \begin{enumerate}[label=(\roman*)]
          \item Hold the... 
          \item While recording, release... \end{enumerate}
      \end{enumerate}

      \section{Data}
      The raw data collected by conducting the prior procedure, along with constants used in calculations: 
      \begin{center}\begin{spreadtab}{{tabular}{lccccl}}\toprule 
      &@\\multicolumn{4}{c}{Trial Data}& \\
      \cmidrule(lr){2-5}
      @ $x$ (units) & @ 1 & @ 2 & @ 3 & @ avg. \\
      @ 0.25        & 4.1 & 3.2 & 2.7 & :={sum(b2:[-1,0])/3} \\
      \bottomrule\end{spreadtab}\end{center}
      Constants: 
      \begin{itemize}
        \item \disptwo{$g=9.81\si{\meter\per\square\second}$}{Standard gravity of Earth}
      \end{itemize}

      \section{Calculations}
      \begin{align}
        \vec{F}_{net} &=m\vec{a} \\
                      &=\frac24 && \text{im yapping} \\
                      &=\frac12 && \stepExpl{call me sir yaps-a-lot, because i truly am yapping a lot here aren't i?}
      \end{align}

      \section{Analysis}
      The percent error for our experiment is calculated as follows: \[\left\vert\frac{5192.83\FU-9.81\FU}{9.81\FU}\right\vert\cdot 100\% \approx 528.34\%\]
      we fucked up bigtime 

      \section{Conclusion}
      i love latex 

      \vfill\hfill\oldpilcrowfive\LaTeX
      \end{document}
      ]], { i(1), i(2), i(0) }
    )
  ),
  s({trig = "TemplateJEE"},
    fmta(
      [[
      \documentclass[12pt,a4paper,notitlepage]{minimal}
      \usepackage{mathtools,amssymb,amsfonts,amsthm,empheq,mdframed,booktabs}
      \usepackage{tikz}
      \usetikzlibrary{arrows.meta,calc,decorations,shapes.geometric}
      %\usepackage{pgfplots}
      \begin{document}
        <>
      \end{document}
      ]], { i(0) }
    )
  ),
  s({trig = "TemplateLinearAlgebra"},
    fmta(
      [[
      \documentclass[12pt,a4paper]{minimal}
      \usepackage{mathtools,amssymb,amsfonts,amsthm,empheq,mdframed,booktabs,fourier-orns}
      \title{Linear Algebra - <>}
      \author{Miraj M. Parikh}
      \date{\today}
      \begin{document}
        \maketitle
        <>
      \vfill\hfill\oldpilcrowfive\LaTeX
      \end{document}
      ]], { i(1), i(0) }
    )
  ),
  --[=[s({trig="tablelab"},
    t(
      [[
      \begin{center}\begin{spreadtab}{{tabular}{lccccl}}
        \toprule
      &@\multicolumn{4}{c}{Trial Data}& \\
        \cmidrule(lr){2-5}
      @ $x$ (units) & @ 1 & @ 2 & @ 3 & @ avg. \\
        \midrule
      @ 0.25        & 4.1 & 3.2 & :={sum(b2:[-1,0])/3} \\
        \bottomrule\\
      \end{spreadtab}\end{center}
      ]]
    )
  ),
  ]=]
}

return M
