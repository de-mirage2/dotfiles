local map = vim.keymap.set

-- swapping k and e; adding swap-line function
map({"n","v","t",}, "k", "e", {remap=false})
map({"n","v","t"}, "e", "k", {remap=false})
-- map({"v",   }, "K", "E", {remap=false}) -- unneeded
-- map({"n",   }, "E", "", {remap=false}) -- unneeded
-- map("v", "K", "E") -- error

-- swap lines in visual
map("v", "E", ":m '<-2<CR>gv=gv")
map("v", "J", ":m '>+1<CR>gv=gv")

-- swap ; and :
map("n", ";", ":", {remap=false})
map("n", ":", ";", {remap=false})

-- oil.nvim
map("n", "<leader>j", "<CMD>Oil<CR>", { desc = "open parent directory" })

-- insert options
map("i", "<C-i>", "<ESC>^i", { desc = "move beginning of line" })
map("i", "<C-a>", "<End>", { desc = "move end of line" })
map("i", "<C-d>", "<C-h>", { desc = "delete character" })
map("i", "<C-h>", "<Left>", { desc = "move left" })
map("i", "<C-l>", "<Right>", { desc = "move right" })
map("i", "<C-j>", "<Down>", { desc = "move down" })
map({"i","t"}, "<C-e>", "<Up>", { desc = "move up" })

-- clear highlights
map("n", "<Esc>", "<cmd>noh<CR>", { desc = "general clear highlights" })

-- search within visual
map('x', '<Leader>/', '<Esc>/\\%V')

-- window transition
map("n", "<C-H>", "<C-w>h", { desc = "switch window left" })
map("n", "<C-L>", "<C-w>l", { desc = "switch window right" })
map("n", "<C-J>", "<C-w>j", { desc = "switch window down" })
map("n", "<C-E>", "<C-w>k", { desc = "switch window up" })

map("n", "<A-h>", "<C-w>H", { desc = "swap window left" })
map("n", "<A-l>", "<C-w>L", { desc = "swap window right" })
map("n", "<A-j>", "<C-w>J", { desc = "swap window down" })
map("n", "<A-e>", "<C-w>K", { desc = "swap window up" })

map("n", "<A-L>", "<C-w><", { desc = "widen pane" })
map("n", "<A-H>", "<C-w>>", { desc = "narrow pane" })
map("n", "<A-J>", "<C-w>+", { desc = "shorten pane" })
map("n", "<A-E>", "<C-w>-", { desc = "heighten pane" })

-- filesave
map("n", "<C-s>", "<cmd>w<CR>", { desc = "file save" })

-- numbering
map("n", "<leader>n", "<cmd>set nu!<CR>", { desc = "toggle line number" })
map("n", "<leader>r", "<cmd>set rnu!<CR>", { desc = "toggle relative number" })

-- clipboard and deletion  (binds that involve ctrl use system clipboard)
map("v", "<C-y>", [["+y]], { desc = "visual copy to system clipboard" })
-- map("n", "<D-y>", [["+y]], { desc = "normal copy to system clipboard - root" })
map("n", "<C-y>", [["+yy]], { desc = "normal copy line to system clipboard" })

map("v", "<C-d>", [["+d]], { desc = "visual cut to system clipboard" })
-- map("n", "<A-d>", [["+d]], { desc = "normal cut to system clipboard - root" })
map("n", "<C-d>", [["+dd]], { desc = "normal cut line to system clipboard" })

map("v", "<C-c>", [["+c]], { desc = "visual change to system clipboard" })
-- map("n", "<A-c>", [["+c]], { desc = "normal change to system clipboard - root" })
map("n", "<C-c>", [["+cc]], { desc = "normal change line to system clipboard" })

-- new pane
map("n", "<leader>h", ":split<CR>", { desc = "new horizontal pane" })
map("n", "<leader>v", ":vsplit<CR>", { desc = "new vertical pane" })
map("n", "<leader>t", ":belowright vsplit | terminal<CR>", { desc = "new vertical terminal" })
map("n", "<leader>T", ":belowright split | terminal<CR>", { desc = "new horizontal terminal" })

-- Comment
map("n", "<leader>/", "gcc", { desc = "comment toggle", remap = true })
map("v", "<leader>/", "gc", { desc = "comment toggle", remap = true })

--[[
map("n", "<leader>fm", function()
  require("conform").format { lsp_fallback = true }
end, { desc = "format files" })

-- global lsp mappings
map("n", "<leader>ds", vim.diagnostic.setloclist, { desc = "lsp diagnostic loclist" })

-- tabufline
map("n", "<leader>b", "<cmd>enew<CR>", { desc = "buffer new" })

-- terminal
map("t", "<C-x>", "<C-\\><C-N>", { desc = "terminal escape terminal mode" })

-- toggleable
map({ "n", "t" }, "<A-v>", function()
  require("nvchad.term").toggle { pos = "vsp", id = "vtoggleTerm" }
end, { desc = "terminal toggleable vertical term" })

map({ "n", "t" }, "<A-h>", function()
  require("nvchad.term").toggle { pos = "sp", id = "htoggleTerm" }
end, { desc = "terminal new horizontal term" })

map({ "n", "t" }, "<A-i>", function()
  require("nvchad.term").toggle { pos = "float", id = "floatTerm" }
end, { desc = "terminal toggle floating term" })

-- whichkey
map("n", "<leader>wK", "<cmd>WhichKey <CR>", { desc = "whichkey all keymaps" })

map("n", "<leader>wk", function()
  vim.cmd("WhichKey " .. vim.fn.input "WhichKey: ")
end, { desc = "whichkey query lookup" })

-- blankline
map("n", "<leader>cc", function()
  local config = { scope = {} }
  config.scope.exclude = { language = {}, node_type = {} }
  config.scope.include = { node_type = {} }
  local node = require("ibl.scope").get(vim.api.nvim_get_current_buf(), config)

  if node then
    local start_row, _, end_row, _ = node:range()
    if start_row ~= end_row then
      vim.api.nvim_win_set_cursor(vim.api.nvim_get_current_win(), { start_row + 1, 0 })
      vim.api.nvim_feedkeys("_", "n", true)
    end
  end
end, { desc = "blankline jump to current context" }) ]]
