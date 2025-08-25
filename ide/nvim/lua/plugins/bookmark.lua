return {
  "MattesGroeger/vim-bookmarks",
  config = function()
    -- optional: your own mappings
    vim.keymap.set("n", "mm", "<cmd>BookmarkToggle<CR>", { desc = "Toggle bookmark" })
    vim.keymap.set("n", "mi", "<cmd>BookmarkAnnotate<CR>", { desc = "Annotate bookmark" })
    vim.keymap.set("n", "mn", "<cmd>BookmarkNext<CR>", { desc = "Next bookmark" })
    vim.keymap.set("n", "mp", "<cmd>BookmarkPrev<CR>", { desc = "Previous bookmark" })
  end,
}
