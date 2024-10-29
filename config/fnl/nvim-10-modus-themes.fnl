(let [kanagawa (require :modus-themes)]
  (kanagawa.setup {:style "auto"
                   :transparent false
                   :variant "tritanopia"
                   :dimInactive false}))

(vim.cmd "colorscheme modus")

