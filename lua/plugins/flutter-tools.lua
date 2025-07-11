-- lua/plugins/flutter-tools.lua

require("flutter-tools").setup({
  lsp = {
    color = {
      -- UI as codeをより快適にするためにカラープレビューを有効化
      enabled = true,
    },
  },
  dev_log = {
    enabled = true,
    open_cmd = "tabedit", -- ログを新しいタブで開く
  },
  -- DAP（デバッグアダプタープロトコル）の設定
  dap = {
    application_launches = "vs-code", -- VSCodeと同じlaunch.jsonを使う
  },
})

-- Flutter用のキーマップ
local map = vim.keymap.set
map("n", "<leader>r", "<cmd>FlutterReload<cr>", { desc = "Flutter Hot Reload" })
map("n", "<leader>R", "<cmd>FlutterRestart<cr>", { desc = "Flutter Hot Restart" })
map("n", "<leader>q", "<cmd>FlutterQuit<cr>", { desc = "Flutter Quit" })
map("n", "<leader>d", "<cmd>FlutterDevices<cr>", { desc = "Flutter Devices" })
