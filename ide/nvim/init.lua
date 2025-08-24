-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

vim.g.python3_host_prog = [[C:\Users\Kobe\nvim-py312\Scripts\python.exe]]

-- Disable relative line numbers
vim.opt.relativenumber = false

require("lazy").setup({
  { "akinsho/git-conflict.nvim", version = "*", config = true },
  {
    "williamboman/mason.nvim",
    version = "*", -- always use latest stable release
    build = ":MasonUpdate", -- keep Mason's package registry up to date
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
