-- [nfnl] Compiled from nvim-10-conform.fnl by https://github.com/Olical/nfnl, do not edit.
local conform = require("conform")
return conform.setup({formatters_by_ft = {java = {"google-java-format"}, nix = {"nixfmt"}, haskell = {"formolu"}, rust = {"rustfmt"}, javascript = {"prettierd"}, typescript = {"prettierd"}, vue = {"prettierd"}, python = {"black"}, fennel = {"fnlfmt"}}, format_on_save = {timeout_ms = 500, lsp_fallback = true}})
