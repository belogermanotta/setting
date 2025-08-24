return {
  "nvim-neo-tree/neo-tree.nvim",
  keys = {
    {
      "<leader>e",
      function()
        local root = require("lazyvim.util").root()
        require("neo-tree.command").execute({
          toggle = true,
          position = "left",
          dir = root, -- << always open at project root
          cwd = root, -- force Neo-tree’s cwd to project root
          reveal = true,
        })
      end,
      desc = "Explorer (project root)",
    },
  },
  opts = {
    filesystem = {
      bind_to_cwd = false, -- don't stick to whatever :pwd is
      follow_current_file = { enabled = true }, -- auto-jump with current file
      use_libuv_file_watcher = true,
    },
  },

  -- init = function()
  --   vim.api.nvim_create_autocmd("VimEnter", {
  --     callback = function()
  --       if vim.fn.argc() == 0 then
  --         local root = require("lazyvim.util").root()
  --         require("neo-tree.command").execute({
  --           position = "left",
  --           dir = root,
  --           toggle = false,
  --           reveal = true,
  --         })
  --       end
  --     end,
  --   })
  -- end,
}
