
-- show absolute line number at cursor
vim.opt.nu = true
-- use relative line numbers
vim.opt.relativenumber = true

-- enable mouse
vim.opt.mouse = "a"

-- tabs (expand to 4 spaces)
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

-- dont highlight previous search results
vim.opt.hlsearch = false
-- ignore case when searching
vim.opt.ignorecase = true
-- dont ignore case when uppercase is used
vim.opt.smartcase = true

-- wrap lines
vim.opt.wrap = true
-- preserve indent of wrapped lines
vim.opt.breakindent = true

-- use <space> as leader
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- fix telescope selected color
vim.cmd [[
if has("termguicolors")
    set termguicolors
endif
]]

