{ pkgs, src }:
pkgs.vimUtils.buildVimPlugin {
  name = "alabaster";
  inherit src;
}
