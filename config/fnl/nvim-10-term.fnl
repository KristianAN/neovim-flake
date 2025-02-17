(let [M {}]
  (set M.config {:width 0.8
                 :height 0.7
                 :winblend 0
                 :style :minimal
                 :border :rounded})
  (set M.buf nil)
  (set M.win nil)

  (fn M.setup [opts]
    (let [opts (or opts {})]
      (set M.config (vim.tbl_deep_extend :force M.config opts))))

  (fn get_window_config []
    (let [float-width (math.floor (* vim.o.columns M.config.width))
          float-height (math.floor (* vim.o.lines M.config.height))
          row (math.floor (/ (- vim.o.lines float-height) 2))
          col (math.floor (/ (- vim.o.columns float-width) 2))]
      {:relative :editor
       : row
       : col
       :width float-width
       :height float-height
       :style M.config.style
       :border M.config.border}))

  (fn create_term_buf []
    (if (and M.buf (vim.api.nvim_buf_is_valid M.buf)) M.buf
        (do
          (set M.buf (vim.api.nvim_create_buf false true))
          M.buf)))

  (fn M.toggle []
    (if (and M.win (vim.api.nvim_win_is_valid M.win))
        (do
          (vim.api.nvim_win_close M.win true)
          (set M.win nil))
        (do
          (set M.buf (create_term_buf))
          (when M.buf
            (set M.win (vim.api.nvim_open_win M.buf true (get_window_config)))
            (vim.api.nvim_win_set_option M.win :winhighlight
                                         "Normal:Normal,FloatBorder:Normal")
            (when (not= (. (. vim.bo M.buf) :buftype) :terminal)
              (vim.cmd.terminal))
            (vim.cmd ":startinsert")))))

  (when (not (. package.loaded :nvim-10-term))
    (M.setup)
    (vim.keymap.set :n :<Leader>ts (fn [] (M.toggle))
                    {:noremap true :silent true})
    (vim.api.nvim_create_user_command :TerminalToggle (fn [] (M.toggle)) {})))
