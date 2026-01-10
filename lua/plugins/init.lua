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
  { import = "plugins.theme" },

  -- UI系
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("plugins.nvim-tree")
    end,
  },
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

  -- 括弧の自動補完
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      local autopairs = require("nvim-autopairs")
      autopairs.setup({
        check_ts = true, -- treesitterと連携
        ts_config = {
          lua = { "string" }, -- luaでは文字列内で補完しない
          javascript = { "template_string" },
        },
        disable_filetype = { "TelescopePrompt" },
        fast_wrap = {
          map = "<M-e>", -- Alt+eでfast wrapを使用
          chars = { "{", "[", "(", '"', "'", "<" },
          pattern = [=[[%'%"%)%>%]%)%}%,]]=],
          end_key = "$",
          keys = "qwertyuiopzxcvbnmasdfghjkl",
          check_comma = true,
          highlight = "Search",
          highlight_grey = "Comment",
        },
      })

      -- < > ペアのルールを追加
      local Rule = require("nvim-autopairs.rule")
      autopairs.add_rules({
        Rule("<", ">"),
      })

      -- nvim-cmpとの連携
      local cmp_autopairs = require("nvim-autopairs.completion.cmp")
      local cmp_ok, cmp = pcall(require, "cmp")
      if cmp_ok then
        cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
      end
    end,
  },
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
