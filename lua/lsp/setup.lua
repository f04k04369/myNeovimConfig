require("mason").setup()
require("mason-lspconfig").setup()

require("plugin_config.cmp") -- 補完をここでも読み込むと安全

require("lsp.servers") -- 個別LSP設定ファイル

