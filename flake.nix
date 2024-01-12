{
  description = "My own Neovim flake";
  inputs = {
    nixpkgs = {
      url = "github:NixOS/nixpkgs";
    };
    neovim = {
      url = "github:neovim/neovim/stable?dir=contrib";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-utils = {
      url = "github:numtide/flake-utils";
    };
  };
  outputs = { self, nixpkgs, neovim, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        metals = { version, outputHash }:
          let
            metalsDeps = pkgs.stdenv.mkDerivation {
              name = "metals-deps-${version}";
              buildCommand = ''
	        export COURSIER_CACHE=$(pwd)
  	        ${pkgs.coursier}/bin/cs fetch org.scalameta:metals_2.13:${version} \
  	          -r bintray:scalacenter/releases \
  	          -r sonatype:snapshots > deps
  	        mkdir -p $out/share/java
  	        cp -n $(< deps) $out/share/java/
  	       '';
	      outputHashMode = "recursive";
	      outputHashAlgo = "sha256";
	      inherit outputHash;
	    };
          in pkgs.metals.overrideAttrs (old: {
	      inherit version;
	      extraJavaOpts = old.extraJavaOpts + " -Dmetals.client=nvim-lsp";
	      buildInputs = [ metalsDeps ];
	    });

        metals-pkg = metals {
          version = "1.0.1";
          outputHash = "sha256-AamUE6mr9fwjbDndQtzO2Yscu2T6zUW/DiXMYwv35YE=";
        };

        overlayFlakeInputs = prev: final: {
          neovim = neovim.packages.${prev.system}.neovim;

        };

        overlayMyNeovim = prev: final: {
          myNeovim = import ./packages/myNeovim.nix { pkgs = prev; metals-pkg = metals-pkg; }; 
        };

        pkgs = import nixpkgs {
	  inherit system;
          overlays = [
	    overlayFlakeInputs 
	    overlayMyNeovim ];
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
