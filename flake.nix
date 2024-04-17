{
  description = "My own Neovim flake";
  inputs = {
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixos-unstable";
    };
    neovim = {
      url = "github:neovim/neovim/stable?dir=contrib";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-utils = {
      url = "github:numtide/flake-utils";
    };

    midnight-nvim = {
      url = "github:dasupradyumna/midnight.nvim";
      flake = false;
    };

    copilotchat-nvim = {
      url = "github:copilotc-nvim/copilotchat.nvim";
      flake = false;
    };

  };

  outputs = { self, nixpkgs, neovim, flake-utils, midnight-nvim , copilotchat-nvim }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        overlayFlakeInputs = prev: final: {
          neovim = neovim.packages.${prev.system}.neovim;

          vimPlugins = final.vimPlugins // {
            midnight-nvim = import ./packages/plugins/midnight-nvim.nix {
              src = midnight-nvim;
              pkgs = prev;
            };

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
