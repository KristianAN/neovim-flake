-- [nfnl] Compiled from nvim-01-mini.fnl by https://github.com/Olical/nfnl, do not edit.
do
  local mini_notify = require("mini.notify")
  vim.cmd("au ColorScheme * highlight MiniNotifyNormal guibg=NONE")
  vim.cmd("au ColorScheme * highlight MiniNotifyTitle guibg=NONE")
  vim.cmd("au ColorScheme * highlight MiniNotifyBorder guibg=NONE")
  mini_notify.setup({window = {config = {}, winblend = 0}})
end
do
  local mini_files = require("mini.files")
  mini_files.setup({window = {config = {}, winblend = 0}})
  local function _1_()
    return mini_files.open()
  end
  vim.keymap.set("n", "<leader>or", _1_, {desc = "open file browser"})
  local function _2_()
    return mini_files.open(vim.api.nvim_buf_get_name(0))
  end
  vim.keymap.set("n", "<leader>oc", _2_, {desc = "open file browser in current dir"})
end
do
  local mini_surround = require("mini.surround")
  mini_surround.setup()
end
do
  local mini_statusline = require("mini.statusline")
  mini_statusline.setup()
end
vim.cmd("au ColorScheme * highlight MiniFilesNormal guibg=NONE")
vim.cmd("au ColorScheme * highlight MiniFilesTitle guibg=NONE")
return vim.cmd("au ColorScheme * highlight MiniFilesBorder guibg=NONE")