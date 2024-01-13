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

  metals-pkg = metals {
    version = "1.2.0";
    outputHash = "sha256-nikQ/GFRWmYYzboc9TWIi9gd5kwgCxOLhvIEQWusFik=";
  };

in
''

-- LSP settings.
--  This function gets run when an LSP connects to a particular buffer.
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
  end,
  group = nvim_metals_group,
})
''