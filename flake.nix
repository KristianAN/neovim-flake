{
  description = "My own Neovim flake";
  inputs = {

    nixpkgs = {
      url = "github:nixos/nixpkgs/nixos-unstable";
    };

    neovimNightly = {
      url = "github:nix-community/neovim-nightly-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    flake-utils = {
      url = "github:numtide/flake-utils";
    };

  };

  outputs =
    {
      self,
      nixpkgs,
      neovimNightly,
      flake-utils,
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        overlayFlakeInputs = prev: final: {
          neovim = neovimNightly.packages.${prev.system}.neovim;

          vimPlugins = final.vimPlugins // {

          };
        };

        overlayMyNeovim = prev: final: {
          myNeovim = import ./packages/myNeovim.nix {
            pkgs = prev;
            lib = prev.lib;
          };
        };

        pkgs = import nixpkgs {
          inherit system;
          overlays = [
            overlayFlakeInputs
            overlayMyNeovim
          ];
        };

      in
      {
        packages = rec {
          nvim = pkgs.myNeovim;
          default = nvim;
        };

        apps = rec {
          nvim = flake-utils.lib.mkApp { drv = self.packages.${system}.nvim; };
          default = nvim;
        };
      }
    );
}
