{ pkgs, src }:
pkgs.vimUtils.buildVimPlugin {
  name = "neovim-project";
  inherit src;
}
