-- [nfnl] Compiled from nvim-10-gitsigns.fnl by https://github.com/Olical/nfnl, do not edit.
local function gitsigns_on_attach(bufnr)
  local gs = package.loaded.gitsigns
  local function map(mode, l, r, opts)
    opts.buffer = bufnr
    return vim.keymap.set(mode, l, r, opts)
  end
  local function _1_()
    if vim.wo.diff then
      return "]c"
    else
      local function _2_()
        return gs.next_hunk()
      end
      if vim.schedule(_2_) then
        return "<Ignore>"
      else
        return nil
      end
    end
  end
  map("n", "]c", _1_, {expr = true})
  local function _4_()
    if vim.wo.diff then
      return "[c"
    else
      local function _5_()
        return gs.prev_hunk()
      end
      if vim.schedule(_5_) then
        return "<Ignore>"
      else
        return nil
      end
    end
  end
  map("n", "[c", _4_, {expr = true})
  vim.keymap.set("n", "<leader>hs", gs.stage_hunk, {desc = "Stage Hunk", buffer = bufnr})
  vim.keymap.set("n", "<leader>hr", gs.reset_hunk, {desc = "Reset Hunk", buffer = bufnr})
  local function _7_()
    return gs.stage_hunk({["vim.fn.line"] = "v"})
  end
  vim.keymap.set("v", "<leader>hs", _7_, {desc = "Stage Hunk in Visual Mode", buffer = bufnr})
  local function _8_()
    return gs.reset_hunk({["vim.fn.line"] = "v"})
  end
  vim.keymap.set("v", "<leader>hr", _8_, {desc = "Reset Hunk in Visual Mode", buffer = bufnr})
  vim.keymap.set("n", "<leader>hS", gs.stage_buffer, {desc = "Stage Buffer", buffer = bufnr})
  vim.keymap.set("n", "<leader>hu", gs.undo_stage_hunk, {desc = "Undo Stage Hunk", buffer = bufnr})
  vim.keymap.set("n", "<leader>hR", gs.reset_buffer, {desc = "Reset Buffer", buffer = bufnr})
  vim.keymap.set("n", "<leader>hp", gs.preview_hunk, {desc = "Preview Hunk", buffer = bufnr})
  local function _9_()
    return gs.blame_line({full = true})
  end
  vim.keymap.set("n", "<leader>hb", _9_, {desc = "Blame Line", buffer = bufnr})
  vim.keymap.set("n", "<leader>tb", gs.toggle_current_line_blame, {desc = "Toggle Current Line Blame", buffer = bufnr})
  vim.keymap.set("n", "<leader>hd", gs.diffthis, {desc = "Diff This", buffer = bufnr})
  local function _10_()
    return gs.diffthis("~")
  end
  vim.keymap.set("n", "<leader>hD", _10_, {desc = "Diff This with ~", buffer = bufnr})
  vim.keymap.set("n", "<leader>td", gs.toggle_deleted, {desc = "Toggle Deleted", buffer = bufnr})
  return vim.keymap.set({"o", "x"}, "ih", ":<C-U>Gitsigns select_hunk<CR>", {desc = "Select Hunk", buffer = bufnr})
end
local gitsigns = require("gitsigns")
return gitsigns.setup({signs = {add = {text = "|"}, change = {text = "|"}, delete = {text = "-"}, topdelete = {text = "\226\128\190"}, changedelete = {text = "~"}, untracked = {text = "\226\148\134"}}, signcolumn = true, watch_gitdir = {follow_files = false}, attach_to_untracked = true, current_line_blame_opts = {virt_text = true, virt_text_pos = "eol", delay = 1000, virt_text_priority = 100, ignore_whitespace = false}, current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>", sign_priority = 6, update_debounce = 100, status_formatter = nil, max_file_length = 40000, preview_config = {border = "single", style = "minimal", relative = "cursor", row = 0, col = 1}, on_attach = gitsigns_on_attach, current_line_blame = false, linehl = false, numhl = false, word_diff = false})
