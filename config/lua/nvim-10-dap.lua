local dap = require('dap')

dap.configurations.java = {
  {
    type = 'java',
    request = 'attach',
    name = "Debug (Attach) - Remote",
    hostName = "127.0.0.1",
    port = 8000,
  },
}

vim.keymap.set('n', '<leader>dd',
  function() dap.toggle_breakpoint() end
  , { desc = 'Toggle breakpoint' })

vim.keymap.set('n', '<leader>du', function()
  require 'dapui'.open()
end, { desc = 'Debug' })

vim.keymap.set('n', '<leader>dc', function() dap.continue() end, { desc = "Start/continue debugging" })


require 'dapui'.setup {}
