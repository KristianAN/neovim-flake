{ pkgs }:
with pkgs.vimPlugins; [
  # UI
  telescope-nvim
  indent-blankline-nvim

  # Git

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
]
