(let [trouble (require :trouble)]
  (trouble.setup {})
  (vim.keymap.set :n :<leader>xX "<cmd>Trouble diagnostics toggle filter.buf=0<cr>"
                  {:desc "Trouble: toggle for buffer"})
  (vim.keymap.set :n :<leader>xx "<cmd>Trouble diagnostics toggle<cr>"
                  {:desc "Trouble: toggle"})
  (vim.keymap.set :n :<leader>xw
                  (fn [] (trouble.toggle :workspace_diagnostics))
                  {:desc "Trouble: toggle workspace diagnostics"})
  (vim.keymap.set :n :<leader>xd (fn [] (trouble.toggle :document_diagnostics))
                  {:desc "Trouble: toggle document diagnostics"})
  (vim.keymap.set :n :<leader>xq (fn [] (trouble.toggle :quickfix))
                  {:desc "Trouble: toggle quickfix"})
  (vim.keymap.set :n :<leader>xl (fn [] (trouble.toggle :loclist))
                  {:desc "Trouble: toggle loclist"}))

