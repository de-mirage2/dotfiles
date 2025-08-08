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
        history = false,
        enable_autosnippets = true,
        -- cut_selection_keys = '<Tab>',
      })
      require('luasnip.loaders.from_lua').lazy_load({ paths = '~/.config/nvim/snippets' })
    end
  },
  {
    'saghen/blink.cmp',
    lazy = false,  -- lazy loading handled internally
    dependencies = { 'L3MON4D3/LuaSnip' },
    version = '1.*',
    opts = {
      keymap = { preset = 'super-tab' },
      snippets = { preset = 'luasnip' },
      sources = { default = { 'lsp', 'path', 'snippets', 'buffer' }, },
      -- completion = {menu = {auto_show = false}}, -- fixed with 'hidden = true' in snippets
    }, 
  },
  {
    'neovim/nvim-lspconfig',
    dependencies = { 'saghen/blink.cmp', 'j-hui/fidget.nvim' },

    -- example using `opts` for defining servers
    opts = {
      servers = {
        clangd = {},
        texlab = {},
        jdtls = {},
        rust_analyzer = {},
      },
    },
    config = function(_, opts)
      local lspconfig = require('lspconfig')
      for server, config in pairs(opts.servers) do
        -- passing config.capabilities to blink.cmp merges with the capabilities in your
        -- `opts[server].capabilities, if you've defined it
        config.capabilities = require('blink.cmp').get_lsp_capabilities(config.capabilities)
        lspconfig[server].setup(config)
      end
    end
  },
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
})
