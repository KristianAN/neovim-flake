{ pkgs }:
let
in
with pkgs.vimPlugins; [
  # UI
  telescope-nvim
  indent-blankline-nvim
  lualine-nvim
  which-key-nvim
  trouble-nvim
  zen-mode-nvim
  nvim-web-devicons

  # Git
  gitsigns-nvim
  fugitive

  # GitHub
  octo-nvim

  # Completion
  nvim-cmp
  cmp-nvim-lsp
  cmp-buffer
  cmp-path
  cmp-cmdline
  luasnip

  # Editing
  nvim-autopairs
  nvim-ts-autotag

  #theme
  midnight-nvim

  # lsp stuff
  nvim-lspconfig
  nvim-jdtls
  nvim-metals
  rustaceanvim
  haskell-tools-nvim
  typescript-tools-nvim
  nvim-dap
  nvim-dap-ui

  # Other
  oil-nvim
  neorg

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
    ]))
]
