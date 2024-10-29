(let [neovim-project (require :neovim-project)]
  (neovim-project.setup {
  :projects ["~/src/*"  "~/nix/*" "~/projects/*"]
  :picker {:type "telescope"}
  :dashboard_mode true
  }))
