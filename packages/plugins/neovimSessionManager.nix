{ pkgs, src }:
pkgs.vimUtils.buildVimPlugin {
  name = "neovim-session-manager";
  inherit src;
}
