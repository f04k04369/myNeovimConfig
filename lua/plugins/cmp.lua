-- lua/plugins/cmp.lua

local cmp = require("cmp")
local luasnip = require("luasnip")

cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ["<C-k>"] = cmp.mapping.select_prev_item(), -- 上の候補を選択
    ["<C-j>"] = cmp.mapping.select_next_item(), -- 下の候補を選択
    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),     -- 補完を表示
    ["<C-e>"] = cmp.mapping.abort(),
    ["<CR>"] = cmp.mapping.confirm({ select = true }), -- 決定
  }),
  sources = cmp.config.sources({
    { name = "nvim_lsp" },
    { name = "luasnip" },
  }, {
    { name = "buffer" },
  }),
})
