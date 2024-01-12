local function zen_mode()
  require("zen-mode").toggle({
    window = {
      width = .85 -- width will be 85% of the editor width
    }
  })
end

vim.keymap.set('n', '<leader>Z', zen_mode, { desc = 'Zen mode' })
