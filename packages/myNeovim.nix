{ pkgs, lib, ... }:
let
  customRC = import ../config { inherit pkgs lib; };
  plugins = import ../plugins.nix { inherit pkgs; };
  runtimeDeps = import ../runtimeDeps.nix { inherit pkgs; };

  shellRuntimeDependencies = pkgs.symlinkJoin {
    paths = runtimeDeps.shellDeps;
    name = "neovim-runtime-shell-deps";
  };

  myNeovimUnwrapped = pkgs.wrapNeovim pkgs.neovim-unwrapped {
    configure = {
      inherit customRC;
      packages.all.start = plugins;
    };
  };
in

pkgs.writeShellApplication {
  name = "nvim";
  runtimeInputs = [
    shellRuntimeDependencies
  ];
  text = ''
    ${myNeovimUnwrapped}/bin/nvim "$@"
  '';
}
