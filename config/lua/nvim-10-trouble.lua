require('trouble').setup {}
vim.keymap.set("n", "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", { desc = 'Trouble' })
vim.keymap.set("n", "<leader>xX",
  "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
  { desc = "Buffer Diagnostics (Trouble)" })
vim.keymap.set("n", "<leader>xq", "<cmd>Trouble lsp toggle focus=false win.position=right<cr>", { desc = 'Quickfix' })
vim.keymap.set("n", "<leader>xl", "<cmd>Trouble loclist toggle<cr>", { desc = 'Location list' })
vim.keymap.set("n", "gR", "<cmd>Trouble lsp toggle focus=false win.position=right<cr>", { desc = 'Search Diagnostic' })
