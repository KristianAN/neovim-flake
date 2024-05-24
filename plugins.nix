{ pkgs }:
let
in
with pkgs.vimPlugins; [
  # UI
  telescope-nvim
  indent-blankline-nvim
  trouble-nvim
  nvim-web-devicons

  # Git
  gitsigns-nvim
  neogit

  # Editing
  nvim-cmp
  cmp-buffer
  cmp-nvim-lsp
  cmp-path
  cmp-spell
  cmp-treesitter

  #theme
  kanagawa-nvim

  # lsp stuff
  nvim-lspconfig
  nvim-metals
  nvim-jdtls
  rustaceanvim
  nvim-dap
  nvim-dap-ui
  conform-nvim

  # Files
  oil-nvim

  # Other
  mini-nvim

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
      norg
      kotlin
      c_sharp
      gleam
    ]))
]
