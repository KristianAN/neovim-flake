-- [nfnl] Compiled from nvim-10-nvim-completion.fnl by https://github.com/Olical/nfnl, do not edit.
local luasnip = require("luasnip")
do
  local autopairs = require("nvim-autopairs")
  autopairs.setup({})
end
local cmp_autopairs = require("nvim-autopairs.completion.cmp")
luasnip.config.setup({})
local cmp = require("cmp")
cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
local function _1_(args)
  return luasnip.lsp_expand(args.body)
end
local function _2_(_, item)
  item.abbr = string.sub(item.abbr, 1, 20)
  return item
end
local function _3_()
  if luasnip.expand_or_locally_jumpable() then
    return luasnip.expand_or_jump()
  else
    return nil
  end
end
local function _5_()
  if luasnip.locally_jumpable(-1) then
    return luasnip.jump(-1)
  else
    return nil
  end
end
return cmp.setup({snippet = {expand = _1_}, formatting = {format = _2_}, completion = {completeopt = "menu,menuone,noinsert"}, mapping = cmp.mapping.preset.insert({["<C-n>"] = cmp.mapping.select_next_item(), ["<C-p>"] = cmp.mapping.select_prev_item(), ["<C-b>"] = cmp.mapping.scroll_docs(-4), ["<C-f>"] = cmp.mapping.scroll_docs(4), ["<C-y>"] = cmp.mapping.confirm({select = true}), ["<C-Space>"] = cmp.mapping.complete({}), ["<C-l>"] = cmp.mapping(_3_, {i = true, s = true}), ["<C-h>"] = cmp.mapping(_5_, {i = true, s = true})}), sources = {{name = "nvim_lsp"}, {name = "nvim_lsp_signature_help"}, {name = "luasnip"}, {name = "path"}, {name = "orgmode"}, {name = "buffer"}}})
