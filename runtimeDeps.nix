{ pkgs }:
{
  nodeDeps = with pkgs; [
  ];

  shellDeps = with pkgs; [
    ripgrep
    haskell-language-server
    haskellPackages.cabal-fmt
    coursier
    jdt-language-server
    rnix-lsp
    lua-language-server
    rust-analyzer
  ];
}
