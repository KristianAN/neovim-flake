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

    neovim-project-src = {
      url = "github:coffebar/neovim-project";
      flake = false;
    };

    neovim-session-manager-src = {
      url = "github:Shatur/neovim-session-manager";
      flake = false;
    };

  };

  outputs =
    {
      self,
      nixpkgs,
      neovimNightly,
      flake-utils,
      neovim-project-src,
      neovim-session-manager-src,
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        overlayFlakeInputs = prev: final: {
          neovim = neovimNightly.packages.${prev.system}.neovim;

          vimPlugins = final.vimPlugins // {
            neovim-project = import ./packages/plugins/neovimProject.nix {
              src = neovim-project-src;
              pkgs = prev;
            };

            neovim-session-manager = import ./packages/plugins/neovimSessionManager.nix {
              src = neovim-session-manager-src;
              pkgs = prev;
            };

          };
        };

        overlayMyNeovim = prev: final: { myNeovim = import ./packages/myNeovim.nix { pkgs = prev; }; };

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
