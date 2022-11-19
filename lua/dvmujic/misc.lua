
require("zen-mode").setup {
    window = {
        options = {
            -- signcolumn = "no",
        }
    },
    plugins = {
        options = {
            showcmd = false,
        },
    },
}

-- require("twilight").setup {
--     expand = {
--         "function",
--         "method",
--     },
-- }


require("nvim-treesitter.configs").setup {
    highlight = {
        enable = true,
    }
}

vim.cmd "autocmd BufRead,BufEnter *.astro set filetype=astro"
vim.cmd "autocmd BufRead,BufEnter *.md set filetype=markdown"

