
return {
    "hrsh7th/nvim-cmp",
    -- info: temp fix
    commit = "b356f2c",

    -- lazy = true,
    event = { "InsertEnter", "CmdlineEnter" },
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-calc",
        "hrsh7th/cmp-buffer",
        "saadparwaiz1/cmp_luasnip",
        "hrsh7th/cmp-nvim-lua",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        "uga-rosa/cmp-dynamic",

        { "max397574/cmp-greek", lazy = true },

        -- { "kdheepak/cmp-latex-symbols", lazy = true },
        { "hrsh7th/cmp-emoji", lazy = true },
        {
          -- snippet plugin
          "L3MON4D3/LuaSnip",
          dependencies = "rafamadriz/friendly-snippets",
          opts = { history = true, updateevents = "TextChanged,TextChangedI" },
          config = function(_, opts)
            require("luasnip").config.set_config(opts)
            require "nvchad.configs.luasnip"
          end,
    },

        -- autopairing of (){}[] etc
    {
      "windwp/nvim-autopairs",
      opts = {
        fast_wrap = {},
        disable_filetype = { "TelescopePrompt", "vim" },
      },
      config = function(_, opts)
        require("nvim-autopairs").setup(opts)

        -- setup cmp for autopairs
        local cmp_autopairs = require "nvim-autopairs.completion.cmp"
        require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done())
      end,
    },
    opts = function()
    end,
    },
    config = function()
        local cmp = require("cmp")
        local luasnip = require("luasnip")
        local icons = require("dvmujic.icons")

        require("dvmujic.plugins.cmp.umlaut").setup()

        cmp.setup {
            sources = cmp.config.sources({
                { name = "umlaut" },
                { name = "crates" },
            },
            {
                { name = "nvim_lsp" },
            },

            -- dont show other cmps when lsp is available
            {
                { name = "calc" },
                { name = "dynamic" },
                { name = "greek", max_item_count = 5 },
                { name = "luasnip", keyword_length = 2 },
                { name = "emoji" },
            },
            {
                { name = "buffer", keyword_length = 2 },
            }),

            snippet = {
                expand = function(args) luasnip.lsp_expand(args.body) end
            },
            window = {
                completion = {
                    col_offset = 0,
                    -- winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
                    -- side_padding = 0,
                },
            },
            formatting = {
                -- order of the fields
                fields = { "abbr", "kind", "menu" },
                format = function(entry, vim_item)
                    local comp_icons = icons.comp

                    local menu_types = {
                        nvim_lsp = "[lsp]",
                        luasnip = "[luasnip]",
                        greek = "[greek]",
                        umlaut = "[umlaut]",

                        latex_symbols = "[latex]",
                        buffer = "[buffer]",
                    }

                    vim_item.kind = string.format("%s (%s)", comp_icons[vim_item.kind], vim_item.kind)
                    vim_item.menu =  menu_types[entry.source.name]
                    return vim_item
                end
            },
            mapping = {
                ["<C-p>"] = cmp.mapping.select_prev_item(),
                ["<C-n>"] = cmp.mapping.select_next_item(),
                ["<C-d>"] = cmp.mapping.scroll_docs(-4),
                ["<C-f>"] = cmp.mapping.scroll_docs(4),
                ["<C-Space>"] = cmp.mapping.complete(),
                ["<C-e>"] = cmp.mapping.close(),

                ["<CR>"] = cmp.mapping.confirm {
                  behavior = cmp.ConfirmBehavior.Insert,
                  select = true,
                },

                ["<Tab>"] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    cmp.select_next_item()
                elseif require("luasnip").expand_or_jumpable() then
                    require("luasnip").expand_or_jump()
                else
                    fallback()
                end
                end, { "i", "s" }),

                ["<S-Tab>"] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    cmp.select_prev_item()
                elseif require("luasnip").jumpable(-1) then
                    require("luasnip").jump(-1)
                else
                    fallback()
                end
                end, { "i", "s" }),
            },
        }
        require("cmp_dynamic").register {
            --[[
            { label = "ue", insertText = function () return "ü" end },
            { label = "Ue", insertText = function () return "Ü" end },
            { label = "ae", insertText = function () return "ä" end },
            { label = "Ae", insertText = function () return "Ä" end },
            { label = "oe", insertText = function () return "ö" end },
            { label = "Oe", insertText = function () return "Ö" end },
            { label = "ss", insertText = function () return "ß" end },
            ]]--
        }

        cmp.setup.cmdline(":", {
            mapping = cmp.mapping.preset.cmdline(),
            sources = cmp.config.sources({
                {
                    name = "cmdline",
                    option = {
                        ignore_cmds = { "Man", "!" },
                    },
                    keyword_length = 3,
                }
            })
        })

    end,
}

