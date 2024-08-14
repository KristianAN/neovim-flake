require('trouble').setup {}

vim.keymap.set("n", "<leader>xx", function() require("trouble").toggle() end, { desc = "Trouble: toggle" })
vim.keymap.set("n", "<leader>xw", function() require("trouble").toggle("workspace_diagnostics") end,
  { desc = "Workspace diagnostics" })
vim.keymap.set("n", "<leader>xd", function() require("trouble").toggle("document_diagnostics") end,
  { desc = "Document Diagnostics" })
vim.keymap.set("n", "<leader>xq", function() require("trouble").toggle("quickfix") end, { desc = "Trouble: quickfix" })
vim.keymap.set("n", "<leader>xl", function() require("trouble").toggle("loclist") end, { desc = "Trouble: loclist" })
vim.keymap.set("n", "X", function() require("trouble").first({ skip_groups = true, jump = true }) end,
  { desc = "Trouble: first error" })
vim.keymap.set("n", "<leader>X", function() require("trouble").last({ skip_groups = true, jump = true }) end,
  { desc = "Trouble: last error" })
vim.keymap.set("n", "<C-.>", function() require("trouble").next({ skip_groups = true, jump = true }) end,
  { desc = "Trouble: next error" })
vim.keymap.set("n", "<C-,>", function() require("trouble").previous({ skip_groups = true, jump = true }) end,
  { desc = "Trouble: previous error" })
vim.keymap.set("n", "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", { desc = 'Trouble' })
vim.keymap.set("n", "<leader>xX",
  "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
  { desc = "Trouble: buffer diagnostics " })
