{ pkgs, metals-pkg }:
let
  customRC = import ../config { inherit pkgs; inherit metals-pkg; };
  plugins = import ../plugins.nix { inherit pkgs;  };
  runtimeDeps = import ../runtimeDeps.nix { inherit pkgs; inherit metals-pkg; };

  neovimRuntimeNodeDependencies = pkgs.symlinkJoin {
    paths = runtimeDeps.nodeDeps;
    name = "neovim-runtime-node-deps";
  };

  shellRuntimeDependencies = pkgs.symlinkJoin {
    paths = runtimeDeps.shellDeps;
    name = "neovim-runtime-shell-deps";
  };

  myNeovimUnwrapped = pkgs.wrapNeovim pkgs.neovim {
    configure = {
      inherit customRC;
      packages.all.start = plugins;
    };
  };
in
pkgs.writeShellApplication {
  name = "nvim";
  runtimeInputs = [ neovimRuntimeNodeDependencies shellRuntimeDependencies ];
  text = ''
    ${myNeovimUnwrapped}/bin/nvim "$@"
  '';
}
