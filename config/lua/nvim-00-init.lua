-- Global functions
Nmap = function(keys, func, desc)
  if desc then
    desc = '' .. desc
  end

  vim.keymap.set('n', keys, func, { desc = desc })
end

-- Global configuration
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.wo.number = true
vim.wo.relativenumber = true

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10

-- Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Decrease update time
vim.o.updatetime = 250
vim.wo.signcolumn = 'yes'

-- Don't show the mode, since it's already in the status line
vim.opt.showmode = false

-- Set colorscheme
vim.o.termguicolors = true
vim.cmd [[colorscheme kanagawa-dragon]]

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

Nmap('<leader>tt', toggle_theme, 'Toggle dark/light')

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

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Plugins that don't need their own config file
require('mini.notify').setup()
require('mini.surround').setup()
require('mini.statusline').setup()
require('mini.files').setup()
Nmap('<leader>o', require('mini.files').open, 'open file browser')
Nmap('<leader>oc', function() require('mini.files').open(vim.api.nvim_buf_get_name(0)) end,
  'open file browser in current dir')
