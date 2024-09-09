; Function to toggle theme
(fn toggle-theme []
  (if (= vim.o.background :dark)
      (set vim.o.background :light)
      (set vim.o.background :dark)))

; Keybinds
(vim.keymap.set :n :<leader>tt toggle-theme {:desc "Toggle theme "})

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

; Sane keybinds for system clipboard
(vim.keymap.set :n :<leader>y "\"+y"
                {:noremap true :silent true :desc "Yank to clipboarb"})

(vim.keymap.set [:x :v] :<leader>y "\"+y"
                {:noremap true :silent true :desc "Yank to clipboarb"})

(vim.keymap.set [:n :v :x] :<leader>yy "\"+yy"
                {:noremap true :silent true :desc "Yank line to clipboarb"})

(vim.keymap.set [:n :v :x] :<leader>p "\"+p"
                {:noremap true :silent true :desc "Paste from clipboarb"})

(vim.keymap.set :i :<C-p> :<C-r>+
                {:noremap true
                 :silent true
                 :desc "Paste from clipboarb within insert"})

(vim.keymap.set :x :<leader>P :_dP
                {:noremap true
                 :silent true
                 :desc "Paste over selection without erasing unamed register"})

(set vim.o.updatetime 250)
(set vim.wo.signcolumn :yes)

; Don't show the mode, since it's already in the status line
(set vim.opt.showmode false)

; Set colorscheme
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

; Terminal exit
(vim.keymap.set :t :<Esc><Esc> "<C-\\><C-n>" {:desc "Exit terminal mode"})

; tell vim to use utf-8
(set vim.opt.encoding :utf-8)

