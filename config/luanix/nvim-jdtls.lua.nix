# Setup for Java language server
{ pkgs, ... }:
''
  local home = os.getenv('HOME')
  local root_markers = { 'gradlew', 'mvnw', '.git' }
  local root_dir = require('jdtls.setup').find_root(root_markers)
  local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
  local workspace_dir = home .. "/.local/share/eclipse/" .. vim.fn.fnamemodify(root_dir, ":p:h:t")
  local nvim_jdtls_group = vim.api.nvim_create_augroup("nvim-jdtls", { clear = true })
  local config = {
    cmd = { '${pkgs.jdt-language-server}/bin/jdt-language-server', '-data', workspace_dir },
    on_attach = Lsp_on_attach,
    root_dir = root_dir,
  }

  local nvim_jdtls_group = vim.api.nvim_create_augroup("nvim-jdtls", { clear = true })
  vim.api.nvim_create_autocmd(
    "FileType",
    {
      pattern = { "java" },
      callback = function()
        require('jdtls').start_or_attach(config)
      end,
      group = nvim_jdtls_group,
    }
  )
''
