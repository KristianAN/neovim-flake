require('neorg').setup {
  load = {
    ["core.defaults"] = {},
    ["core.presenter"] = {
      config = {
        zen_mode = "zen-mode"
      }
    },
    ["core.completion"] = {
      config = {
        engine = "nvim-cmp"
      }
    },
    ["core.concealer"] = {},
    ["core.export"] = {},
    ["core.dirman"] = {
      config = {
        workspaces = {
          work = "~/notes/work",
          home = "~/notes/home",
        }
      }
    },
  }
}
