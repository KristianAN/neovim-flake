-- [nfnl] Compiled from nvim-10-neogit.fnl by https://github.com/Olical/nfnl, do not edit.
local neogit = require("neogit")
neogit.setup()
return vim.keymap.set("n", "<leader>G", neogit.open, {desc = "Neogit"})
