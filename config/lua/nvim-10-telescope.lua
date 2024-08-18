require("telescope.actions")
local open_with_trouble = require("trouble.sources.telescope").open

-- Use this to add more results without clearing the trouble list
local add_to_trouble = require("trouble.sources.telescope").add

local telescope = require("telescope")


telescope.setup {
  defaults = {
    mappings = {
      i = {
        ["<c-t>"] = open_with_trouble,
        ['<C-u>'] = false,
        ['<C-d>'] = false,
        ["<C-j>"] = require('telescope.actions').move_selection_next,
        ["<C-k>"] = require('telescope.actions').move_selection_previous,
      },
      n = { ["<c-t>"] = open_with_trouble },
    },
  },
}

vim.api.nvim_set_hl(0, "TelescopeNormal", { bg = "none" })
vim.api.nvim_set_hl(0, "TelescopeBorder", { bg = "none" })

vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' })
vim.keymap.set('n', '<leader>fb', require('telescope.builtin').buffers, { desc = '[ ] Find existing buffers' })
vim.keymap.set('n', '<leader>/', function()
  -- You can pass additional configuration to telescope to change theme, layout, etc.
  require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 10,
    previewer = false,
  })
end, { desc = '[/] Fuzzily search in current buffer]' })

vim.keymap.set('n', '<leader><space>', require('telescope.builtin').find_files, { desc = 'Search Files' })
vim.keymap.set('n', '<leader>fh', require('telescope.builtin').help_tags, { desc = 'Search Help' })
vim.keymap.set('n', '<leader>fw', require('telescope.builtin').grep_string, { desc = 'Search current Word' })
vim.keymap.set('v', '<leader>fw', require('telescope.builtin').grep_string, { desc = 'Search current Word' })
vim.keymap.set('n', '<leader>fg', require('telescope.builtin').live_grep, { desc = 'Search by Grep' })
vim.keymap.set('n', '<leader>fd', require('telescope.builtin').diagnostics, { desc = 'Search Diagnostics' })
