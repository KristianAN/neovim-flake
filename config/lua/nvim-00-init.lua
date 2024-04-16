-- Global configuration
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.wo.number = true
vim.wo.relativenumber = true

-- Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Decrease update time
vim.o.updatetime = 250
vim.wo.signcolumn = 'yes'

-- Set colorscheme
vim.o.termguicolors = true
vim.cmd [[colorscheme kanagawa-dragon]]

local nmap = function(keys, func, desc)
  if desc then
    desc = 'LSP: ' .. desc
  end

  vim.keymap.set('n', keys, func, { desc = desc })
end

local function toggle_theme()
  local current_theme = vim.g.colors_name
  if current_theme == "kanagawa-lotus" then
    vim.cmd [[colorscheme kanagawa-dragon]]
    vim.g.colors_name = "kanagawa-dragon"
  else
    vim.cmd [[colorscheme kanagawa-lotus]]
    vim.g.colors_name = "kanagawa-lotus"
  end
end

nmap('<leader>tt', toggle_theme, 'Toggle dark/light')

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'
-- Folding with treesitter
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldtext = "v:lua.vim.treesitter.foldtext()"
-- show tabs as two spaces
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

-- grep backend
vim.o.grepprg = 'rg --vimgrep --no-heading --smart-case'
vim.o.grepformat = '%f:%l:%c:%m'
