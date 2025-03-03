# Setup for Java language server
{ pkgs, ... }:
# lua
''
  local home = os.getenv("HOME")
  local jdtls = require('jdtls')
  local root_markers = { ".git", "mvnw", "gradlew", "pom.xml", "build.gradle", ".project" }
  local root_dir = jdtls.setup.find_root(root_markers)
  -- Function to set root_dir to the parent directory of the .git folder
  local function get_root_dir()
    return require('lspconfig').util.root_pattern(unpack(root_markers))(vim.fn.expand('%:p:h'))
  end
  local workspace_folder = home .. "/.cache/jdtls/" .. vim.fn.fnamemodify(root_dir, ":p:h:t")
  local jdtls_config_dir = home .. "/.config/jdtls_config"
  os.execute("mkdir -p " .. jdtls_config_dir)
  -- Copy from nix store to config dir
  os.execute("cp -r ${pkgs.jdt-language-server}/config_linux/* " .. jdtls_config_dir)
  local config = {
    cmd = {
      "${pkgs.jdt-language-server}/bin/jdtls",
      "-Declipse.application=org.eclipse.jdt.ls.core.id1",
      "-Dosgi.bundles.defaultStartLevel=4",
      "-Dosgi.sharedConfiguration.area=${pkgs.jdt-language-server}/share/config",
      "-Declipse.product=org.eclipse.jdt.ls.core.product",
      "-Dlog.protocol=true",
      "-Dlog.level=ALL",
      "-Xms1g",
      "--add-modules=ALL-SYSTEM",
      "--add-opens",
      "java.base/java.util=ALL-UNNAMED",
      "--add-opens",
      "java.base/java.lang=ALL-UNNAMED",
      "-jar",
      "-configuration", jdtls_config_dir,
      "-data", workspace_folder,
    };
    root_dir = get_root_dir();
    init_options = {
      bundles = {
        vim.fn.glob("${pkgs.vscode-extensions.vscjava.vscode-java-debug}/share/vscode/extensions/vscjava.vscode-java-debug/server/com.microsoft.java.debug.plugin-*.jar", 1),
        vim.fn.glob("${pkgs.vscode-extensions.vscjava.vscode-java-test}/share/vscode/extensions/vscjava.vscode-java-test/server/*.jar", 1)
      };
    };
    settings = {
      java = {
        referencesCodeLens = {enabled = true};
        signatureHelp = { enabled = true };
        implementationsCodeLens = { enabled = true };
        contentProvider = { preferred = 'fernflower' };
      },
    };
    filetypes = { "java" };
  }

  local capabilities = require('blink.cmp').get_lsp_capabilities()

  config.capabilities = capabilities

  config.on_init = function(client, _)
    client.notify('workspace/didChangeConfiguration', { settings = config.settings })
  end
  local nvim_jdtls_group = vim.api.nvim_create_augroup("nvim-jdtls", { clear = true })
  vim.api.nvim_create_autocmd(
    "FileType",
    {
      pattern = { "java" },
      callback = function()
        require('jdtls').start_or_attach(config)
      end,
      group = nvim_jdtls_group,
    })
''
