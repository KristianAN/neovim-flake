-- [nfnl] Compiled from nvim-10-kanagawa.fnl by https://github.com/Olical/nfnl, do not edit.
do
  local kanagawa = require("kanagawa")
  kanagawa.setup({commentStyle = {italic = true}, functionStyle = {}, keywordStyle = {italic = true}, statementStyle = {bold = true}, typeStyle = {}, terminalColors = true, colors = {palette = {}, theme = {wave = {}, lotus = {}, dragon = {}, all = {}}}, theme = "wave", background = {dark = "dragon", light = "lotus"}, compile = false, dimInactive = false, transparent = false, undercurl = false})
end
return vim.cmd("colorscheme kanagawa")
