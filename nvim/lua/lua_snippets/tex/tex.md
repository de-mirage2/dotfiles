# document.lua
## environments
`=al` - `align` environment (amsmath)
`*al` - `align*` environment (amsmath)
`=eq` - `equation` environment
`*eq` - `equation*` environment
`=ga` - `gather` environment (amsmath)
`*ga` - `gather*` environment (amsmath)
`=mu` - `multiline` environment (amsmath)
`*mu` - `multiline*` environment (amsmath)
`=it` - `itemize` environment
`=tp` - centered `tikzpicture` environment with [] arguments (tikz)
`=tb` - centered `tabular` environment with {} arguments
`=nv` - general environment
## organization
`=S` - `\section{}`
`==S` - `\subsection{}`
`===S` - `\subsubsection{}`
## math
`,m` - inline math - `\(\)`
(visual) `tmm` - visual inline math
`,M` - display math - `\[\]`
(visual) `tMM` - visual display math
## text styling
`=bb` - boldface text - `\textbf{}`
(visual) `xbb` - visual boldface text
`=ee` - emphasized text - `\emph{}`
(visual) `xee` - visual emphasized text
`=ii` - italicized text - `\textit{}`
(visual) `xii` - visual italicized text
`=sc` - small caps text - `\textsc{}`
(visual) `xsc` - visual small caps text
`=sf` - sans serif text - `\textsf{}`
(visual) `xsf` - visual sans serif text
## misc.
`=sig` - signature, automatically inserted in the bottom righthand corner (fourier-orns)
## contractions, abbreviations, and shorthands
| shorthand | expanded | 
| :--- | :--- |
| a11y | accessibility |
| dept | department |
| envt | environment |
| entmt | entertainment |
| govt | government |
| g11n | globalization |
| indep | independent |
| intl | international |
| i10n | integration |
| i18n | internationalization |
| lang | language |
| natl | national |
| thru | through |
| w/ | with |
| wrt | with respect to |
## greek (textgreek required)
| shorthand | expanded |
| :--- | :--- |
| `;a` | alpha |
| `;b` | beta |
| `;g` | gamma |
| `;G` | Gamma |
| `;d` | delta |
| `;D` | Delta |
| `;ep` | epsilon |
| `;ve` | varepsilon |
| `;z` | zeta |
| `;et` | eta |
| `;h` | theta |
| `;H` | Theta |
| `;vh` | vartheta |
| `;i` | iota |
| `;k` | kappa |
| `;l` | lambda |
| `;L` | Lambda |
| `;m` | mu |
| `;n` | nu |
| `;x` | xi |
| `;X` | Xi |
| `;p` | pi |
| `;P` | Pi |
| `;r` | rho |
| `;s` | sigma |
| `;S` | Sigma |
| `;t` | tau |
| `;u` | upsilon |
| `;U` | Upsilon |
| `;f` | phi |
| `;F` | Phi |
| `;vf` | varphi |
| `;c` | chi |
| `;y` | psi |
| `;Y` | Psi |
| `;o` | omega |
| `;O` | Omega |

#math.lua
## superscript exponents
`,e`, `eE` - euler's exponent, `e^{}` [1]
`,T`, `tT`, `TT`, - transpose, `^{\mathsf{T}}`
`,I`, `iI`, `inV` - inverse, `^{-1}`
`,c` - complement, `^{\complement}` (amsmath)
## derivatives
### regular
`DD` - derivative as a fraction, dy/dx [2]
`dD` - derivative as a function, d/dx [1]
### partial
`PP` - partial derivative as a fraction, py/px [2]
`pP` - partial derivative as a function, p/px [1]
## integrals
Insertion nodes are ordered as 1) differential 2) bounds, first lower to upper if paired then right to left 4) function
### regular
`,i` - regular indefinite integral [4]
`int` - regular definite integral [4]
`inT` - regular definite integral (over a set) [3]
`InT` - regular definite integral (underset \limits) [3]
`i2nt` - double indefinite integral [2] (amsmath)
`i2nT` - double definite integral (over a set) [3] (amsmath)
`I2nT` - double definite integral (underset \limits) [3] (amsmath)
`i2NT` - double definite integral (over two sets of bounds) [6] (amsmath)
`i3nt` - triple indefinite integral [2] (amsmath)
`i3nT` - triple definite integral (over a set) [3] (amsmath)
`I3nT` - triple definite integral (underset \limits) [3] (amsmath)
`i3NT` - triple definite integral (over three sets of bounds) [8] (amsmath)
### contour
`ont` - regular definite contour integral [3]
`onT` - regular indefinite contour integral [2]
## fractions/binomial
`ff` - close-close fraction, `\frac{}{}` [2]
`Ff` - close-open fraction, `\frac{}` [2]
`fF` - close-open fraction, `\frac{}` [1]
`FF` - open-open fraction, `\frac`
`nCr` - binomial, `\binom{}{}` [2]
## function
`Surj` - surjective function declaration, `f : domain to codomain ; input maps to expression` [5]
`Suj` - surjective function declaration, `f : domain to codomain` [3]
## limit [3]
`lmi` - limit infimum, `\liminf_{\to}\left(\right)`
`lms` - limit supremum, `\limsup_{\to}\left(\right)`
`,l`, `lmt` - regular limit, `\lim_{\to}\left(\right)`
`,L` - limits, `\limits_{}^{}` [2]
## argmax/min [2]
`amax` - argument of the maxima, `\argmax_{}{}`
`amin` - argument of the minima, `\argmin_{}{}`
## math fonts [1]
`mtb` - boldfaced, `\mathbf{}`
`mti` - italicized, `\mathit{}`
`mtr` - roman, `\mathrm{}`
`mtt` - typewriter, `\mathtt{}`
`mts` - sans serif, `\mathsf{}`
### capital only
`mtB` - blackboard bold, `\mathbb{}`
`mtC` - calligraphic, `\mathcal{}`
`mtF` - fraktur, `\mathfrak{}`
## left-right delimiters [1]
`lra`, `lr|` - (a)bsolute value / single bars: |f(x)|
`lrb`, `lr[]` - square (b)rackets: [f(x)]
`lrc`, `lr{}` - (c)urly brackets: {f(x)}
`lre`, `lr.` - (e)valuation: f(x)|x=0
`lrn`, `lrm` - (n)orm / (m)agnitude: ||f(x)||
`lrp`, `lr()` - (p)arentheses: (f(x))
`lrv`, `lr<`, `lr>` - (v)ector angle brackets: <x,y,z>
## taylor and maclaurin series
`tayl` - taylor series definition [2]
`macl` - maclaurin series definition [1]
### common series [1]
`macexp` - maclaurin series expansion of exp(x)
`macsin` - maclaurin series expansion of sin(x)
`maccos` - maclaurin series expansion of cos(x)
`macatan` - maclaurin series expansion of arctan(x)
`macsnh` - maclaurin series expansion of sinh(x)
`maccsn` - maclaurin series expansion of sin(x)
`macatnh` - maclaurin series expansion of arctanh(x)
`macln` - maclaurin series expansion of ln(1+x)
## dot addition [1]
`dot` - dot derivative
`ddot` - double dot derivative
`dddot` - triple dot derivative
`ddddot` - quadruple dot derivative
## log-like + {} [1] - convert to command and append {}
`Pr`, `Im`, `Re`;
`arG` -> `\arg`
`deT` -> `\det`
`diM` -> `\dim`
`exP` -> `\exp`
`keR` -> `\ker`
`miN` -> `\min`
`maX` -> `\max`
`gcD` -> `\gcd`
### log
`lG` -> `\lg`
`lN` -> `\ln`
`loG` -> `\log`
### trig
`siN` -> `\sin`
`snH` -> `\sinh`
`asin` -> `\arcsin`
`coS` -> `\cos`
`csH` -> `\cosh`
`acos` -> `\arccos`
`taN` -> `\tan`
`tnH` -> `\tanh`
`atan` -> `\arctan`
`seC` -> `\sec`
`csC` -> `\csc`
`coT` -> `\cot`
`ctH` -> `\coth`
## big autocommand + () [1] - convert to command, add limits, and append lrp
`sum`, `prod`, `coprod`, `bigcap`, `bigcup`
## autocommand + {} [1] - convert to command and append {}
`vec`, `bar`, `hat`, `tilde`, `sqrt`
## autocommand
`aleph`, `perp`
## differential notation
`,d` - differential notation, `\mathrm{d}`
`,p` - partial differential notation (∂), `\partial`
`VD` - gradient, `\nabla`
## letter-like
`lll` - alternative to l, `\ell`
`hh` - planck constant, `\hbar`
`II` - i with no brim, `\imath`
`JJ` - j with no brim, `\jmath`
`ii` - unit vector in the x-direction, `\hat{\imath}`
`jj` - unit vector in the y-direction, `\hat{\jmath}`
`kk` - unit vector in the z-direction, `\hat{k}`
`ooo` - infinity, `\infty`
## plus/minus
`+-` - plus or minus (±), `\pm`
`-+` - minus or plus (∓), `\mp`
## filter notation
`**` - asterisk (﹡), `\ast`
`XX` - cross correlation (٭), `\star`
## multiplication
`..` - dot product (﹡), `\cdot`
`xx` - cross product (٭), `\times`
## dots
`.d` - lower dots (...), `\ldots`
`.c` - center dots (...), `\cdots`
## equivalency and relations
`,=` - modularly congruent to (≡), `\equiv`
`~=` - approximately equal to (≈), `\approx`
`~~` - similar to (~), `\sim`
`!=` - not equal to (≠), `\neq`
`>=` - greater than or equal to (≥), `\geq`
`<=` - less than or equal to (≤), `\leq`
## logic & set theory
`!!` - negation, `\neg`
`EE` - there exists, `\exists`
`FA` - for all, `\forall`
`ee` - is not an element of, `\in`
`!e` - is an element of, `\notin`
`O/` - empty set, `\emptyset`
`cc` - is a subset of, `\subset`
`qq` - is a supset of, `\supset`
`cq` - is a subset of or equal to, `\subseteq`
`qc` - is a supset of or equal to, `\supseteq`
`VV` - logical or, `\lor`
`MM` - logical and, `\land`
`uu` - union, `\cup`
`nn` - intersection, `\cap`
`ssup` - set supremum, `\sup`
`sinf` - set infimum, `\inf` 
`|>` - maps to, `\mapsto`
`|->` - long maps to, `\longmapsto`
`->` - to (right arrow), `\to`
`<-` - gets (left arrow), `\gets`
`=>` - implies (double stroke right arrow), `\implies`
`<=` - implied by (double stroke left arrow), `\impliedby`
`iff` - if and only if (double stroke bidirectional arrow), `\iff`
`<H>` - equilibrium (bidirectional harpoons), `\rightleftharpoons`
`::` - standard colon, `\colon`
## ams logic & set theory
`CC` - set of all complex numbers, `\mathbb{C}`
`HH` - algebra of quaternions, `\mathbb{H}`
`NN` - set of all natural numbers, `\mathbb{N}`
`QQ` - set of all irrational numbers, `\mathbb{Q}`
`RR` - set of all real numbers, `\mathbb{R}`
`ZZ` - set of all integers, `\mathbb{Z}`
`!E` - there does not exist, `\nexists`
`thfr` - therefore, `\therefore`
`becs` - because, `\because`
`:=` - defined to equal, `\coloneq`
`qed` - quod erat demonstrandum, `\blacksquare`
## greek
| shorthand | expanded |
| :--- | :--- |
| `;a` | alpha |
| `;b` | beta |
| `;g` | gamma |
| `;G` | Gamma |
| `;d` | delta |
| `;D` | Delta |
| `;ep` | epsilon |
| `;ve` | varepsilon |
| `;z` | zeta |
| `;et` | eta |
| `;h` | theta |
| `;H` | Theta |
| `;vh` | vartheta |
| `;i` | iota |
| `;k` | kappa |
| `;l` | lambda |
| `;L` | Lambda |
| `;m` | mu |
| `;n` | nu |
| `;x` | xi |
| `;X` | Xi |
| `;p` | pi |
| `;P` | Pi |
| `;r` | rho |
| `;s` | sigma |
| `;S` | Sigma |
| `;t` | tau |
| `;u` | upsilon |
| `;U` | Upsilon |
| `;f` | phi |
| `;F` | Phi |
| `;vf` | varphi |
| `;c` | chi |
| `;y` | psi |
| `;Y` | Psi |
| `;o` | omega |
| `;O` | Omega |
