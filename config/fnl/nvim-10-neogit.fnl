(let [neogit (require :neogit)]
  (vim.keymap.set :n :<leader>G (fn [] (neogit.open)) {:desc "Open Neogit"})
  (neogit.setup))

