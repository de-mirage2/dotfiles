local op = vim.opt
local bo = vim.bo
local o = vim.o

op.shiftwidth = 2
op.expandtab = true
o.softtabstop = 2
op.tabstop = 2

o.textwidth = 0
o.wrapmargin = 0

op.smartindent = true

op.nu = true 

op.updatetime = 50

op.colorcolumn = "160"

vim.g.mapleader = " "

op.title = true
op.titlelen = 0
op.titlestring = "nvim"

o.mouse = "a"

op.whichwrap:append {
  ['<'] = true,
  ['>'] = true,
  ['['] = true,
  [']'] = true,
  h = true,
  l = true,
}
