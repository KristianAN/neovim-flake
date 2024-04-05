{ pkgs, src }:
pkgs.vimUtils.buildVimPlugin {
  name = "copilotchat-nvim";
  inherit src;
}
