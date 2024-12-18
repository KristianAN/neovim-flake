(let [kanagawa (require :kanagawa)]
  (kanagawa.setup {:compile false
                   :undercurl false
                   :commentStyle {:italic true}
                   :functionStyle {}
                   :keywordStyle {:italic true}
                   :statementStyle {:bold true}
                   :typeStyle {}
                   :transparent false
                   :dimInactive false
                   :terminalColors true
                   :colors {:palette {}
                            :theme {:wave {} :lotus {} :dragon {} :all {}}}
                   :theme :wave
                   :background {:dark :wave :light :lotus}}))
