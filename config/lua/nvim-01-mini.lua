-- [nfnl] Compiled from nvim-01-mini.fnl by https://github.com/Olical/nfnl, do not edit.
do
  local mini_notify = require("mini.notify")
  vim.cmd("au ColorScheme * highlight MiniNotifyNormal guibg=NONE")
  vim.cmd("au ColorScheme * highlight MiniNotifyTitle guibg=NONE")
  vim.cmd("au ColorScheme * highlight MiniNotifyBorder guibg=NONE")
  mini_notify.setup({lsp_progress = {enable = false}})
end
do
  local mini_files = require("mini.files")
  vim.cmd("au ColorScheme * highlight MiniFilesNormal guibg=NONE")
  vim.cmd("au ColorScheme * highlight MiniFilesTitle guibg=NONE")
  vim.cmd("au ColorScheme * highlight MiniFilesBorder guibg=NONE")
  mini_files.setup()
  local function _1_()
    return mini_files.open()
  end
  vim.keymap.set("n", "<leader>mr", _1_, {desc = "open file browser"})
  local function _2_()
    return mini_files.open(vim.api.nvim_buf_get_name(0))
  end
  vim.keymap.set("n", "<leader>mc", _2_, {desc = "open file browser in current dir"})
end
do
  local mini_misc = require("mini.misc")
  mini_misc.setup()
  mini_misc.setup_termbg_sync()
end
do
  local mini_statusline = require("mini.statusline")
  mini_statusline.setup()
end
local mini_ai = require("mini.ai")
return mini_ai.setup()
