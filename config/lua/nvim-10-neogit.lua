-- [nfnl] Compiled from nvim-10-neogit.fnl by https://github.com/Olical/nfnl, do not edit.
local neogit = require("neogit")
local function _1_()
  return neogit.open()
end
vim.keymap.set("n", "<leader>G", _1_, {desc = "Open Neogit"})
return neogit.setup()
