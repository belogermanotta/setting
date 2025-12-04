-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- SYSTEM CLIPBOARD INTEGRATION (Cmd keys)

-- Copy (Cmd-C)
vim.keymap.set("v", "<Esc>c", '"+y', { noremap = true, silent = true })

-- Paste (Cmd-V)
vim.keymap.set("n", "<Esc>p", '"+p', { noremap = true, silent = true })
vim.keymap.set("i", "<Esc>p", '<Esc>"+pa', { noremap = true, silent = true })
vim.keymap.set("v", "<Esc>p", '"+p', { noremap = true, silent = true })
-- Paste in :command mode (cmdline mode)
vim.keymap.set("c", "<Esc>p", function()
  return vim.fn.escape(vim.fn.getreg("+"), "\\")
end, { expr = true })

-- Cut (Cmd-X)
vim.keymap.set("v", "<Esc>x", '"+d', { noremap = true, silent = true })

vim.keymap.set("n", "<Esc>a", "ggVG", { noremap = true, silent = true })

-- Save (Cmd-S)
vim.keymap.set("n", "<Esc>s", "<cmd>w<cr>", { noremap = true, silent = true })

-- Close buffer (Cmd-W)
vim.keymap.set("n", "<Esc>w", "<cmd>bd<cr>", { noremap = true, silent = true })

-- Undo / Redo
vim.keymap.set("n", "<Esc>z", "u", { noremap = true, silent = true }) -- Cmd-Z
vim.keymap.set("n", "<Esc>Z", "<C-r>", { noremap = true, silent = true }) -- Cmd-Shift-Z

-- Leap easymotion
vim.keymap.set({ "n", "x", "o" }, "s", "<Plug>(leap)")
vim.keymap.set("n", "S", "<Plug>(leap-from-window)")

-- Bookmark
-- vim.keymap.set("n", "ma", function()
--   require("telescope").extensions.vim_bookmarks.all()
-- end, { desc = "Bookmarks (popup)" })
local telescope = require("telescope")
local bookmark_actions = telescope.extensions.vim_bookmarks.actions
vim.keymap.set("n", "ma", function()
  telescope.extensions.vim_bookmarks.all({
    attach_mappings = function(prompt_bufnr, map)
      map("n", "dd", function()
        bookmark_actions.delete_at_cursor(prompt_bufnr)
      end)
      return true
    end,
  })
end, { desc = "Bookmarks (popup)" })
-- MF: current file bookmarks only
vim.keymap.set("n", "mf", function()
  require("telescope").extensions.vim_bookmarks.current_file()
end, { desc = "Bookmarks in file (popup)" })

-- Disable default Vim marks
vim.keymap.set("n", "m", "<Nop>", { noremap = true })

-- Terminal
vim.keymap.set("n", "<leader>T", function()
  vim.cmd("vsplit | terminal")
end, { desc = "Terminal (vertical split)" })
