
-- window management 
vim.keymap.set("n", "<leader>w", "<C-w>")

-- system clipboard (deprecated, I only want the system clipboard)
-- vim.keymap.set("n", "<leader>p", "\"+p")
-- vim.keymap.set("n", "<leader>P", "\"+P")

-- redo with capital 'U'
vim.keymap.set("n", "<S-u>", "<C-r>")

-- <leader>e for netrw
vim.keymap.set("n", "<leader>e", "<cmd>Ex<Return>")

vim.keymap.set("n", "<leader>so", "<cmd>source $MYVIMRC<Return>")

-- Yank to system clipboard
vim.keymap.set({'n', 'v'}, 'y', '"+y', { noremap = true, silent = true })
vim.keymap.set({'n', 'v'}, 'Y', '"+Y', { noremap = true, silent = true })

-- Delete to system clipboard
vim.keymap.set({'n', 'v'}, 'd', '"+d', { noremap = true, silent = true })

-- Change to system clipboard
vim.keymap.set({'n', 'v'}, 'c', '"+c', { noremap = true, silent = true })

-- Paste from system clipboard
vim.keymap.set('n', 'p', '"+p', { noremap = true, silent = true })
vim.keymap.set('n', 'P', '"+P', { noremap = true, silent = true })
vim.keymap.set('v', 'p', '"+p', { noremap = true, silent = true })
vim.keymap.set('v', 'P', '"+P', { noremap = true, silent = true })

