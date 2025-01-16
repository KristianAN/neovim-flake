(let [neogit (require :neogit)]
  ;; Setup
  (neogit.setup)
  ;; Keybinds
  (vim.keymap.set :n :<leader>G neogit.open {:desc :Neogit}))
