(fn gitsigns_on_attach [bufnr]
  (let [gs (package.loaded.gitsigns)]
    (fn map [mode l r opts]
      (set opts.buffer bufnr)
      (vim.keymap.set mode l r opts))

    ;; Navigation
    (map :n "]c"
         (fn []
           (if vim.wo.diff "]c"
               (vim.schedule (fn [] (gs.next_hunk))) :<Ignore>))
         {:expr true})
    (map :n "[c"
         (fn []
           (if vim.wo.diff "[c"
               (vim.schedule (fn [] (gs.prev_hunk))) :<Ignore>))
         {:expr true})
    ;; Actions
    (vim.keymap.set :n :<leader>hs gs.stage_hunk
                    {:desc "Stage Hunk" :buffer bufnr})
    (vim.keymap.set :n :<leader>hr gs.reset_hunk
                    {:desc "Reset Hunk" :buffer bufnr})
    (vim.keymap.set :v :<leader>hs
                    (fn [] (gs.stage_hunk {:vim.fn.line :v :vim.fn.line :v}))
                    {:desc "Stage Hunk in Visual Mode" :buffer bufnr})
    (vim.keymap.set :v :<leader>hr
                    (fn [] (gs.reset_hunk {:vim.fn.line :v :vim.fn.line :v}))
                    {:desc "Reset Hunk in Visual Mode" :buffer bufnr})
    (vim.keymap.set :n :<leader>hS gs.stage_buffer
                    {:desc "Stage Buffer" :buffer bufnr})
    (vim.keymap.set :n :<leader>hu gs.undo_stage_hunk
                    {:desc "Undo Stage Hunk" :buffer bufnr})
    (vim.keymap.set :n :<leader>hR gs.reset_buffer
                    {:desc "Reset Buffer" :buffer bufnr})
    (vim.keymap.set :n :<leader>hp gs.preview_hunk
                    {:desc "Preview Hunk" :buffer bufnr})
    (vim.keymap.set :n :<leader>hb (fn [] (gs.blame_line {:full true}))
                    {:desc "Blame Line" :buffer bufnr})
    (vim.keymap.set :n :<leader>tb gs.toggle_current_line_blame
                    {:desc "Toggle Current Line Blame" :buffer bufnr})
    (vim.keymap.set :n :<leader>hd gs.diffthis
                    {:desc "Diff This" :buffer bufnr})
    (vim.keymap.set :n :<leader>hD (fn [] (gs.diffthis "~"))
                    {:desc "Diff This with ~" :buffer bufnr})
    (vim.keymap.set :n :<leader>td gs.toggle_deleted
                    {:desc "Toggle Deleted" :buffer bufnr})
    ;; Text object
    (vim.keymap.set [:o :x] :ih ":<C-U>Gitsigns select_hunk<CR>"
                    {:desc "Select Hunk" :buffer bufnr})))

(let [gitsigns (require :gitsigns)]
  (gitsigns.setup {:signs {:add {:text "|"}
                           :change {:text "|"}
                           :delete {:text "-"}
                           :topdelete {:text "‾"}
                           :changedelete {:text "~"}
                           :untracked {:text "┆"}}
                   :signcolumn true
                   :numhl false
                   :linehl false
                   :word_diff false
                   :watch_gitdir {:follow_files false}
                   :attach_to_untracked true
                   :current_line_blame false
                   :current_line_blame_opts {:virt_text true
                                             :virt_text_pos :eol
                                             :delay 1000
                                             :ignore_whitespace false
                                             :virt_text_priority 100}
                   :current_line_blame_formatter "<author>, <author_time:%Y-%m-%d> - <summary>"
                   :sign_priority 6
                   :update_debounce 100
                   :status_formatter nil
                   :max_file_length 40000
                   :preview_config {:border :single
                                    :style :minimal
                                    :relative :cursor
                                    :row 0
                                    :col 1}
                   :on_attach gitsigns_on_attach}))

