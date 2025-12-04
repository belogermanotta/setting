return {
  "mg979/vim-visual-multi",
  branch = "master",
  lazy = false,
  init = function()
    -- make sure default keymaps like <C-n> are enabled
    vim.g.VM_default_mappings = 1
  end,
}
-- return {
--   "smoka7/multicursors.nvim",
--   event = "VeryLazy",
--   dependencies = { "nvimtools/hydra.nvim" }, -- this is the correct dep name now
--   opts = {},
--
--   cmd = { "MCstart", "MCvisual", "MCclear", "MCpattern", "MCvisualPattern", "MCunderCursor" },
--
--   -- define keymaps so pressing them lazy-loads the plugin
--   keys = {
--     { "<leader>m", "<cmd>MCstart<cr>", mode = { "n", "v" }, desc = "Multicursor: start" },
--     {
--       "<C-n>",
--       function()
--         require("multicursors").start()
--       end,
--       mode = { "n", "v" },
--       desc = "Multicursor: start (Ctrl-D)",
--     },
--   },
--
--   config = function()
--     require("multicursors").setup({
--       generate_hints = { normal = true, insert = true, extend = true, config = { max_hint_length = 3 } },
--     })
--   end,
-- }
