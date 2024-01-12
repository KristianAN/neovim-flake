{ pkgs }:
''
local nvim_lsp = require("lspconfig")
nvim_lsp.hls.setup{}
nvim_lsp.metals.setup{
    cmd = { "${pkgs.metals}/bin/metals" },
    root_dir = nvim_lsp.util.root_pattern("build.sbt", "build.sc", ".git")
}
''
