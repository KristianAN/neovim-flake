; global configuration 
; set leader 
(set vim.g.mapleader " ")
(set vim.g.maplocalleader " ")

; relative line numbers 
(set vim.wo.number true)
(set vim.wo.relativenumber true)

; Show which line your cursor is on
(set vim.opt.cursorline true)

; Minimal number of screen lines to keep above and below the cursor.
(set vim.opt.scrolloff 10)

; Case insensitive searching UNLESS /C or capital in search
(set vim.o.ignorecase true)
(set vim.o.smartcase true)

(set vim.o.updatetime 250)
(set vim.wo.signcolumn :yes)

; Don't show the mode, since it's already in the status line
(set vim.opt.showmode false)

(set vim.o.termguicolors true)

; Set completeopt to have a better completion experience
(set vim.o.completeopt "menuone,noselect")

; Folding with treesitter
(set vim.opt.foldexpr "v:lua.vim.treesitter.foldexpr()")
(set vim.opt.foldtext "v:lua.vim.treesitter.foldtext()")

; show tabs as two spaces
(set vim.opt.tabstop 2)
(set vim.opt.shiftwidth 2)
(set vim.opt.expandtab true)

; grep backend
(set vim.o.grepprg "rg --vimgrep --no-heading --smart-case")
(set vim.o.grepformat "%f:%l:%c:%m")

; tell vim to use utf-8
(set vim.opt.encoding :utf-8)

; set font for neovide
(when vim.g.neovide
  (set vim.o.guifont "Iosevka Nerd Font:h13")
  (set vim.g.neovide_cursor_animation_length 0) ; (set vim.g.neovide_transparency  0.95)
  )

(fn openTerminals []
  (vim.cmd :tabnew)
  (vim.cmd :term)
  (vim.cmd :vsplit)
  (vim.cmd "wincmd l")
  (vim.cmd :term)
  (vim.cmd :split)
  (vim.cmd "wincmd j")
  (vim.cmd :term)
  (vim.cmd "wincmd h")
  (vim.cmd :split)
  (vim.cmd "wincmd j")
  (vim.cmd :term))

(vim.keymap.set :n :<leader>tn openTerminals {:desc "Term in new tab"})

(vim.cmd "colorscheme default")

(set vim.g.conjure#filetype#fennel :conjure.client.fennel.nfnl)
