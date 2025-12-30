require("nvim-tree").setup({
  view = {
    width = 30,
    side = "left",
  },
  renderer = {
    highlight_git = true,
    icons = {
      glyphs = {
        git = {
          unstaged = "M",
          staged = "A",
          unmerged = "!",
          renamed = "R",
          untracked = "U",
          deleted = "D",
          ignored = "I",
        },
      },
      show = {
        git = true,
        folder = true,
        file = true,
      },
    },
  },
})

-- キーバインド（例：<leader>e でトグル）
vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>")

