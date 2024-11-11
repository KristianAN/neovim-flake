{ pkgs, lib, ... }:
let
  customRC = import ../config { inherit pkgs lib; };
  plugins = import ../plugins.nix { inherit pkgs; };
  runtimeDeps = import ../runtimeDeps.nix { inherit pkgs; };

  neovimRuntimeNodeDependencies = pkgs.symlinkJoin {
    paths = runtimeDeps.nodeDeps;
    name = "neovim-runtime-node-deps";
  };

  neovimRuntimeHaskellDependencies = pkgs.symlinkJoin {
    paths = runtimeDeps.haskellDeps;
    name = "neovim-runtime-node-deps";
  };
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
    neovimRuntimeNodeDependencies
    neovimRuntimeHaskellDependencies
    shellRuntimeDependencies
  ];
  text = ''
    ${myNeovimUnwrapped}/bin/nvim "$@"
  '';
}
