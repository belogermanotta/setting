return {
  "folke/snacks.nvim",
  opts = {
    picker = {
      win = {
        input = {
          keys = {
            -- WezTerm maps Cmd+V to Alt+P; paste clipboard into the picker query.
            ["<a-p>"] = { "<c-r>+", mode = "i" },
            -- Cmd+Shift+V arrives as Alt+Shift+P.
            ["<a-P>"] = { "toggle_preview", mode = { "i", "n" } },
          },
        },
        list = {
          keys = {
            -- Keep preview toggle available if the picker list has focus.
            ["<a-P>"] = "toggle_preview",
          },
        },
        preview = {
          wo = {
            wrap = true,
          },
        },
      },
    },
  },
}
