-- [nfnl] Compiled from nvim-10-neovim-project.fnl by https://github.com/Olical/nfnl, do not edit.
local neovim_project = require("neovim-project")
vim.keymap.set("n", "<leader>pd", "<cmd>NeovimProjectDiscover<cr>", {desc = "Discover projects"})
vim.keymap.set("n", "<leader>pp", "<cmd>NeovimProjectHistory<cr>", {desc = "Recent projects"})
vim.keymap.set("n", "<leader>pr", "<cmd>NeovimProjectLoadRecent<cr>", {desc = "Load previous project"})
return neovim_project.setup({projects = {"~/src/*", "~/nix/*", "~/projects/*"}, picker = {type = "telescope"}, dashboard_mode = true})
