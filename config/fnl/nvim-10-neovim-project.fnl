(let [neovim-project (require :nneovim-project)]
  (neovim-project.setup {
  :projects ["~/src/*"  "~/nix/*" "~/projects/*"]
  :picker {:type "telescope"}
  :dashboard_mode true
  }))
