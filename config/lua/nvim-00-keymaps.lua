-- [nfnl] Compiled from nvim-00-keymaps.fnl by https://github.com/Olical/nfnl, do not edit.
local function _1_()
  if (vim.o.background == "dark") then
    vim.o.background = "light"
    return nil
  else
    vim.o.background = "dark"
    return nil
  end
end
vim.keymap.set("n", "<leader>tt", _1_, {desc = "Toggle theme "})
vim.keymap.set("n", "<leader>y", "\"+y", {noremap = true, silent = true, desc = "Yank to clipboarb"})
vim.keymap.set({"x", "v"}, "<leader>y", "\"+y", {noremap = true, silent = true, desc = "Yank to clipboarb"})
vim.keymap.set({"n", "v", "x"}, "<leader>yy", "\"+yy", {noremap = true, silent = true, desc = "Yank line to clipboarb"})
vim.keymap.set({"n", "v", "x"}, "<leader>cp", "\"+p", {noremap = true, silent = true, desc = "Paste from clipboarb"})
vim.keymap.set("i", "<C-p>", "<C-r>+", {noremap = true, silent = true, desc = "Paste from clipboarb within insert"})
vim.keymap.set("x", "<leader>P", "_dP", {noremap = true, silent = true, desc = "Paste over selection without erasing unamed register"})
return vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", {desc = "Exit terminal mode"})
