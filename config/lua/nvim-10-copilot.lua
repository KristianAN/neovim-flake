require("copilot").setup {
  server_opts_overrides = {
    trace = "verbose",
    settings = {
      advanced = {
        listCount = 10,         -- #completions for panel
        inlineSuggestCount = 3, -- #completions for getCompletions
      }
    },
  }
}

require("CopilotChat").setup {
  debug = true, -- Enable debugging
  -- See Configuration section for rest
}

vim.keymap.set({ 'n', 'v' }, '<leader>cc', '<cmd>CopilotChatToggle<cr>', { desc = "CopilotChat - Toggle" })
vim.keymap.set({ 'n', 'v' }, '<leader>cce', '<cmd>CopilotChatExplain<cr>', { desc = "CopilotChat - Explain code" })
vim.keymap.set({ 'n', 'v' }, '<leader>cct', '<cmd>CopilotChatTests<cr>', { desc = "CopilotChat - Generate tests" })
vim.keymap.set({ 'n', 'v' }, '<leader>ccf', '<cmd>CopilotChatFixDiagnostic<cr>',
  { desc = "CopilotChat - Fix diagnostic" })
vim.keymap.set({ 'n', 'v' }, '<leader>ccr', '<cmd>CopilotChatReset<cr>',
  { desc = "CopilotChat - Reset chat history and clear buffer" })
vim.keymap.set('n', '<leader>ccp', function()
  local actions = require("CopilotChat.actions")
  require("CopilotChat.integrations.telescope").pick(actions.prompt_actions())
end, { desc = 'CopilotChat - Prompt actions' })
vim.keymap.set("n", "<leader>ccq", function()
  local input = vim.fn.input("Quick Chat: ")
  if input ~= "" then
    require("CopilotChat").ask(input, { selection = require("CopilotChat.select").buffer })
  end
end, { desc = 'CopilotChat - Quick chat' })
