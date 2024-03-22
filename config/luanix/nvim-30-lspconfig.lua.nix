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
    version = "1.2.2";
    outputHash = "sha256-xk2ionn/lBV8AR7n7OR03UuRCoP1/K6KuohhpRwFock=";
  };

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

  require("typescript-tools").setup {
    on_attach = Lsp_on_attach,
    settings = {
      -- spawn additional tsserver instance to calculate diagnostics on it
      separate_diagnostic_server = true,
      -- "change"|"insert_leave" determine when the client asks the server about diagnostic
      publish_diagnostic_on = "insert_leave",
      expose_as_code_action = "all",
      -- string|nil - specify a custom path to `tsserver.js` file, if this is nil or file under path
      -- not exists then standard path resolution strategy is applied
      tsserver_path = "${tsserver}/lib/node_modules/typescript/lib",
      -- specify a list of plugins to load by tsserver, e.g., for support `styled-components`
      -- (see 💅 `styled-components` support section)
      tsserver_plugins = {},
      tsserver_max_memory = "auto",
      -- described below
      tsserver_format_options = {},
      tsserver_file_preferences = {
        includeInlayParameterNameHints = "all",
        includeInlayParameterNameHintsWhenArgumentMatchesName = true,
        includeInlayFunctionParameterTypeHints = true,
        includeInlayVariableTypeHints = true,
        includeInlayVariableTypeHintsWhenTypeMatchesName = true,
        includeInlayPropertyDeclarationTypeHints = true,
        includeInlayFunctionLikeReturnTypeHints = true,
        includeInlayEnumMemberValueHints = true,
      },
      tsserver_locale = "en",
      -- mirror of vscode's `typescript.suggest.completefunctioncalls`
      complete_function_calls = false,
      include_completions_with_insert_text = true,
      -- codelens
      -- warning: experimental feature also in vscode, because it might hit performance of server.
      -- possible values: ("off"|"all"|"implementations_only"|"references_only")
      code_lens = "off",
      -- by default code lenses are displayed on all referencable values and for some of you it can
      -- be too much this option reduce count of them by removing member references from lenses
      disable_member_code_lens = true,
    },
  }
''
