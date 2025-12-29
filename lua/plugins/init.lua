-- Lazy.nvim を bootstrap
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath
  })
end
vim.opt.rtp:prepend(lazypath)

-- プラグイン定義
require("lazy").setup({
  -- 🌟 Flutter 必須プラグイン
  {
    "akinsho/flutter-tools.nvim",
    lazy = false,
    dependencies = { "nvim-lua/plenary.nvim", "stevearc/dressing.nvim" },
    config = true, -- lua/plugins/flutter-tools.lua を読み込む
  },

  -- 新機能のインポート
  { import = "plugins.efficiency" },
  { import = "plugins.ui_enhancements" },
  { import = "plugins.formatting" },

  -- UI系
  { "nvim-tree/nvim-tree.lua", dependencies = { "nvim-tree/nvim-web-devicons" }, config = true },
  { "nvim-lualine/lualine.nvim", config = true },
  { "folke/tokyonight.nvim", lazy = false, priority = 1000, config = true },
  { "lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {} },

  -- 補完 & LSP関連
  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate",
    config = function()
      require("mason").setup()
    end,
  },
  { "williamboman/mason-lspconfig.nvim" },
  { "hrsh7th/nvim-cmp", dependencies = { "hrsh7th/cmp-nvim-lsp", "L3MON4D3/LuaSnip", "saadparwaiz1/cmp_luasnip" }, config = true }, -- lua/plugins/cmp.lua を読み込む

  -- 構文解析
  { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate", config = true },

  -- ユーティリティ
  { "nvim-lua/plenary.nvim" },
  { "nvim-telescope/telescope.nvim", tag = "0.1.5", dependencies = { "nvim-lua/plenary.nvim" }, config = true },
  { "numToStr/Comment.nvim", opts = {} },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
    }
  },

  -- ターミナル
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    opts = {
        size = 15,
        open_mapping = [[<C-\>]],
        direction = "horizontal",
        shade_terminals = true,
        start_in_insert = true,
        persist_size = true,
    }
  },
})
