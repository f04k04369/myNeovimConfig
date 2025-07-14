-- lua/core/options.lua

local opt = vim.opt

-- 行番号
opt.number = true
opt.relativenumber = true

-- インデント
opt.tabstop = 2
opt.softtabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.autoindent = true

-- 検索
opt.ignorecase = true
opt.smartcase = true

-- UI
opt.termguicolors = true
opt.scrolloff = 8

-- その他
opt.undofile = true
opt.swapfile = false
opt.backup = false

-- クリップボードへのヤンク
opt.clipboard = "unnamedplus"