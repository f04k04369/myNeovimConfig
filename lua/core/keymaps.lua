-- lua/core/keymaps.lua

local map = vim.keymap.set

-- ノーマルモードでのキーマップ
map("n", "<Space>", "<Nop>", { silent = true })
vim.g.mapleader = " " -- リーダーキーをスペースに設定

-- Telescope
map("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Find Files" })
map("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", { desc = "Live Grep" })
map("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "Find Buffers" })

-- NvimTree
map("n", "<C-n>", "<cmd>NvimTreeToggle<cr>", { desc = "Toggle NvimTree" })

-- Insert mode
map("i", "jk", "<Esc>", { desc = "Exit Insert Mode" })
