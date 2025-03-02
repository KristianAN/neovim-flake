{ pkgs }:
let
  nvim-treesitter = (
    pkgs.vimPlugins.nvim-treesitter.withPlugins (plugins: [
      plugins.fsharp
      plugins.scala
      plugins.nix
      plugins.java
      plugins.haskell
      plugins.python
      plugins.rust
      plugins.javascript
      plugins.typescript
      plugins.lua
      plugins.yaml
      plugins.xml
      plugins.sql
      plugins.smithy
      plugins.dockerfile
      plugins.css
      plugins.kotlin
      plugins.c_sharp
      plugins.gleam
      plugins.clojure
      plugins.fennel
      plugins.org
    ])
  );

in
[
  # UI
  pkgs.vimPlugins.fzf-lua
  pkgs.vimPlugins.indent-blankline-nvim
  pkgs.vimPlugins.trouble-nvim
  pkgs.vimPlugins.nvim-web-devicons
  pkgs.vimPlugins.luatab-nvim
  pkgs.vimPlugins.quicker-nvim

  # Git
  pkgs.vimPlugins.gitsigns-nvim
  pkgs.vimPlugins.neogit
  pkgs.vimPlugins.diffview-nvim

  # Editing
  pkgs.vimPlugins.friendly-snippets
  pkgs.vimPlugins.blink-cmp

  # lsp stuff
  pkgs.vimPlugins.nvim-lspconfig
  pkgs.vimPlugins.nvim-metals
  pkgs.vimPlugins.rustaceanvim
  pkgs.vimPlugins.nvim-dap
  pkgs.vimPlugins.nvim-dap-ui
  pkgs.vimPlugins.conform-nvim
  pkgs.vimPlugins.conjure
  pkgs.vimPlugins.Ionide-vim
  pkgs.vimPlugins.nvim-jdtls

  # Other
  pkgs.vimPlugins.mini-nvim
  pkgs.vimPlugins.nfnl

]
++ [ nvim-treesitter ]
