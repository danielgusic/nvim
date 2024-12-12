
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

-- fix -> nvim-metals indent width
vim.cmd [[
autocmd FileType scala setlocal shiftwidth=4 softtabstop=4 expandtab
]]

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


local alpha = function()
    return string.format("%x", math.floor((255 * vim.g.transparency) or 0.8))
end


-- neovide basic config
vim.g.neovide_transparency = 0.0
vim.g.transparency = 0.8
vim.g.neovide_background_color = "#0f1117"..alpha()


