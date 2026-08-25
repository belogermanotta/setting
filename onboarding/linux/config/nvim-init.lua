-- Minimal Neovim starter (onboarding default).
-- Replace with your real dotfiles when you bring them over.
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.mouse = 'a'
vim.opt.clipboard = 'unnamedplus'
vim.opt.swapfile = false
vim.opt.signcolumn = 'yes'
vim.keymap.set('n', '<leader>w', '<cmd>w<CR>', { desc = 'Save' })
vim.keymap.set('n', '<leader>q', '<cmd>q<CR>', { desc = 'Quit' })
