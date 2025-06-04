-- lua/keymaps.lua

vim.g.mapleader = " "

local keymap = vim.keymap

keymap.set("n", "<leader>pv", vim.cmd.Ex) -- ファイラー起動 (netrw)
keymap.set("n", "<leader>w", ":w<CR>")     -- 保存
keymap.set("n", "<leader>q", ":q<CR>")     -- 終了
