{ pkgs }:
let
  treesitter-fsharp-grammar = pkgs.tree-sitter.buildGrammar {
    language = "fsharp";
    version = "0.0.0+rev=f54ac4e";

    src = pkgs.fetchFromGitHub {
      owner = "ionide";
      repo = "tree-sitter-fsharp";
      rev = "f54ac4e66843b5af4887b586888e01086646b515";
      hash = "sha256-zKfMfue20B8sbS1tQKZAlokRV7efMsxBk7ySQmzLo0Y=";
    };

    fixupPhase = ''
      mkdir -p $out/queries/fsharp
      mv $out/queries/*.scm $out/queries/fsharp/
    '';

    meta.homepage = "https://github.com/ionide/tree-sitter-fsharp";
  };

  nvim-treesitter = (
    pkgs.vimPlugins.nvim-treesitter.withPlugins (
      plugins:
      [
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
      ]
      ++ [ treesitter-fsharp-grammar ]
    )
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

  #theme
  pkgs.vimPlugins.kanagawa-nvim
  pkgs.vimPlugins.modus-themes-nvim

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
  pkgs.vimPlugins.project-nvim

]
++ [ nvim-treesitter ]
