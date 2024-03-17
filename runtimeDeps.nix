{ pkgs }:
{
  nodeDeps = with pkgs; [
  ];

  shellDeps = with pkgs; [
    ripgrep
    haskell-language-server
    coursier
    jdt-language-server
    lua-language-server
    rust-analyzer
    fsautocomplete
  ];
}
