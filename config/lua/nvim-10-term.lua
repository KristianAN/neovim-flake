-- [nfnl] Compiled from nvim-10-term.fnl by https://github.com/Olical/nfnl, do not edit.
local M = {}
M.config = {width = 0.8, height = 0.7, winblend = 0, style = "minimal", border = "rounded"}
M.buf = nil
M.win = nil
M.setup = function(opts)
  local opts0 = (opts or {})
  M.config = vim.tbl_deep_extend("force", M.config, opts0)
  return nil
end
local function get_window_config()
  local float_width = math.floor((vim.o.columns * M.config.width))
  local float_height = math.floor((vim.o.lines * M.config.height))
  local row = math.floor(((vim.o.lines - float_height) / 2))
  local col = math.floor(((vim.o.columns - float_width) / 2))
  return {relative = "editor", row = row, col = col, width = float_width, height = float_height, style = M.config.style, border = M.config.border}
end
local function create_term_buf()
  if (M.buf and vim.api.nvim_buf_is_valid(M.buf)) then
    return M.buf
  else
    M.buf = vim.api.nvim_create_buf(false, true)
    return M.buf
  end
end
M.toggle = function()
  if (M.win and vim.api.nvim_win_is_valid(M.win)) then
    vim.api.nvim_win_close(M.win, true)
    M.win = nil
    return nil
  else
    M.buf = create_term_buf()
    if M.buf then
      M.win = vim.api.nvim_open_win(M.buf, true, get_window_config())
      vim.api.nvim_win_set_option(M.win, "winhighlight", "Normal:Normal,FloatBorder:Normal")
      if (vim.bo[M.buf].buftype ~= "terminal") then
        vim.cmd.terminal()
      else
      end
      return vim.cmd(":startinsert")
    else
      return nil
    end
  end
end
if not package.loaded["nvim-10-term"] then
  M.setup()
  local function _5_()
    return M.toggle()
  end
  vim.keymap.set("n", "<Leader>ts", _5_, {noremap = true, silent = true})
  local function _6_()
    return M.toggle()
  end
  return vim.api.nvim_create_user_command("TerminalToggle", _6_, {})
else
  return nil
end
