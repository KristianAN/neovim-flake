{ pkgs }:
let
in
with pkgs.vimPlugins;
[
  # UI
  telescope-nvim
  indent-blankline-nvim
  trouble-nvim
  nvim-web-devicons

  # Git
  gitsigns-nvim
  neogit

  # Editing
  luasnip
  nvim-autopairs
  nvim-cmp
  cmp-buffer
  cmp-nvim-lsp
  cmp-nvim-lsp-signature-help
  cmp-path
  cmp_luasnip

  #theme
  kanagawa-nvim

  # lsp stuff
  nvim-lspconfig
  nvim-metals
  rustaceanvim
  nvim-dap
  nvim-dap-ui
  conform-nvim
  haskell-tools-nvim
  nvim-jdtls

  # Other
  mini-nvim

  (nvim-treesitter.withPlugins (
    plugins: with plugins; [
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
    ]
  ))
]
