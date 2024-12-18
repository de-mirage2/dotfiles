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
      [==[ 
      \documentclass{article}
      \usepackage[a4paper,margin=2cm]{geometry}
      \usepackage{mathtools,booktabs,enumitem,siunitx,graphicx,listings,color,esvect}
      \usepackage{fancyhdr,fourier-orns}\renewcommand{\headrulewidth}{0pt}\setlength{\headheight}{14.5pt}
      \usepackage{tikz}
      \usepackage[nodayofweek]{datetime}
      \usetikzlibrary{arrows.meta,quotes,calc,decorations,angles,patterns.meta}
 
      \newcommand{\myequation}{\begin{equation}}
      \newcommand{\myendequation}{\end{equation}}
      \let\[\myequation
      \let\]\myendequation

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

      \newcommand{\stepexpl}[1]{\parbox[t]{5cm}{\raggedright #1}}

      \DeclareSIUnit{\FU}{\kilogram\square\meter} % final units
      \newcommand{\FV}{g_{\mathrm{earth}}} % final variable

      \title{<>}
      \author{
        <>
        \and
        Miraj Parikh
        \and
        <>
        \and
        <>
      }
      \date{\today}

      \begin{document}
      \fancyhf{}\pagestyle{fancy}\fancyhead[R]{<> \thepage}
      \maketitle\thispagestyle{fancy}\tableofcontents
      <>
      \abstract{The findings of a lab conducted to calculate the magnitude of the gravitational field of earth \(\FV\) acting on a falling sphere are presented. Through the use of differential force equations to analyze the behavior of the sphere-earth system, the magnitude of the gravitational field of earth was derived to equal \qty{9999}{\FU}, which relative to the true value of \qty{9.80665}{\FU} yielded an error of \qty{9931}{\percent}.}

      \section{Materials}
      \begin{itemize}
        \item Meterstick \dotfill Measure projectile initial height
        \item Object \dotfill reason
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
      &\multicolumn{4}{c}{Trial Data (\(t\)) (\unit{\second})}& \\
      \cmidrule(lr){2-5}
      \(x\) (\unit{\meter}) & 1 & 2 & 3 & avg. \\\midrule
      0.25        & 4.1 & 3.2 & 2.7 & 1.0 \\
      \bottomrule\end{tabular}\end{center}
      Constants: 
      \begin{itemize}
        \item \(g=\qty{9.81}{\meter\per\square\second}\) \dotfill Standard gravity of Earth
      \end{itemize}

      \section{Derivations}
      %\begin{tikzpicture}[font=\footnotesize] % model goes here
      %\end{tikzpicture}
      \begin{align}
        \vv*{F}{net} &=m\vv{a} \\
                      &=\frac24 && \text{im yapping} \\
                      &=\frac12 && \stepexpl{this is a really long explanation that spans a few lines blah blah blah blah}
      \end{align}
      
      \section{Graphing \& Calculations}
      \begin{center}
        \begin{tabular}{cc}\toprule
          \(d\) (\unit\meter) & \(\overline{t}^2\) (\unit{\square\second}) \\\midrule
          0.50 & 0.6084\\
          0.75 & 1.0955\\
          1.00 & 1.2844\\
          1.25 & 1.8045\\
        \bottomrule\end{tabular}
      \end{center}

      % \begin{center}\includegraphics[scale=0.35]{"../R/plot.png"}\end{center}
      \begin{lstlisting}
      ## R Output goes here 
      \end{lstlisting}
      Using the R language to calculate and visualize the data:
      \begin{center}\begin{tabular}{cc}\toprule
        \(R^2\) & Linear Regression Model\\\midrule
        0.9589 & \(d \sim 0.64375t^2 + 0.10366\) \\
      \bottomrule\end{tabular}\end{center}
      
      With a slope of \(0.64375\) indicated by the linear regression model, the experimental value of \(\theta \) may now be evaluated:
      \begin{align*}
        m &= 0.64375 \\
        \frac{g}{2}\sin \theta &= \\
        \sin \theta &= \frac{2}{g}\cdot 0.64375 \\
        \theta &= \arcsin\left(\frac{2}{g}\cdot 0.64375\right) \\
               &= \qty{7.54}{\FU}
      \end{align}

      The experimental value of \(\FV\) evaluates to \qty{7.54}{\FU}

      \section{Analysis}
      The percent error for our experiment is calculated as follows: \[\left\vert\frac{5192.83\FU-9.81\FU}{9.81\FU}\right\vert\cdot 100\% \approx 528.34\%\]
      we fucked up bigtime 

      \section{Conclusion}
      i love latex 

      \vfill\hfill\oldpilcrowfive\LaTeX
      \end{document}
      ]==], { i(1, "Lab Title"), i(3, "David Halliday"), i(4, "Kenneth Krane"), i(5, "Robert Resnick"), i(2, "Halliday Krane Parikh Resnick"), i(0) }
    )
  ),
  s({trig = "TemplateChemistry"},
    fmta(
      [[
      \documentclass{article}
      \usepackage[a3paper,margin=2.5cm]{geometry}
      \usepackage{amssymb,amsthm,booktabs,fourier-orns,enumitem}
      \usepackage[version=4]{mhchem}
      \usepackage{siunitx}

      \title{<> Lab}
      \author{
        <>
        \and
        Miraj Parikh
      }
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
  s({trig = "TemplatePROOF"},
    fmta(
      [[
      \documentclass{article}
      \usepackage[a4paper,margin=2cm]{geometry}
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
