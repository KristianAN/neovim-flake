(let [neovim-project (require :neovim-project)]
  (vim.keymap.set :n :<leader>pd "<cmd>NeovimProjectDiscover<cr>" {:desc "Discover projects"})
  (vim.keymap.set :n :<leader>pp "<cmd>NeovimProjectHistory<cr>" {:desc "Recent projects"})
  (vim.keymap.set :n :<leader>pr "<cmd>NeovimProjectLoadRecent<cr>" {:desc "Load previous project"})
  (neovim-project.setup {
    :projects ["~/src/*"  "~/nix/*" "~/projects/*" "~/orgfiles"]
    :picker {:type "telescope"}
    :dashboard_mode true
  }))
