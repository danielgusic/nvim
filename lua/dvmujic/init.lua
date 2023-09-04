
-- setup bindings (leader) before initializing lazy
require("dvmujic.set")

vim.loader.enable()

--[[ bootstrap lazy.nvim ]]--
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

-- init plugins
require("lazy").setup {
    -- themes
    {
        "sainnhe/sonokai",
        lazy = false, -- primary colorscheme
        config = function()
            vim.g.sonokai_transparent_background = 1
            vim.g.sonokai_better_performance = 1
            vim.cmd [[colorscheme sonokai]]
        end
    },
    {
        "Mofiqul/vscode.nvim",
        event = "VeryLazy",
        opts = {
            transparent = true,
        },
    },
    {
        "rose-pine/neovim",
        name = "rose-pine", event = "VeryLazy",
        opts = {
            disable_background = true,
            -- disable_float_background = true,
        },
    },
    {
        "shaunsingh/nord.nvim",
        event = "VeryLazy",
        config = function()
            vim.g.nord_disable_background = true
            vim.g.nord_contrast = true
        end
    },
    {
        "catppuccin/nvim",
        event = "VeryLazy", name = "catppuccin",
        opts = {
            transparent_background = true,
        },
    },
    {
        "neanias/everforest-nvim",
        event = "VeryLazy",
        config = function()
            require("everforest").setup {
                background = "hard",
                transparent_background_level = 1,
            }
        end
    },
    {
        "marko-cerovac/material.nvim",
        event = "VeryLazy",
        opts = {
            contrast = {
                floating_windows = true,
            },
        },
    },
    { "nyoom-engineering/oxocarbon.nvim", event = "VeryLazy" },

    -- lsp
    require("dvmujic.plugins.lspconfig"),   -- individual servers
    require("dvmujic.plugins.cmp"),         -- completion
    require("dvmujic.plugins.fidget"),      -- lsp loading spinner
    require("dvmujic.plugins.luasnip"),

    -- languages
    require("dvmujic.plugins.treesitter"),  -- better syntax highlighting
    -- { "kaarmu/typst.vim", ft = "typst" },

    -- decorations
    require("dvmujic.plugins.lualine"),
    require("dvmujic.plugins.zen-mode"),        -- focus on one pane
    require("dvmujic.plugins.todo-comments"),   -- highlighted comments
    require("dvmujic.plugins.dressing"),        -- fancy rename and quickfix

    -- pickers
    require("dvmujic.plugins.telescope"),       -- fuzzy finder

    -- misc
    { "jghauser/mkdir.nvim", event = "BufWritePre" },
}

-- includes
require "dvmujic.remap"

-- make autocommands for filetypes
require "dvmujic.filetypes"

