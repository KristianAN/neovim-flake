(let [fzf (require :fzf-lua)]
  (fzf.setup {:fzf_opts {:--layout :reverse-list}
              :keymap {:fzf {:ctrl-q :select-all+accept}}
              :winopts {:preview {:layout :vertical :vertical "up:70%"}}})
  (vim.keymap.set :n :<leader><space> fzf.files {:desc "Search Files"})
  (vim.keymap.set :n :<leader>? fzf.oldfiles
                  {:desc "[?] Find recently opened files"})
  (vim.keymap.set :n :<leader>fb fzf.buffers
                  {:desc "[ ] Find existing buffers"})
  (vim.keymap.set :n :<leader>/ fzf.grep_curbuf
                  {:desc "[/] Fuzzily search in current buffer]"})
  (vim.keymap.set :n :<leader>fw fzf.grep_cword {:desc "Search current Word"})
  (vim.keymap.set :v :<leader>fv fzf.grep_visual {:desc "Search current Word"})
  (vim.keymap.set :n :<leader>fg fzf.live_grep_glob {:desc "Search by Grep"})
  (vim.keymap.set :n :<leader>fd fzf.diagnostics_workspace
                  {:desc "Search Diagnostics"}))
