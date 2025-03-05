{ pkgs }:
{

  shellDeps = [
    pkgs.ripgrep
    pkgs.lua-language-server
    pkgs.rust-analyzer
    pkgs.fsautocomplete
    pkgs.omnisharp-roslyn
    pkgs.nixd
    pkgs.nixfmt-rfc-style
    pkgs.scalafmt
    pkgs.rustfmt
    pkgs.prettierd
    pkgs.yaml-language-server
    pkgs.jdt-language-server
    pkgs.basedpyright
    pkgs.black
    pkgs.clojure-lsp
    pkgs.fennel-ls
    pkgs.fnlfmt
    pkgs.fantomas
    pkgs.vue-language-server
  ];

}
