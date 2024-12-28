(fn lsp_keybinds [event]
  (let [fzf (require :fzf-lua)
        map (fn [keys func desc]
              (vim.keymap.set :n keys func
                              {:buffer event.buf :desc (.. "LSP: " desc)}))]
    ;; Jump to the definition of the word under your cursor.
    (map :gd (fn []
               (fzf.lsp_definitions)) "[G]oto [D]efinition")
    ;; Find references for the word under your cursor.
    (map :gr (fn []
               (fzf.lsp_references)) "[G]oto [R]eferences")
    ;; Jump to the implementation of the word under your cursor.
    (map :gI (fn []
               (fzf.lsp_implementations))
         "[G]oto [I]mplementation")
    ;; Jump to the type of the word under your cursor.
    (map :<leader>D (fn []
                      (fzf.lsp_typedefs))
         "Type [D]efinition")
    ;; Fuzzy find all the symbols in your current document.
    (map :<leader>ds (fn []
                       (fzf.lsp_document_symbols))
         "[D]ocument [S]ymbols")
    ;; Fuzzy find all the symbols in your current workspace.
    (map :<leader>ws
         (fn []
           (fzf.lsp_dynamic_workspace_symbols)) "[W]orkspace [S]ymbols")
    ;; Rename the variable under your cursor.
    (map :<leader>rn (fn [] (vim.lsp.buf.rename)) "[R]e[n]ame")
    ;; Execute a code action.
    (map :<leader>ca (fn []
                       (vim.lsp.buf.code_action))
         "[C]ode [A]ction")
    ;; Opens a popup that displays documentation about the word under your cursor.
    (map :K (fn [] (vim.lsp.buf.hover)) "Hover Documentation")
    (map :<C-h> (fn []
                  (vim.lsp.buf.signature_help))
         "Signature [h]elp")
    ;; Goto Declaration.
    (map :gD (fn []
               (vim.lsp.buf.declaration)) "[G]oto [D]eclaration")
    (let [bufopts {:noremap true :silent true :buffer event.buf}]
      (vim.keymap.set :n :<space>e
                      (fn []
                        (vim.diagnostic.open_float))
                      bufopts {:desc "LSP: Display Error"}))
    (let [client (vim.lsp.get_client_by_id event.data.client_id)]
      (when (and client client.server_capabilities.documentHighlightProvider)
        (let [highlight_augroup (vim.api.nvim_create_augroup :kickstart-lsp-highlight
                                                             {:clear false})]
          (vim.api.nvim_create_autocmd [:CursorHold :CursorHoldI]
                                       {:buffer event.buf
                                        :group highlight_augroup
                                        :callback vim.lsp.buf.document_highlight})
          (vim.api.nvim_create_autocmd [:CursorMoved :CursorMovedI]
                                       {:buffer event.buf
                                        :group highlight_augroup
                                        :callback vim.lsp.buf.clear_references})
          (vim.api.nvim_create_autocmd :LspDetach
                                       {:group (vim.api.nvim_create_augroup :kickstart-lsp-detach
                                                                            {:clear true})
                                        :callback (fn [event2]
                                                    (vim.lsp.buf.clear_references)
                                                    (vim.api.nvim_clear_autocmds {:group :kickstart-lsp-highlight
                                                                                  :buffer event2.buf}))})))
      ;; Enable inlay hints if supported by the language server.
      (when (and client client.server_capabilities.inlayHintProvider
                 vim.lsp.inlay_hint)
        (map :<leader>th
             (fn []
               (vim.lsp.inlay_hint.enable (not (vim.lsp.inlay_hint.is_enabled))))
             "[T]oggle Inlay [H]ints"))
      (when (and client (= client.name :ionide))
        (set vim.lsp.codelens.on_codelens (fn [e r c] nil)))
      ;; Extend capabilities for completion.
      ;; client.server_capabilities.semanticTokensProvider = nil
      )))

(vim.api.nvim_create_autocmd :LspAttach
                             {:group (vim.api.nvim_create_augroup :UserLspConfig
                                                                  {:clear true})
                              :callback lsp_keybinds})

(local lsp (require :lspconfig))
(local capabilities (let [blink (require :blink.cmp)]
                      (blink.get_lsp_capabilities)))

(lsp.fennel_ls.setup {: capabilities})
(lsp.nixd.setup {: capabilities})
(lsp.clojure_lsp.setup {: capabilities})
(lsp.lua_ls.setup {: capabilities})
(lsp.basedpyright.setup {: capabilities})
(lsp.clangd.setup {: capabilities})
(lsp.hls.setup {: capabilities
                :cmd [:haskell-language-server-wrapper :--lsp]
                :filetypes [:haskell :lhaskell]})

(lsp.yamlls.setup {:settings {:yaml {:schemas {"https://raw.githubusercontent.com/oyvindberg/bleep/master/schema.json" :bleep.yaml}}}})
