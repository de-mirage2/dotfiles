-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar() os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Setup lazy.nvim
require('lazy').setup({
  -- General LSP / Snippets / Autocompletion
  { 
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
  },
  {
    'L3MON4D3/LuaSnip',
    version = 'v2.*',
    config = function()
      require('luasnip').config.set_config({
        enable_autosnippets = true,
        history = true,
        region_check_events = "InsertEnter",
        delete_check_events = "TextChanged,InsertLeave",
        store_selection_keys="<Tab>",
        -- cut_selection_keys = '<Tab>',
      })
      require('luasnip.loaders.from_lua').lazy_load({ paths = '~/.config/nvim/snippets' })
    end
  },
  {
    'saghen/blink.cmp',
    lazy = false,  -- lazy loading handled internally
    dependencies = { 'L3MON4D3/LuaSnip', version = 'v2.*' },
    version = '1.*',
    opts = {
      keymap = {
        
        ['<A-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
        ['<A-k>'] = { 'hide', 'fallback' },
        ['<CR>'] = { 'accept', 'fallback' },

        ['<A-o>'] = { 'snippet_forward', 'fallback' },
        ['<A-i>'] = { 'snippet_backward', 'fallback' },

        ['<Up>'] = { 'select_prev', 'fallback' },
        ['<Down>'] = { 'select_next', 'fallback' },
        ['<A-p>'] = { 'select_prev', 'fallback_to_mappings' },
        ['<A-n>'] = { 'select_next', 'fallback_to_mappings' },

        ['<A-b>'] = { 'scroll_documentation_up', 'fallback' },
        ['<A-f>'] = { 'scroll_documentation_down', 'fallback' },

        ['<A-s>'] = { 'show_signature', 'hide_signature', 'fallback' }, 
      }, -- causes issues with tabbing
      snippets = { preset = 'luasnip' },
      sources = { default = { 'lsp', 'path', 'snippets', }, },
      -- completion = {menu = {auto_show = false}}, -- fixed with 'hidden = true' in snippets
    }, 
  },
  { 'j-hui/fidget.nvim' },
  {
    "willothy/flatten.nvim",
    config = true,
    -- or pass configuration with
    -- opts = {  }
    -- Ensure that it runs first to minimize delay when opening file from terminal
    lazy = false,
    priority = 1067,
  },
  { 'farmergreg/vim-lastplace', lazy = false },
  -- Filetree
  { 'stevearc/oil.nvim' , config = function() require("oil").setup() end, },
  -- Git
  { 'tpope/vim-fugitive' },
  -- Misc.
  { 'mbbill/undotree' },
  -- R Utilities
  { 'R-nvim/R.nvim', lazy = false },
  -- LaTeX/TeX Utilities
  { 'lervag/vimtex', lazy = false },
  -- Competitive Programming
  { 'xeluxee/competitest.nvim', dependencies = 'MunifTanjim/nui.nvim', config = function() require('competitest').setup() end, },
  -- Theme/UI
  { 'folke/tokyonight.nvim', lazy = false, opts = {style = "moon"}, },
  { 'nvim-lualine/lualine.nvim', dependencies = {'nvim-tree/nvim-web-devicons'} },
  -- Fuzzy Finder
  {
    'ibhagwan/fzf-lua',
    -- optional for icon support
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = {}
  },
  -- Eyeliner
  {
    'jinh0/eyeliner.nvim',
  },
  -- Zettlekasten
  {
  'zk-org/zk-nvim',
  },
}, { rocks = { enabled = false } })
