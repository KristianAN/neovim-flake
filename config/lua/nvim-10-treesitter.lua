-- [nfnl] Compiled from nvim-10-treesitter.fnl by https://github.com/Olical/nfnl, do not edit.
local treesitter = require("nvim-treesitter.configs")
return treesitter.setup({ensure_installed = {}, highlight = {enable = true, additional_vim_regex_highlighting = false}, indent = {enable = true}})
