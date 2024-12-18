(let [blink (require :blink.cmp)]
  (blink.setup {:appearance {:nerd_font_variant :normal
                             :use_nvim_cmp_as_default true}
                :signature {:enabled true}}))
