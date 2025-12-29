-- lua/plugins/nvim-lspconfig.lua

return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
  },
  config = function()
    -- LSPの共通設定
    local on_attach = function(client, bufnr)
      local map = function(mode, lhs, rhs, desc)
        vim.keymap.set(mode, lhs, rhs, { noremap = true, silent = true, buffer = bufnr, desc = "LSP: " .. desc })
      end

      map("n", "gd", vim.lsp.buf.definition, "Go to Definition")
      map("n", "K", vim.lsp.buf.hover, "Hover Documentation")
      map("n", "gi", vim.lsp.buf.implementation, "Go to Implementation")
      map("n", "<leader>rn", vim.lsp.buf.rename, "Rename")
      map("n", "<leader>ca", vim.lsp.buf.code_action, "Code Action")
      map("n", "gr", require("telescope.builtin").lsp_references, "Go to References")
    end

    local capabilities = require("cmp_nvim_lsp").default_capabilities()

    -- mason-lspconfigを使って、dartls "以外" のLSPを自動セットアップ
    require("mason-lspconfig").setup({
      ensure_installed = { "lua_ls", "ts_ls", "tailwindcss", "eslint", "cssls" }, -- dartls以外のLSPをここに追加
      handlers = {
        -- デフォルトのハンドラ（dartls以外はこれを使う）
        function(server_name)
          require("lspconfig")[server_name].setup({
            on_attach = on_attach,
            capabilities = capabilities,
          })
        end,
        -- dartlsは手動で設定するので、ここでは何もしない
        ["dartls"] = function() end,
      },
    })

    -- dartlsを直接パスを指定して手動セットアップ
    require("lspconfig").dartls.setup({
      on_attach = on_attach,
      capabilities = capabilities,
    })
  end,
}
