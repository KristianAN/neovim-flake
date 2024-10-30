-- [nfnl] Compiled from nvim-10-orgmode.fnl by https://github.com/Olical/nfnl, do not edit.
local orgmode = require("orgmode")
return orgmode.setup({org_agenda_files = "~/orgfiles/**/*", org_default_notes_file = "~/orgfiles/refile.org", mappings = {global = {org_capture = "<prefix>k"}}})
