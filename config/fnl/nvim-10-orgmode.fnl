(let [orgmode (require :orgmode)]
  (orgmode.setup {
      :org_agenda_files  "~/orgfiles/**/*"
      :org_default_notes_file  "~/orgfiles/refile.org"
  }))