-- lua/plugins/treesitter.lua
require("nvim-treesitter.configs").setup({
  ensure_installed = { "c", "lua", "vim", "vimdoc", "dart" }, -- dartを追加
  sync_install = false,
  auto_install = true,
  highlight = {
    enable = true,
  },
})
