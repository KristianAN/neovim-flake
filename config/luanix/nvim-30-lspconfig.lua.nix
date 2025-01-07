{ pkgs, lib }:
let
  metals =
    { version, outputHash }:
    let
      metalsDeps = pkgs.stdenv.mkDerivation {
        name = "metals-deps-${version}";
        buildCommand = ''
          export COURSIER_CACHE=$(pwd)
          ${pkgs.coursier}/bin/cs fetch org.scalameta:metals_2.13:${version} \
            -r bintray:scalacenter/releases \
            -r sonatype:snapshots > deps
          mkdir -p $out/share/java
          cp -n $(< deps) $out/share/java/
        '';
        outputHashMode = "recursive";
        outputHashAlgo = "sha256";
        inherit outputHash;
      };
    in
    pkgs.metals.overrideAttrs (old: {
      inherit version;
      extraJavaOpts = old.extraJavaOpts + " -Dmetals.client=nvim-lsp";
      buildInputs = [ metalsDeps ];
      jre = pkgs.temurin-bin-21;
    });

  omnisharp = pkgs.omnisharp-roslyn;
  tsserver = pkgs.nodePackages.typescript-language-server;
  metals-pkg = metals {
    version = "1.4.2";
    outputHash = "sha256-bvdLEHJgtLAu7C/jLMpcmFOVqASPNbiyN3q4qtYL3ls=";
  };

in
# lua
''
    local capabilities = require('blink.cmp').get_lsp_capabilities()
    ----------------------------------------------------
    -- Metals
    ----------------------------------------------------
    local metals_config = require("metals").bare_config()

    metals_config.settings = {
      metalsBinaryPath = "${metals-pkg}/bin/metals",
      showImplicitArguments = true,
      showImplicitConversionsAndClasses = true,
      showInferredType = true,
      excludedPackages = {}
    }

    -- Example if you are using cmp how to make sure the correct capabilities for snippets are set
    metals_config.capabilities = capabilities

    -- Autocmd that will actually be in charging of starting the whole thing
    local nvim_metals_group = vim.api.nvim_create_augroup("nvim-metals", { clear = true })

    vim.api.nvim_create_autocmd("FileType", {
      -- NOTE: You may or may not want java included here. You will need it if you
      -- want basic Java support but it may also conflict if you are using
      -- something like nvim-jdtls which also works on a java filetype autocmd.
      pattern = { "scala", "sbt", "bleep.yaml" },

      callback = function()
        require("metals").initialize_or_attach(metals_config)
        require("metals").setup_dap()
      end,

      group = nvim_metals_group,
    })

    ----------------------------------------------------
    -- Omnisharp
    ----------------------------------------------------

    require'lspconfig'.omnisharp.setup {
       capabilities = capabilities,
       cmd = { "dotnet", "${omnisharp}/lib/omnisharp-roslyn/OmniSharp.dll" },
       enable_editorconfig_support = true,
       enable_ms_build_load_projects_on_demand = false,
       enable_roslyn_analyzers = false,
       organize_imports_on_format = false,
       enable_import_completion = false,
       sdk_include_prereleases = true,
       analyze_open_documents_only = false,
    }

    ----------------------------------------------------
    -- VueJS
    ----------------------------------------------------
    require'lspconfig'.volar.setup{
      capabilities = capabilities,
      filetypes = {'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue', 'json'}
    }

    ----------------------------------------------------
    -- TypeScript
    ----------------------------------------------------
    require("lspconfig").ts_ls.setup {
      capabilities = capabilities,
      cmd = {"${tsserver}/bin/typescript-language-server", "--stdio"},
      filetypes = {
      "javascript",
      "typescript",
      "vue",
      },

      init_options = {
        plugins = { -- I think this was my breakthrough that made it work
          {
            name = "@vue/typescript-plugin",
            location = "${lib.getBin pkgs.vue-language-server}/lib/node_modules/@vue/language-server",
            languages = { "vue" },
          },
        },
      }
    }

    vim.g.rustaceanvim = { capabilities = capabilities }

  require 'lspconfig'.gleam.setup { capabilities = capabilities }


''
