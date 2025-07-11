require("nvim-tree").setup({
  view = {
    width = 30,
    side = "left",
  },
  renderer = {
    icons = {
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

