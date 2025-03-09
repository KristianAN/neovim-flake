(let [conform (require :conform)]
  (conform.setup {:formatters_by_ft {:java [:google-java-format]
                                     :nix [:nixfmt]
                                     :rust [:rustfmt]
                                     :javascript [:prettierd]
                                     :typescript [:prettierd]
                                     :vue [:prettierd]
                                     :python [:black]
                                     :haskell [:formolu]
                                     :fennel [:fnlfmt]}
                  :format_on_save {; These options will be passed to conform.format()
                                   :timeout_ms 500
                                   :lsp_fallback true}}))
