{ pkgs }:
{
  nodeDeps = with pkgs; [
  ];

  shellDeps = with pkgs; [
    ripgrep
    haskell-language-server
    coursier
    jdt-language-server
    rnix-lsp
    lua-language-server
  ];
}
