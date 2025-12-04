-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

vim.g.neo_tree_remove_legacy_commands = 1

vim.cmd("colorscheme tokyonight-night")
-- vim.cmd("colorscheme catppuccin-mocha")

-- require("neo-tree").setup({
--   window = {
--     width = 50, -- set explorer width
--   },
-- })

require("lazy").setup({
  { "akinsho/git-conflict.nvim", version = "*", config = true },
  {
    "williamboman/mason.nvim",
    version = "*", -- always use latest stable release

    config = function()
      require("mason").setup({
        -- Mason settings (optional)
        ui = {
          border = "rounded",
          icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗",
          },
        },
      })
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    version = "*",
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = { "lua_ls", "pyright", "tsserver" }, -- add what you need
      })
    end,
  },
})
