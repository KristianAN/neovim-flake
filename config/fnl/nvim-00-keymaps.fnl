; Keybindings that don't really belong anywhere else

; toggle theme
(vim.keymap.set :n :<leader>tt
                (lambda []
                  (if (= vim.o.background :dark)
                      (set vim.o.background :light)
                      (set vim.o.background :dark)))
                {:desc "Toggle theme "})

; Sane keybinds for system clipboard
(vim.keymap.set :n :<leader>y "\"+y"
                {:noremap true :silent true :desc "Yank to clipboarb"})

(vim.keymap.set [:x :v] :<leader>y "\"+y"
                {:noremap true :silent true :desc "Yank to clipboarb"})

(vim.keymap.set [:n :v :x] :<leader>yy "\"+yy"
                {:noremap true :silent true :desc "Yank line to clipboarb"})

(vim.keymap.set [:n :v :x] :<leader>cp "\"+p"
                {:noremap true :silent true :desc "Paste from clipboarb"})

(vim.keymap.set :i :<C-p> :<C-r>+
                {:noremap true
                 :silent true
                 :desc "Paste from clipboarb within insert"})

(vim.keymap.set :x :<leader>P :_dP
                {:noremap true
                 :silent true
                 :desc "Paste over selection without erasing unamed register"})

; Terminal exit
(vim.keymap.set :t :<Esc><Esc> "<C-\\><C-n>" {:desc "Exit terminal mode"})
