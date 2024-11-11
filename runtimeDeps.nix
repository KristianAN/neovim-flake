{ pkgs }:
{
  nodeDeps = with pkgs.nodePackages; [
    typescript-language-server
  ];

  shellDeps = [
    pkgs.ripgrep
    pkgs.lua-language-server
    pkgs.rust-analyzer
    pkgs.fsautocomplete
    pkgs.omnisharp-roslyn
    pkgs.nodejs_20
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

  haskellDeps = with pkgs.haskellPackages; [
    cabal-gild
    ormolu
  ];
}
