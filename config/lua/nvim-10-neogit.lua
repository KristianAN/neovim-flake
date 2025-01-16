-- [nfnl] Compiled from nvim-10-neogit.fnl by https://github.com/Olical/nfnl, do not edit.
do
  local diffview = require("diffview")
  diffview.setup()
end
local neogit = require("neogit")
neogit.setup({integrations = {diffview = true}})
return vim.keymap.set("n", "<leader>G", neogit.open, {desc = "Neogit"})
