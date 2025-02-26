(local Direnv {})

(fn check_executable [executable_name]
  (if (= (vim.fn.executable executable_name) 1)
      true
      (do
        (vim.notify (.. "Executable '" executable_name "' not found")
                    vim.log.levels.ERROR)
        false)))

(fn setup_keymaps [keymaps mode]
  (each [_ map (ipairs keymaps)]
    (let [options (vim.tbl_extend :force {:noremap true :silent true}
                                  (or (. map 3) {}))]
      (vim.keymap.set mode (. map 1) (. map 2) options))))

(fn Direnv.direnv_allow []
  (print "Allowing direnv...")
  (os.execute "direnv allow"))

(fn Direnv.direnv_deny []
  (print "Denying direnv")
  (os.execute "direnv deny"))

(fn Direnv._get_rc_status [_on_exit]
  (let [on_exit (fn [obj]
                  (let [status (vim.json.decode obj.stdout)]
                    (if (= status.state.foundRC nil)
                        (_on_exit nil nil)
                        (_on_exit status.state.foundRC.allowed
                                  status.state.foundRC.path))))]
    (vim.system [:direnv :status :--json]
                {:text true :cwd (vim.fn.getcwd -1 -1)} on_exit)))

(fn Direnv._init [path]
  (vim.schedule (fn [] (vim.notify (.. "Reloading " path))))
  (let [cwd (vim.fs.dirname path)
        on_exit (fn [obj]
                  (vim.schedule (fn []
                                  (vim.fn.execute (icollect [_ v (ipairs (vim.fn.split obj.stdout
                                                                                       "call setenv"))]
                                                    (.. "call setenv" v))))))]
    (vim.system [:direnv :export :vim] {:text true : cwd} on_exit)))

(fn Direnv.check_direnv []
  (do
    (vim.notify "running check")
    (let [on_exit (fn [status path]
                    (when (not (or (= path nil) (= status nil)))
                      (case status
                        0 (Direnv._init path)
                        2 nil
                        _ (vim.schedule (fn []
                                          (let [choice (vim.fn.confirm (.. path
                                                                           " is blocked."
                                                                           "&Allow &Block &Ignore"
                                                                           3))]
                                            (case choice
                                              1 (do
                                                  (Direnv.direnv_allow)
                                                  (Direnv._init))
                                              2 (Direnv._init))))))))]
      (Direnv._get_rc_status on_exit))))

(fn Direnv.setup [user_config]
  (let [config (vim.tbl_deep_extend :force
                                    {:bin :direnv
                                     :autoload_direnv false
                                     :keybindings {:allow :<Leader>da
                                                   :deny :<Leader>dd
                                                   :reload :<Leader>dr}}
                                    (or user_config {}))]
    (if (not (check_executable config.bin))
        nil
        (do
          (vim.api.nvim_create_user_command :Direnv
                                            (fn [opts]
                                              (let [cmds {:allow Direnv.direnv_allow
                                                          :deny Direnv.direnv_deny
                                                          :reload Direnv.check_direnv}
                                                    cmd (. cmds
                                                           (string.lower (. opts.fargs
                                                                            1)))]
                                                (when (cmd) (cmd))))
                                            {:nargs 1
                                             :complete (fn []
                                                         [:allow :deny :reload])})
          (setup_keymaps [[config.keybindings.allow
                           Direnv.direnv_allow
                           {:desc "Allow direnv"}]
                          [config.keybindings.deny
                           Direnv.direnv_deny
                           {:desc "Deny direnv"}]
                          [config.keybindings.reload
                           Direnv.check_direnv
                           {:desc "Reload direnv"}]]
                         :n)
          (let [group_id (vim.api.nvim_create_augroup :DirenvNvim {})]
            (when (and config.autoload_direnv
                       (not= (vim.fn.glob :**/.envrc) ""))
              (vim.api.nvim_create_autocmd [:DirChanged]
                                           {:pattern "*"
                                            :group group_id
                                            :callback Direnv.check_direnv})))))))

(Direnv.setup {})
