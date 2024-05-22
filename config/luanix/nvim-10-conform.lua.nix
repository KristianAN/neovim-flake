{ pkgs, ... }:
/*
  lua
*/
''
require("conform").setup({
  formatters_by_ft = {
    java = { "google-java-format" }
  },
  format_on_save = {
    -- These options will be passed to conform.format()
    timeout_ms = 500,
    lsp_fallback = true,
  },
})
''
