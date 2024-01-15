local cmp_autopairs = require('nvim-autopairs.completion.cmp')
local cmp = require("cmp")
cmp.setup({
  sources = {
    { name = "nvim_lsp" },
    { name = 'luasnip' },
  },
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ["<CR>"] = cmp.mapping.confirm({ select = true }),
    ["<Tab>"] = function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      else
        fallback()
      end
    end,
    ["<S-Tab>"] = function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      else
        fallback()
      end
    end,
  }),
})

cmp.event:on(
  'confirm_done',
  cmp_autopairs.on_confirm_done()
)
