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

  (nvim-treesitter.withPlugins (plugins:
    with plugins; [
      scala
      nix
      java
      haskell
      python
      rust
      javascript
      typescript
      lua
      yaml
      xml
      sql
      smithy
      dockerfile
      css
      tree-sitter-nu.grammar
    ]))
]
