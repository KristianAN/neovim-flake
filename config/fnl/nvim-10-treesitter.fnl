(let [treesitter (require :nvim-treesitter.configs)]
  (treesitter.setup {:ensure_installed {}
                     :highlight {:enable true
                                 :additional_vim_regex_highlighting false}
                     :indent {:enable true}}))
