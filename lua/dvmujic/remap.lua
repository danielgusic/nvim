local nnoremap = require("dvmujic.keymap").nnoremap

nnoremap("<leader>e", "<cmd>Ex<CR>")

-- telescope (<leader> + f)
local builtin = require("telescope.builtin")
nnoremap("<leader>f", builtin.find_files)
nnoremap("<leader>b", builtin.buffers)

nnoremap("<leader>tt", builtin.colorscheme)
nnoremap("<leader>tp", builtin.builtin)

-- window management (<leader> + w)
nnoremap("<leader>w", "<C-w>")

-- system clipboard
nnoremap("<leader>p", "\"+p")
nnoremap("<leader>P", "\"+P")
nnoremap("<leader>y", "\"+y")

-- misc
nnoremap("<S-u>", "<C-r>")

