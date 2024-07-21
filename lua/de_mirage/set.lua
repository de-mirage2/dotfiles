local op = vim.opt
local bo = vim.bo
local o = vim.o

op.shiftwidth = 2
op.expandtab = true
o.softtabstop = 2
op.tabstop = 2

op.smartindent = true

op.nu = true 

op.updatetime = 50

op.colorcolumn = "80"

vim.g.mapleader = " "

o.mouse = "a"

op.whichwrap:append {
  ['<'] = true,
  ['>'] = true,
  ['['] = true,
  [']'] = true,
  h = true,
  l = true,
}

