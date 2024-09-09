(local config (require :nfnl.config))
(local default (config.default))

{:fnl-path->lua-path (fn [fnl-path]
                       (let [rel-fnl-path (vim.fn.fnamemodify fnl-path ":.")]
                         (default.fnl-path->lua-path (.. "./" rel-fnl-path))))}

