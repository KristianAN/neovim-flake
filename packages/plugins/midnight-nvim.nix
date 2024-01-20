{ pkgs, src }:
pkgs.vimUtils.buildVimPlugin {
  name = "midnight-nvim";
  inherit src;
}
