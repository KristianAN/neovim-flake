-- Default options
require("modus-themes").setup({
  style = "modus_vivendi",
  variant = "tinted",   -- Theme comes in four variants `default`, `tinted`, `deuteranopia`, and `tritanopia`
  dim_inactive = false, -- "non-current" windows are dimmed
  styles = {
    comments = { italic = true },
    keywords = { italic = true },
    functions = {},
    variables = {},
  },
})

vim.cmd [[colorscheme modus_vivendi]]
