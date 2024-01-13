# Setup for Java language server
{ pkgs, ... }:
''
  local config = {
      cmd = {${pkgs.jdt-language-server}/bin/jdt-language-server},
      root_dir = vim.fs.dirname(vim.fs.find({'gradlew', '.git', 'mvnw', 'pom.xml'}, { upward = true })[1]),
      on_attach = Lsp_on_attach
  }
  require('jdtls').start_or_attach(config)
''
