
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

local transparent_themes = true

-- init plugins
require("lazy").setup {
    -- themes
    {
        "sainnhe/sonokai",
        lazy = false, -- primary colorscheme
        config = function()
            vim.g.sonokai_transparent_background = transparent_themes and 1 or 0
            vim.g.sonokai_better_performance = 1
            vim.cmd [[colorscheme sonokai]]
        end
    },
    {
        'andweeb/presence.nvim',
        lazy = false
    },
    { 'echasnovski/mini.surround', version = false },
    { 
        "ThePrimeagen/vim-be-good",
        lazy = false,
        config=function()
        end,
    },
    {
        "jalvesaq/nvim-r",
        config = function()
        vim.g.R_nvim_wd = 0 -- Start R with the current working directory
        end,
    },
    {
        "Mofiqul/vscode.nvim",
        event = "VeryLazy",
        opts = {
            transparent = transparent_themes,
        },
    },
    {
        "rose-pine/neovim",
        name = "rose-pine", event = "VeryLazy",
        opts = {
            disable_background = transparent_themes,
            -- disable_float_background = true,
        },
    },
    {
        "shaunsingh/nord.nvim",
        event = "VeryLazy",
        config = function()
            vim.g.nord_disable_background = transparent_themes
            vim.g.nord_contrast = true
        end
    },
    {
        "catppuccin/nvim",
        event = "VeryLazy", name = "catppuccin",
        opts = {
            transparent_background = transparent_themes,
        },
    },
    {
        "neanias/everforest-nvim",
        event = "VeryLazy",
        config = function()
            require("everforest").setup {
                background = "hard",
                transparent_background_level = transparent_themes and 1 or 0,
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
    { "ntk148v/komau.vim", event = "VeryLazy" },


    -- info: highlight markdown headings
    --
    --[[ {
        "lukas-reineke/headlines.nvim",
        dependencies = "nvim-treesitter/nvim-treesitter",
        opts = {
            markdown = {
                headline_highlights = {
                    "Headline1",
                    "Headline2",
                    "Headline3",
                    "Headline4",
                    "Headline5",
                    "Headline6",
                },
                codeblock_highlight = "CodeBlock",
                dash_highlight = "Dash",
                quote_highlight = "Quote",

                dash_string = "—",
                fat_headline_upper_string = "_",
                fat_headline_lower_string = "‾",
                fat_headlines = true,
            },
        },
    }, ]]--

    -- info: function signature highlights
    --
    --[[ {
        "ray-x/lsp_signature.nvim",
        event = "VeryLazy",
        opts = {
            bind = true,
            floating_window = true,
            floating_window_above_curr_line = true,
            floating_window_off_x = 0,

            doc_lines = 0,
            handler_opts = {
                border = "none",
            },
            hint_enable = false,
        },
        config = function (_, opts)
            require("lsp_signature").setup(opts)
        end
    }, ]]--
    { "typicode/bg.nvim", lazy = false },

    -- lsp
    require("dvmujic.plugins.lspconfig"),   -- individual servers
    require("dvmujic.plugins.cmp"),         -- completion
    require("dvmujic.plugins.fidget"),      -- lsp loading spinner
    require("dvmujic.plugins.luasnip"),

    -- languages
    require("dvmujic.plugins.treesitter"),  -- better syntax highlighting
    -- { "kaarmu/typst.vim", ft = "typst" },
    {
        "chomosuke/typst-preview.nvim",
        ft = "typst",
        version = "0.1.*",
        build = function() require("typst-preview").update() end,
    },
    {
        'numToStr/Comment.nvim',
        opts = {
            -- add any options here
        },
    },
    {
        "scalameta/nvim-metals",
        ft = { "scala", "sbt", "java" },
        dependencies = "nvim-lua/plenary.nvim",
        opts = function ()
            local metals_config = require("metals").bare_config()

            metals_config.settings = {
                showImplicitArguments = true,
            }

            metals_config.init_options.statusBarProvider = "off"
            metals_config.capabilities = require("cmp_nvim_lsp").default_capabilities()

            return metals_config
        end,
        config = function (self, metals_config)
            local nvim_metals_group = vim.api.nvim_create_augroup("nvim-metals", { clear = true })
            vim.api.nvim_create_autocmd("FileType", {
                pattern = self.ft,
                callback = function()
                    require("metals").initialize_or_attach(metals_config)
                end,
                group = nvim_metals_group,
            })
        end,
    },
    {
        'saecki/crates.nvim',
        tag = "stable",
        event = { "BufRead Cargo.toml" },
        config = function() require('crates').setup() end,
    },
    {
        'windwp/nvim-autopairs',
        event = "InsertEnter",
        config = true
        -- use opts = {} for passing setup options
        -- this is equivalent to setup({}) function
    },
    {
        "IndianBoy42/tree-sitter-just",
        config = function ()
            require("tree-sitter-just").setup({})
        end,
    },

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

