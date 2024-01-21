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

vim.keymap.set('n', '<leader>dd', function()
  require 'dap'.toggle_breakpoint()
end, { desc = 'Toggle breakpoint' })

vim.keymap.set('n', '<leader>D', function()
  require 'dapui'.open()
end, { desc = 'Debug' })

require 'dapui'.setup {}
