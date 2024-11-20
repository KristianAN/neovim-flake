(require :telescope.actions)

(let [telescope (require :telescope)
      builtin (require :telescope.builtin)
      themes (require :telescope.themes)
      trouble (require :trouble.sources.telescope)]
  (vim.api.nvim_set_hl 0 :TelescopeNormal {:bg :none})
  (vim.api.nvim_set_hl 0 :TelescopeBorder {:bg :none})
  (vim.keymap.set :n :<leader>? builtin.oldfiles
                  {:desc "[?] Find recently opened files"})
  (vim.keymap.set :n :<leader>fb builtin.buffers
                  {:desc "[ ] Find existing buffers"})
  (vim.keymap.set :n :<leader>/
                  (fn []
                    ;; You can pass additional configuration to telescope to change theme, layout, etc.
                    (builtin.current_buffer_fuzzy_find (themes.get_dropdown {:previewer false})))
                  {:desc "[/] Fuzzily search in current buffer]"})
  (vim.keymap.set :n :<leader><space> builtin.find_files {:desc "Search Files"})
  (vim.keymap.set :n :<leader>fh builtin.help_tags {:desc "Search Help"})
  (vim.keymap.set :n :<leader>fw builtin.grep_string
                  {:desc "Search current Word"})
  (vim.keymap.set :v :<leader>fw builtin.grep_string
                  {:desc "Search current Word"})
  (vim.keymap.set :n :<leader>fg builtin.live_grep {:desc "Search by Grep"})
  (vim.keymap.set :n :<leader>fd builtin.diagnostics
                  {:desc "Search Diagnostics"})
  (telescope.setup {:defaults {:mappings {:i {:<c-t> trouble.open
                                              :<C-u> false
                                              :<C-d> false
                                              :<C-j> (let [actions (require :telescope.actions)]
                                                       actions.move_selection_next)
                                              :<C-k> (let [actions (require :telescope.actions)]
                                                       actions.move_selection_previous)}
                                          :n {:<c-t> trouble.open}}}}))
