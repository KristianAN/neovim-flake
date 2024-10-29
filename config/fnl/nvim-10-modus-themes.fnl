(let [kanagawa (require :modus-themes)]
  (kanagawa.setup {:style "auto"
                   :transparent false
                   :variant "deuteranopia"
                   :dimInactive false}))

(vim.cmd "colorscheme ")

