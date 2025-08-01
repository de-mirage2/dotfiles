local map = vim.keymap.set

map({"n","v"}, "k", "e", {remap=false})
map({"n","v"}, "e", "k", {remap=false})
map("n", "K", "E", {remap=false})
map({"n","v"}, "E", "K", {remap=false})

map("n", ";", ":")
map("n", "<leader>pv", vim.cmd.Ex)

map("v", "K", ":m '<-2<CR>gv=gv")
map("v", "J", ":m '>+1<CR>gv=gv")

map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")

map("i", "<C-i>", "<ESC>^i", { desc = "move beginning of line" })
map("i", "<C-a>", "<End>", { desc = "move end of line" })
map("i", "<C-d>", "<C-h>", { desc = "delete character" })
map("i", "<C-h>", "<Left>", { desc = "move left" })
map("i", "<C-l>", "<Right>", { desc = "move right" })
map("i", "<C-j>", "<Down>", { desc = "move down" })
map("i", "<C-e>", "<Up>", { desc = "move up" })

map("n", "<Esc>", "<cmd>noh<CR>", { desc = "general clear highlights" })

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
map("n", "<leader>rn", "<cmd>set rnu!<CR>", { desc = "toggle relative number" })

-- clipboard and deletion - Binds that involve ctrl use system clipboard
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

-- modify split 

-- nvimtree
map("n", "<C-n>", "<cmd>NvimTreeToggle<CR>", { desc = "nvimtree toggle window" })
map("n", "<leader>k", "<cmd>NvimTreeFocus<CR>", { desc = "nvimtree focus window" })

-- map("n", "<leader>ch", "<cmd>NvCheatsheet<CR>", { desc = "toggle nvcheatsheet" })

--[[
map("n", "<leader>fm", function()
  require("conform").format { lsp_fallback = true }
end, { desc = "format files" })

-- global lsp mappings
map("n", "<leader>ds", vim.diagnostic.setloclist, { desc = "lsp diagnostic loclist" })

-- tabufline
map("n", "<leader>b", "<cmd>enew<CR>", { desc = "buffer new" })

map("n", "<tab>", function()
  require("nvchad.tabufline").next()
end, { desc = "buffer goto next" })

map("n", "<S-tab>", function()
  require("nvchad.tabufline").prev()
end, { desc = "buffer goto prev" })

map("n", "<leader>x", function()
  require("nvchad.tabufline").close_buffer()
end, { desc = "buffer close" })

-- Comment
map("n", "<leader>/", "gcc", { desc = "comment toggle", remap = true })
map("v", "<leader>/", "gc", { desc = "comment toggle", remap = true })

-- telescope
map("n", "<leader>fw", "<cmd>Telescope live_grep<CR>", { desc = "telescope live grep" })
map("n", "<leader>fb", "<cmd>Telescope buffers<CR>", { desc = "telescope find buffers" })
map("n", "<leader>fh", "<cmd>Telescope help_tags<CR>", { desc = "telescope help page" })
map("n", "<leader>ma", "<cmd>Telescope marks<CR>", { desc = "telescope find marks" })
map("n", "<leader>fo", "<cmd>Telescope oldfiles<CR>", { desc = "telescope find oldfiles" })
map("n", "<leader>fz", "<cmd>Telescope current_buffer_fuzzy_find<CR>", { desc = "telescope find in current buffer" })
map("n", "<leader>cm", "<cmd>Telescope git_commits<CR>", { desc = "telescope git commits" })
map("n", "<leader>gt", "<cmd>Telescope git_status<CR>", { desc = "telescope git status" })
map("n", "<leader>pt", "<cmd>Telescope terms<CR>", { desc = "telescope pick hidden term" })
map("n", "<leader>th", "<cmd>Telescope themes<CR>", { desc = "telescope nvchad themes" })
map("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "telescope find files" })
map(
  "n",
  "<leader>fa",
  "<cmd>Telescope find_files follow=true no_ignore=true hidden=true<CR>",
  { desc = "telescope find all files" }
)

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
