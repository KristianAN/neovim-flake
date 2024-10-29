-- [nfnl] Compiled from nvim-10-neovim-project.fnl by https://github.com/Olical/nfnl, do not edit.
local neovim_project = require("nneovim-project")
return neovim_project.setup({projects = {"~/src/*", "~/nix/*", "~/projects/*"}, picker = {type = "telescope"}, dashboard_mode = true})
