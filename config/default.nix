{ pkgs, lib }:
let
  nixFiles2ConfigFiles =
    dir:
    builtins.map (
      file:
      pkgs.writeTextFile {
        name = pkgs.lib.strings.removeSuffix ".nix" file;
        text = import ./${dir}/${file} {
          inherit pkgs;
          inherit lib;
        };
      }
    ) (builtins.attrNames (builtins.readDir ./${dir}));

  scripts2ConfigFiles =
    dir:
    let
      configDir = pkgs.stdenv.mkDerivation {
        name = "nvim-${dir}-configs";
        src = ./${dir};
        installPhase = ''
          mkdir -p $out/
          cp ./* $out/
        '';
      };
      filterFiles = files: builtins.filter (file: !(builtins.match ".*\\.fnl$" file != null)) files;
    in
    builtins.map (file: "${configDir}/${file}") (
      filterFiles (builtins.attrNames (builtins.readDir configDir))
    );

  sourceConfigFiles =
    files:
    builtins.concatStringsSep "\n" (
      builtins.map (
        file: (if pkgs.lib.strings.hasSuffix "lua" file then "luafile" else "source") + " ${file}"
      ) files
    );

  lua = scripts2ConfigFiles "lua";
  luanix = nixFiles2ConfigFiles "luanix";

in
builtins.concatStringsSep "\n" (
  builtins.map (configs: sourceConfigFiles configs) [
    lua
    luanix
  ]
)
