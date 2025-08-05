local map = vim.keymap.set

map("n", "<leader>fw", "<cmd>FzfLua live_grep<CR>", { desc = "telescope live grep" })
map("n", "<leader>fb", "<cmd>FzfLua buffers<CR>", { desc = "telescope find buffers" })
map("n", "<leader>fh", "<cmd>FzfLua helptags<CR>", { desc = "telescope help page" })
map("n", "<leader>ma", "<cmd>FzfLua marks<CR>", { desc = "telescope find marks" })
map("n", "<leader>fo", "<cmd>FzfLua oldfiles<CR>", { desc = "telescope find oldfiles" })
map("n", "<leader>fz", "<cmd>FzfLua lgrep_curbuf<CR>", { desc = "telescope find in current buffer" })
map("n", "<leader>fc", "<cmd>FzfLua git_commits<CR>", { desc = "telescope git commits" })
map("n", "<leader>fs", "<cmd>FzfLua git_status<CR>", { desc = "telescope git status" })
map("n", "<leader>ff", "<cmd>FzfLua files<cr>", { desc = "telescope find files" })
-- map(
--   "n",
--   "<leader>fa",
--   "<cmd>Telescope find_files follow=true no_ignore=true hidden=true<CR>",
--   { desc = "telescope find all files" }
-- )
