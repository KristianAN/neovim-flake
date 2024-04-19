{ pkgs }:
let
  metals = { version, outputHash }:
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
    });

  omnisharp = pkgs.omnisharp-roslyn;
  tsserver = pkgs.nodePackages.typescript-language-server;
  metals-pkg = metals {
    version = "1.3.0";
    outputHash = "sha256-otN4sqV2a0itLOoJ7x+VSMe0tl3y4WVovbA1HOpZVDw=";
  };
  volar = pkgs.nodePackages.volar;

in
  /*
    lua
  */
''
  ----------------------------------------------------
  -- Metals
  ----------------------------------------------------
  local metals_config = require("metals").bare_config()

  -- Example of settings
  metals_config.settings = {
    metalsBinaryPath = "${metals-pkg}/bin/metals",
    showImplicitArguments = true,
    showImplicitConversionsAndClasses = true,
    showInferredType = true,
    excludedPackages = {}
  }

  metals_config.on_attach = Lsp_on_attach

  -- *READ THIS*
  -- I *highly* recommend setting statusBarProvider to true, however if you do,
  -- you *have* to have a setting to display this in your statusline or else
  -- you'll not see any messages from metals. There is more info in the help
  -- docs about this
  -- metals_config.init_options.statusBarProvider = "on"

  -- Example if you are using cmp how to make sure the correct capabilities for snippets are set
  metals_config.capabilities = require("cmp_nvim_lsp").default_capabilities()

  -- Autocmd that will actually be in charging of starting the whole thing
  local nvim_metals_group = vim.api.nvim_create_augroup("nvim-metals", { clear = true })

  vim.api.nvim_create_autocmd("FileType", {
    -- NOTE: You may or may not want java included here. You will need it if you
    -- want basic Java support but it may also conflict if you are using
    -- something like nvim-jdtls which also works on a java filetype autocmd.
    pattern = { "scala", "sbt" },
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
     on_attach = Lsp_on_attach,
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
  -- TypeScript
  ----------------------------------------------------
  -- pkgs.nodePackages.typescript-language-server;
  require("lspconfig").voalar.setup {
    on_attach = Lsp_on_attach,
    cmd = {"${volar}/bin/vue-language-server", "--stdio"}
  }

  require("lspconfig").tsserver.setup {
    on_attach = Lsp_on_attach,
    cmd = {"${tsserver}/bin/typescript-language-server", "--stdio"},
    filetypes = {
    "javascript",
    "typescript",
    "vue",
    },
    init_options = {
      plugins = {
        {
          name = "@vue/typescript-plugin",
          location = "${vuels}/node_modules/@vue/typescript-plugin",
          languages = {"javascript", "typescript", "vue"},
        },
      }
    }
  }
''
