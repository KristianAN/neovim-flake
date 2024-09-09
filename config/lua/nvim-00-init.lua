-- [nfnl] Compiled from nvim-00-init.fnl by https://github.com/Olical/nfnl, do not edit.
local function toggle_theme()
  if (vim.o.background == "dark") then
    vim.o.background = "light"
    return nil
  else
    vim.o.background = "dark"
    return nil
  end
end
vim.keymap.set("n", "<leader>tt", toggle_theme, {desc = "Toggle theme "})
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.wo.number = true
vim.wo.relativenumber = true
vim.opt.cursorline = true
vim.opt.scrolloff = 10
vim.o.ignorecase = true
vim.o.smartcase = true
vim.keymap.set("n", "<leader>y", "\"+y", {noremap = true, silent = true, desc = "Yank to clipboarb"})
vim.keymap.set({"x", "v"}, "<leader>y", "\"+y", {noremap = true, silent = true, desc = "Yank to clipboarb"})
vim.keymap.set({"n", "v", "x"}, "<leader>yy", "\"+yy", {noremap = true, silent = true, desc = "Yank line to clipboarb"})
vim.keymap.set({"n", "v", "x"}, "<leader>p", "\"+p", {noremap = true, silent = true, desc = "Paste from clipboarb"})
vim.keymap.set("i", "<C-p>", "<C-r>+", {noremap = true, silent = true, desc = "Paste from clipboarb within insert"})
vim.keymap.set("x", "<leader>P", "_dP", {noremap = true, silent = true, desc = "Paste over selection without erasing unamed register"})
vim.o.updatetime = 250
vim.wo.signcolumn = "yes"
vim.opt.showmode = false
vim.o.termguicolors = true
vim.o.completeopt = "menuone,noselect"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldtext = "v:lua.vim.treesitter.foldtext()"
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.o.grepprg = "rg --vimgrep --no-heading --smart-case"
vim.o.grepformat = "%f:%l:%c:%m"
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", {desc = "Exit terminal mode"})
vim.opt.encoding = "utf-8"
return nil
