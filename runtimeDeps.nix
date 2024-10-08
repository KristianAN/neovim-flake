{ pkgs }:
{
  nodeDeps = with pkgs.nodePackages; [
    typescript-language-server
    vue-language-server
  ];

  shellDeps = with pkgs; [
    ripgrep
    lua-language-server
    rust-analyzer
    fsautocomplete
    omnisharp-roslyn
    nodejs_20
    nixd
    nixfmt-rfc-style
    scalafmt
    rustfmt
    prettierd
    yaml-language-server
    jdt-language-server
    basedpyright
    black
    clojure-lsp
    fennel-ls
    fnlfmt
    fantomas
  ];

  haskellDeps = with pkgs.haskellPackages; [
    cabal-gild
    ormolu
  ];
}
