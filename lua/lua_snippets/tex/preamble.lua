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
local aus = ls.extend_decorator.apply(ls.snippet, {show_condition = in_pre, condition = in_pre, snippetType = 'autosnippet', wordTrig = false, trigEngine = 'pattern'})

-- it's texy time --

M = {
  --s({trig = "testPreamble"}, t("preamble.lua LOADED")),

  aus({trig = ";up"}, fmta([[\usepackage{<>}]], i(1))),
  aus({trig = ";nc"}, fmta([[\newcommand{<>}<>{<>}]], {i(1),i(2),i(3)})),
  aus({trig = ";doc"}, fmta(
    [[
    \begin{document}
      <>
    \end{document}
    ]], i(0)
  )),
  s({trig = "TemplatePhysics"},
    fmta(
      [[ 
      \documentclass[11pt,a4paper]{article}
      \usepackage[a4paper]{geometry}
      \usepackage{mathtools,booktabs,enumitem,siunitx,graphicx,listings,color}
      \usepackage{fancyhdr,fourier-orns}\renewcommand{\headrulewidth}{0pt}\setlength{\headheight}{14.5pt}
      \usepackage{tikz}
      \usetikzlibrary{arrows.meta,quotes,calc,decorations}

      
      \definecolor{dkgreen}{rgb}{0,0.3,0}
      \definecolor{gray}{rgb}{0.5,0.5,0.5}
      \definecolor{mauve}{rgb}{0.58,0,0.82}

      \lstset{frame=tb,
        language=R,
        aboveskip=3mm,
        belowskip=3mm,
        showstringspaces=false,
        columns=flexible,
        basicstyle={\scriptsize\ttfamily},
        numbers=none,
        numberstyle=\tiny\color{gray},
        keywordstyle=\color{blue},
        commentstyle=\color{dkgreen},
        stringstyle=\color{mauve},
        breaklines=true,
        breakatwhitespace=true,
        tabsize=3
      }

      \newcommand{\disptwo}[2]{\makebox[8cm]{#1\\dotfill}#2}
      \newcommand{\stepexpl}[1]{\parbox[t]{5cm}{\raggedright #1}}
      \newcommand{\FU}{\\si{\meter\per\square\second}} % final units

      \title{<>}
      \author{Miraj Parikh\thanks{in collaboration with lab partners <>}}
      \date{\today}

      \begin{document}
      \fancyhf{}\pagestyle{fancy}\fancyhead[R]{Parikh \\thepage}
      \maketitle\thispagestyle{fancy}\tableofcontents
      <>
      \abstract{Abstracts are a summary of the experiment as a whole and should familiarize the reader with the purpose of the research. Abstracts will always be written last, even though they are the first paragraph of a lab report. Briefly include methods and results.}

      \section{Materials}
      \begin{itemize}
        \item \disptwo{Meterstick}{Measure projectile initial height}
        \item \disptwo{object}{reason}
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
      \begin{center}\begin{tabular}{lccccl}\toprule 
      &\\multicolumn{4}{c}{Trial Data (units)}& \\
      \cmidrule(lr){2-5}
      $x$ (units) & 1 & 2 & 3 & avg. \\
      0.25        & 4.1 & 3.2 & 2.7 & 1.0 \\
      \bottomrule\end{spreadtab}\end{center}
      Constants: 
      \begin{itemize}
        \item \disptwo{\(g=9.81\si{\meter\per\square\second}\)}{Standard gravity of Earth}
      \end{itemize}

      \section{Derivations}
      \begin{align}
        \vec{F}_{net} &=m\vec{a} \\
                      &=\frac24 && \text{im yapping} \\
                      &=\frac12 && \stepExpl{call me sir yaps-a-lot, because i truly am yapping a lot here aren't i?}
      \end{align}
      
      \section{Graphing \& Calculations}
      \begin{center}
        \begin{tabular}{cc}\toprule
          \(d\) (\unit\meter) & \(\overline{t}^2\) (\unit{\square\second}) \\ \midrule
          0.50 & 0.6084\\
          0.75 & 1.0955\\
          1.00 & 1.2844\\
          1.25 & 1.8045\\ \bottomrule
        \end{tabular}
      \end{center}

      % \begin{center}\includegraphics[scale=0.35]{"../R/plot.png"}\end{center}
      \begin{lstlisting}
      ## 
      ## Call:
      ## lm(formula = d ~ t2, data = expdata)
      ##  
      ## Residuals:
      ##         1         2         3         4 
      ##  0.004681 -0.058887  0.069509 -0.015303 
      ## 
      ## Coefficients:
      ##             Estimate Std. Error t value Pr(>|t|)  
      ## (Intercept)  0.10366    0.09717   1.067   0.3978  
      ## t2           0.64375    0.07637   8.429   0.0138 *
      ## ---
      ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
      ## 
      ## Residual standard error: 0.0654 on 2 degrees of freedom
      ## Multiple R-squared:  0.9726, Adjusted R-squared:  0.9589 
      ## F-statistic: 71.05 on 1 and 2 DF,  p-value: 0.01378
      \end{lstlisting}
      Using the R language to calculate and visualize the data:
      \begin{center}\begin{tabular}{cc}\toprule
        \(R^2\) & Equation \\\midrule
        0.9589 & \(d \sim 0.64375t^2 + 0.10366\) \\
      \bottomrule\end{tabular}\end{center}
      
      With a slope of 0.64375 indicated by the linear regression model, the experimental value of \(\theta \) may now be evaluated:
      \begin{align}
        m &= 0.64375 \\
        \frac{g}{2}\sin \theta &= \\
        \sin \theta &= \frac{2}{g}\cdot 0.64375 \\
        \theta &= \arcsin\left(\frac{2}{g}\cdot 0.64375\right) \\
               &= \qty{7.54}{\degree}
      \end{align}

      The experimental value of \(\theta\) evaluates to \qty{7.54}{\degree}


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
  s({trig = "TemplateChemistry"},
    fmta(
      [[
      \documentclass[a3paper]{article}
      \usepackage[margin=2.5cm]{geometry}
      \usepackage{amssymb,amsthm,booktabs,fourier-orns,enumitem}
      \usepackage[version=4]{mhchem}
      \usepackage{siunitx}

      \title{<> Lab}
      \author{Miraj Parikh\thanks{In collaboration with: <>}}
      \date{\today}

      \theoremstyle{definition}
      \newtheorem{prob}{Problem}
      \newcommand{\soln}{{\it{Solution}}:\quad}
      \DeclareSIUnit{\Molar}{\textsc{m}}

      \begin{document}
        \maketitle
        \begin{prob} <> \end{prob}
        \soln Solution
      
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
