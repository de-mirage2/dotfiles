local lsp = require('lsp-zero')
local cmp = require('cmp')
local ls = require("luasnip")
local cmp_action = require('lsp-zero').cmp_action()

lsp.on_attach(function(client, bufnr)
  -- see :help lsp-zero-keybindings
  lsp.default_keymaps({buffer = bufnr})
  lsp.buffer_autoformat()
end)

lsp.setup()

require('mason').setup({})
require('mason-lspconfig').setup({
  ensure_installed = {"clangd", "pylsp", "jdtls", "ltex"},
  handlers = {
    function(server_name)
      require('lspconfig')[server_name].setup({})
    end,
  },
})

ls.config.set_config({
  history = false,
  enable_autosnippets = true,
})

require("luasnip").log.set_loglevel("debug")
-- require("luasnip.loaders.from_vscode").lazy_load() -- friendly snippets
require("luasnip.loaders.from_lua").lazy_load { paths = "~/.config/nvim/lua/lua_snippets" }


cmp.setup({
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
  sources = {
    {name = 'nvim_lsp'},
    {name = 'luasnip'},
  },
  mapping = cmp.mapping.preset.insert({
    ['<Tab>'] = cmp_action.luasnip_supertab(),
    ['<S-Tab>'] = cmp_action.luasnip_shift_supertab(),
  }),
})
