return {
  {
    "MattesGroeger/vim-bookmarks",
    lazy = false,
    init = function()
      -- Recommended for telescope extension
      vim.g.bookmark_sign = ""
      vim.g.bookmark_annotation_sign = "陼"
    end,
    config = function()
      -- optional: your own mappings
      vim.keymap.set("n", "mm", "<cmd>BookmarkToggle<CR>", { desc = "Toggle bookmark" })
      vim.keymap.set("n", "mi", "<cmd>BookmarkAnnotate<CR>", { desc = "Annotate bookmark" })
      vim.keymap.set("n", "mn", "<cmd>BookmarkNext<CR>", { desc = "Next bookmark" })
      vim.keymap.set("n", "mp", "<cmd>BookmarkPrev<CR>", { desc = "Previous bookmark" })
    end,
  },
  -- ⭐ Telescope extension for popup bookmarks
  {
    "tom-anders/telescope-vim-bookmarks.nvim",
    dependencies = {
      "nvim-telescope/telescope.nvim",
      "MattesGroeger/vim-bookmarks",
    },
    config = function()
      require("telescope").load_extension("vim_bookmarks")
    end,
  },
}
