
local lspconfig = require("lspconfig")

local servers = {
  "ts_ls",         -- JavaScript / TypeScript
  "pyright",       -- Python
  "lua_ls",        -- Lua
}

local capabilities = require("cmp_nvim_lsp").default_capabilities()

for _, server in ipairs(servers) do
  lspconfig[server].setup({
    capabilities = capabilities,
  })
end


