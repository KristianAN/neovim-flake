(let [mini_notify (require :mini.notify)]
  (vim.cmd "au ColorScheme * highlight MiniNotifyNormal guibg=NONE")
  (vim.cmd "au ColorScheme * highlight MiniNotifyTitle guibg=NONE")
  (vim.cmd "au ColorScheme * highlight MiniNotifyBorder guibg=NONE")
  (mini_notify.setup {:lsp_progress {:enable false}
                      :window {:config {} :winblend 0}}))

(let [mini_files (require :mini.files)]
  (vim.cmd "au ColorScheme * highlight MiniFilesNormal guibg=NONE")
  (vim.cmd "au ColorScheme * highlight MiniFilesTitle guibg=NONE")
  (vim.cmd "au ColorScheme * highlight MiniFilesBorder guibg=NONE")
  (mini_files.setup {:window {:config {} :winblend 0}})
  (vim.keymap.set :n :<leader>or (fn [] (mini_files.open))
                  {:desc "open file browser"})
  (vim.keymap.set :n :<leader>oc
                  (fn []
                    (mini_files.open (vim.api.nvim_buf_get_name 0)))
                  {:desc "open file browser in current dir"}))

(let [mini_misc (require :mini.misc)]
  (mini_misc.setup)
  (mini_misc.setup_termbg_sync))

(let [mini_surround (require :mini.surround)]
  (mini_surround.setup))

(let [mini_statusline (require :mini.statusline)]
  (mini_statusline.setup))

