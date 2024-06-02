{
  description = "My own Neovim flake";
  inputs = {
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixos-unstable";
    };
    neovim = {
      url = "github:nix-community/neovim-nightly-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-utils = {
      url = "github:numtide/flake-utils";
    };

    copilotchat-nvim = {
      url = "github:copilotc-nvim/copilotchat.nvim";
      flake = false;
    };

    bleep-flake.url = "github:KristianAN/bleep-flake"; # The bleep flake

  };

  outputs = { self, nixpkgs, neovim, flake-utils, copilotchat-nvim, bleep-flake }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        overlayFlakeInputs = prev: final: {
          neovim = neovim.packages.${prev.system}.neovim;
          bleep = bleep-flake.defaultPackage.${system}; # Your bleep system binary

          vimPlugins = final.vimPlugins // {
            copilotchat-nvim = import ./packages/plugins/copilotchat-nvim.nix {
              src = copilotchat-nvim;
              pkgs = prev;
            };

          };
        };

        overlayMyNeovim = prev: final: {
          myNeovim = import ./packages/myNeovim.nix { pkgs = prev; };
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
      });
}
