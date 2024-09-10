(let [kanagawa (require :kanagawa)]
  (kanagawa.setup {:compile false
                   :undercurl false
                   :commentStyle {:italic true}
                   :functionStyle {}
                   :keywordStyle {:italic true}
                   :statementStyle {:bold true}
                   :typeStyle {}
                   :transparent true
                   :dimInactive false
                   :terminalColors true
                   :colors {:palette {}
                            :theme {:wave {} :lotus {} :dragon {} :all {}}}
                   :theme :dragon
                   :background {:dark :dragon :light :lotus}}))

(vim.cmd "colorscheme kanagawa")