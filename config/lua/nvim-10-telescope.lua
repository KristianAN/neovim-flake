-- [nfnl] Compiled from nvim-10-telescope.fnl by https://github.com/Olical/nfnl, do not edit.
require("telescope.actions")
local telescope = require("telescope")
local builtin = require("telescope.builtin")
local themes = require("telescope.themes")
local trouble = require("trouble.sources.telescope")
vim.api.nvim_set_hl(0, "TelescopeNormal", {bg = "none"})
vim.api.nvim_set_hl(0, "TelescopeBorder", {bg = "none"})
vim.keymap.set("n", "<leader>?", builtin.oldfiles, {desc = "[?] Find recently opened files"})
vim.keymap.set("n", "<leader>fb", builtin.buffers, {desc = "[ ] Find existing buffers"})
local function _1_()
  return builtin.current_buffer_fuzzy_find(themes.get_dropdown({winblend = 10, previewer = false}))
end
vim.keymap.set("n", "<leader>/", _1_, {desc = "[/] Fuzzily search in current buffer]"})
vim.keymap.set("n", "<leader><space>", builtin.find_files, {desc = "Search Files"})
vim.keymap.set("n", "<leader>fh", builtin.help_tags, {desc = "Search Help"})
vim.keymap.set("n", "<leader>fw", builtin.grep_string, {desc = "Search current Word"})
vim.keymap.set("v", "<leader>fw", builtin.grep_string, {desc = "Search current Word"})
vim.keymap.set("n", "<leader>fg", builtin.live_grep, {desc = "Search by Grep"})
vim.keymap.set("n", "<leader>fd", builtin.diagnostics, {desc = "Search Diagnostics"})
local _2_
do
  local actions = require("telescope.actions")
  _2_ = actions.move_selection_next
end
local _3_
do
  local actions = require("telescope.actions")
  _3_ = actions.move_selection_previous
end
return telescope.setup({defaults = {mappings = {i = {["<c-t>"] = trouble.open, ["<C-j>"] = _2_, ["<C-k>"] = _3_, ["<C-d>"] = false, ["<C-u>"] = false}, n = {["<c-t>"] = trouble.open}}}})
