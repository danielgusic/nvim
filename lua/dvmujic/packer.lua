
vim.cmd [[packadd packer.nvim]]

return require("packer").startup(function()
    use "wbthomason/packer.nvim"

    -- themes
    use "sainnhe/sonokai"

    -- lsp
    use "neovim/nvim-lspconfig"
    use "hrsh7th/cmp-nvim-lsp"
    use "hrsh7th/nvim-cmp"
    use "williamboman/mason.nvim"
    use "L3MON4D3/LuaSnip"

    -- misc
    use "folke/zen-mode.nvim"
    -- use "folke/twilight.nvim"

    use {
        "nvim-telescope/telescope.nvim", branch = "0.1.x",
        requires = {{ "nvim-lua/plenary.nvim" }}
    }

    use {
        "nvim-lualine/lualine.nvim",
        requires = { "kyazdani42/nvim-web-devicons", opt = false }
    }

    use {
        "nvim-treesitter/nvim-treesitter",
        run = function() require("nvim-treesitter.install").update({ with_sync = true }) end,
    }


    -- nvim in chrome
    use {
        "glacambre/firenvim",
        run = function() vim.fn["firenvim#install"]() end
    }
end)

