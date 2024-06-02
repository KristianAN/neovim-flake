{ pkgs }:
{
  nodeDeps = with pkgs.nodePackages; [
    typescript-language-server
    volar
  ];

  shellDeps = with pkgs; [
    ripgrep
    jdt-language-server
    lua-language-server
    rust-analyzer
    fsautocomplete
    omnisharp-roslyn
    nodejs_20
  ];
}
