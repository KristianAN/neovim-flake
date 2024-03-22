{ pkgs }:
{
  nodeDeps = with pkgs.nodePackages; [
    typescript-language-server
    volar
  ];

  shellDeps = with pkgs; [
    ripgrep
    haskell-language-server
    coursier
    jdt-language-server
    lua-language-server
    rust-analyzer
    fsautocomplete
    omnisharp-roslyn
  ];
}
