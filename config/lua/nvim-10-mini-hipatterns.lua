-- [nfnl] Compiled from nvim-10-mini-hipatterns.fnl by https://github.com/Olical/nfnl, do not edit.
local hipatterns = require("mini.hipatterns")
return hipatterns.setup({highlighters = {fixme = {pattern = "%f[%w]()FIXME()%f[%W]", group = "MiniHipatternsFixme"}, hack = {pattern = "%f[%w]()HACK()%f[%W]", group = "MiniHipatternsHack"}, todo = {pattern = "%f[%w]()TODO()%f[%W]", group = "MiniHipatternsTodo"}, note = {pattern = "%f[%w]()NOTE()%f[%W]", group = "MiniHipatternsNote"}}, hex_color = hipatterns.gen_highlighter.hex_color()})
