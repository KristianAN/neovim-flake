-- [nfnl] Compiled from nvim-00-init.fnl by https://github.com/Olical/nfnl, do not edit.
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.wo.number = true
vim.wo.relativenumber = true
vim.opt.cursorline = true
vim.opt.scrolloff = 10
vim.o.ignorecase = true
vim.o.smartcase = true
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
vim.opt.encoding = "utf-8"
if vim.g.neovide then
  vim.o.guifont = "Iosevka Nerd Font:h13"
  vim.g.neovide_cursor_animation_length = 0
else
end
local function openTerminals()
  vim.cmd("tabnew")
  vim.cmd("term")
  vim.cmd("vsplit")
  vim.cmd("wincmd l")
  vim.cmd("term")
  vim.cmd("split")
  vim.cmd("wincmd j")
  vim.cmd("term")
  vim.cmd("wincmd h")
  vim.cmd("split")
  vim.cmd("wincmd j")
  return vim.cmd("term")
end
vim.keymap.set("n", "<leader>tn", openTerminals, {desc = "Term in new tab"})
return vim.cmd("colorscheme default")
