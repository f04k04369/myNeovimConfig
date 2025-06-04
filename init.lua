-- init.lua

-- Luaモジュールを読み込む
require("options")
require("keymaps")
require("plugins")
require("plugin_config.nvim-tree")
require("plugin_config.cmp")
require("lsp.setup")
vim.opt.clipboard:append({"unnamedplus"})
