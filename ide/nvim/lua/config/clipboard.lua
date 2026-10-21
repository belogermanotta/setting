-- Register system clipboard shortcuts before LazyVim's delayed keymap setup.
-- Plain y and p continue using Neovim's registers.
vim.keymap.set("v", "<M-c>", '"+y', { noremap = true, silent = true })

vim.keymap.set("n", "<M-p>", '"+p', { noremap = true, silent = true })
vim.keymap.set("i", "<M-p>", '<Esc>"+pa', { noremap = true, silent = true })
vim.keymap.set("v", "<M-p>", '"+p', { noremap = true, silent = true })
vim.keymap.set("c", "<M-p>", function()
	return vim.fn.escape(vim.fn.getreg("+"), "\\")
end, { expr = true })
