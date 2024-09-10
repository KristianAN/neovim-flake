-- [nfnl] Compiled from nvim-10-conform.fnl by https://github.com/Olical/nfnl, do not edit.
local conform = require("conform")
do local _ = conform.setup end
return {formatters_by_ft = {java = {"google-java-format"}, nix = {"nixfmt"}, haskell = {"ormolu"}, rust = {"rustfmt"}, javascript = {"prettierd"}, typescript = {"prettierd"}, python = {"black"}, fennel = {"fnlfmt"}}, format_on_save = {timeout_ms = 500, lsp_fallback = true}}