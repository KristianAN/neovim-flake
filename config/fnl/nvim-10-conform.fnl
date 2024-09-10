(let [conform (require :conform)]
  conform.setup
  {:formatters_by_ft {:java [:google-java-format]
                      :nix [:nixfmt]
                      :haskell [:ormolu]
                      :rust [:rustfmt]
                      :javascript [:prettierd]
                      :typescript [:prettierd]
                      :python [:black]
                      :fennel [:fnlfmt]}
   :format_on_save {; These options will be passed to conform.format()
                    :timeout_ms 500
                    :lsp_fallback true}})
