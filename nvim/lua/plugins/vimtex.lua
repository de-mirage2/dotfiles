vim.g.vimtex_view_method = 'zathura'
vim.g.tex_flavor = 'latex'
vim.g.vimtex_compiler_latexmk = {
  executable = 'latexmk',
  options = {
    '-shell-escape',
    '-file-line-error',
    '-synctex=1',
    '-interaction=nonstopmode',
  },
}


-- vim.g.tex_conceal = 'abdmg' -- 
-- vim.o.conceallevel = 2
