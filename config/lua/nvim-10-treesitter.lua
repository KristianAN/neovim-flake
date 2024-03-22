require('nvim-ts-autotag').setup()
require 'nvim-treesitter.configs'.setup {
  ensure_installed = {},
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
  indent = {
    enable = true
  },
  autotag = {
    enable = true,
  }
}
