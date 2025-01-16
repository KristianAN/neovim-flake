(let [diffview (require :diffview)]
  (diffview.setup))

(let [neogit (require :neogit)]
  ;; Setup
  (neogit.setup {:integrations {:diffview true}})
  ;; Keybinds
  (vim.keymap.set :n :<leader>G neogit.open {:desc :Neogit}))
