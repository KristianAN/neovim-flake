(local luasnip (require :luasnip))

(let [autopairs (require :nvim-autopairs)]
  (autopairs.setup {}))

(local cmp_autopairs (require :nvim-autopairs.completion.cmp))

(luasnip.config.setup {})
(let [cmp (require :cmp)]
  (cmp.event:on :confirm_done (cmp_autopairs.on_confirm_done))
  (cmp.setup {:snippet {:expand (fn [args]
                                  (luasnip.lsp_expand args.body))}
              :formatting {:format (fn [_ item]
                          (set item.abbr (string.sub item.abbr 1 20))
                          item)}
              :completion {:completeopt "menu,menuone,noinsert"}
              ;; For an understanding of why these mappings were
              ;; chosen, you will need to read `:help ins-completion`
              ;;
              ;; No, but seriously. Please read `:help ins-completion`, it is really good!
              :mapping (cmp.mapping.preset.insert {;; Select the [n]ext item
                                                   :<C-n> (cmp.mapping.select_next_item)
                                                   ;; Select the [p]revious item
                                                   :<C-p> (cmp.mapping.select_prev_item)
                                                   ;; Scroll the documentation window [b]ack / [f]orward
                                                   :<C-b> (cmp.mapping.scroll_docs -4)
                                                   :<C-f> (cmp.mapping.scroll_docs 4)
                                                   ;; Accept ([y]es) the completion.
                                                   ;;  This will auto-import if your LSP supports it.
                                                   ;;  This will expand snippets if the LSP sent a snippet.
                                                   :<C-y> (cmp.mapping.confirm {:select true})
                                                   ;; If you prefer more traditional completion keymaps,
                                                   ;; you can uncomment the following lines
                                                   ;;["<CR>"] (cmp.mapping.confirm {:select true})
                                                   ;;["<Tab>"] (cmp.mapping.select_next_item)
                                                   ;;["<S-Tab>"] (cmp.mapping.select_prev_item)
                                                   ;; Manually trigger a completion from nvim-cmp.
                                                   ;;  Generally you don't need this, because nvim-cmp will display
                                                   ;;  completions whenever it has completion options available.
                                                   :<C-Space> (cmp.mapping.complete {})
                                                   ;; Think of <c-l> as moving to the right of your snippet expansion.
                                                   ;;  So if you have a snippet that's like:
                                                   ;;  function $name($args)
                                                   ;;    $body
                                                   ;;  end
                                                   ;;
                                                   ;; <c-l> will move you to the right of each of the expansion locations.
                                                   ;; <c-h> is similar, except moving you backwards.
                                                   :<C-l> (cmp.mapping (fn []
                                                                         (when (luasnip.expand_or_locally_jumpable)
                                                                           (luasnip.expand_or_jump)))
                                                                       {:i true
                                                                        :s true})
                                                   :<C-h> (cmp.mapping (fn []
                                                                         (when (luasnip.locally_jumpable -1)
                                                                           (luasnip.jump -1)))
                                                                       {:i true
                                                                        :s true})
                                                   ;; For more advanced Luasnip keymaps (e.g. selecting choice nodes, expansion) see:
                                                   ;;    https://github.com/L3MON4D3/LuaSnip?tab=readme-ov-file#keymaps
                                                   })
              :sources [{:name :nvim_lsp}
                        {:name :nvim_lsp_signature_help}
                        {:name :luasnip}
                        {:name :path}
                        {:name :orgmode}
                        {:name :buffer}]}))
