{ pkgs }:
  with pkgs.vimPlugins; [
    telescope-nvim
    nvim-lspconfig
    nvim-metals
    nvim-jdtls

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
