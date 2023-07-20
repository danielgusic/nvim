-- vim.opt.guicursor = ""

-- vim.api.nvim_exec("language en_US", true)

vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.mouse = "a"

-- vim.cmd "autocmd vimenter * hi Normal guibg=NONE ctermbg=NONE"
-- vim.cmd "autocmd vimenter * hi EndOfBuffer guibg=NONE ctermbg=NONE"

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.smartindent = true

vim.g.mapleader = " "

-- theme
vim.cmd [[
if has("termguicolors")
    set termguicolors
endif
]]

vim.g.sonokai_transparent_background = 1
vim.g.sonokai_better_performance = 1
vim.cmd "colorscheme sonokai"

