-- Global configuration
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.wo.number = true

-- Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Decrease update time
vim.o.updatetime = 250
vim.wo.signcolumn = 'yes'

-- Set colorscheme
vim.o.termguicolors = true
vim.cmd[[colorscheme kanagawa-wave]]
-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'
