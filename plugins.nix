{ pkgs }:
let
  tree-sitter-nu = pkgs.callPackage ./modules/nvim-treesitter-nu.nix {
    inherit (pkgs.tree-sitter) buildGrammar;
  };
in
with pkgs.vimPlugins; [
  # UI
  telescope-nvim
  indent-blankline-nvim
  lualine-nvim
  which-key-nvim
  trouble-nvim
  zen-mode-nvim

  # Git
  gitsigns-nvim
  fugitive

  # Completion
  nvim-cmp
  cmp-nvim-lsp
  cmp-buffer
  cmp-path
  cmp-cmdline
  luasnip

  #theme
  kanagawa-nvim

  # lsp stuff
  nvim-lspconfig
  nvim-jdtls
  nvim-metals

  # tree-sitter
  nvim-treesitter
  nvim-treesitter-parsers.scala
  nvim-treesitter-parsers.nix
  nvim-treesitter-parsers.java
  nvim-treesitter-parsers.haskell
  nvim-treesitter-parsers.python
  nvim-treesitter-parsers.rust
  nvim-treesitter-parsers.javascript
  nvim-treesitter-parsers.typescript
  nvim-treesitter-parsers.lua
  nvim-treesitter-parsers.yaml
  nvim-treesitter-parsers.xml
  nvim-treesitter-parsers.sql
  nvim-treesitter-parsers.smithy
  nvim-treesitter-parsers.dockerfile
  nvim-treesitter-parsers.css
  tree-sitter-nu.grammar

]
