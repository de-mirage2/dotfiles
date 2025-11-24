-- vim.g.vimtex_view_method = "zathura_simple"
vim.g.vimtex_view_method = "general"
vim.g.vimtex_view_general_viewer = "zathura"
vim.g.vimtex_compiler_latexmk = {
  options = {
    '-shell-escape',
    '-verbose',
    '-file-line-error',
    '-synctex=1',
    '-interaction=nonstopmode',
  },
}
