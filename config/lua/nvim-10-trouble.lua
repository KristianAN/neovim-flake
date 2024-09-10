-- [nfnl] Compiled from nvim-10-trouble.fnl by https://github.com/Olical/nfnl, do not edit.
local trouble = require("trouble")
trouble.setup({})
vim.keymap.set("n", "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", {desc = "Trouble: toggle for buffer"})
vim.keymap.set("n", "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", {desc = "Trouble: toggle"})
local function _1_()
  return trouble.toggle("workspace_diagnostics")
end
vim.keymap.set("n", "<leader>xw", _1_, {desc = "Trouble: toggle workspace diagnostics"})
local function _2_()
  return trouble.toggle("document_diagnostics")
end
vim.keymap.set("n", "<leader>xd", _2_, {desc = "Trouble: toggle document diagnostics"})
local function _3_()
  return trouble.toggle("quickfix")
end
vim.keymap.set("n", "<leader>xq", _3_, {desc = "Trouble: toggle quickfix"})
local function _4_()
  return trouble.toggle("loclist")
end
return vim.keymap.set("n", "<leader>xl", _4_, {desc = "Trouble: toggle loclist"})
