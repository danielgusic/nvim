
-- setup bindings (leader) before initializing lazy
require "dvmujic.set"

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
require("lazy").setup({
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

    -- lsp
    {
        "neovim/nvim-lspconfig",
        config = function()
            -- error diagnostics
            vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
                vim.lsp.diagnostic.on_publish_diagnostics, {
                    virtual_text = false,
                    underline = true,
                    signs = true,
                }
            )

            -- setup diagnostic icons
            local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
            for type, icon in pairs(signs) do
              local hl = "DiagnosticSign" .. type
              vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
            end


            local lspconfig = require("lspconfig")
            local caps = require("cmp_nvim_lsp").default_capabilities()
            caps.textDocument.completion.completionItem = { snippetSupport = false }
            local allow_snippets = caps
            allow_snippets.textDocument.completion.completionItem.snippetSupport = true

            local flags = { debounce_text_changes = 150 }


            -- misc
            lspconfig.marksman.setup { capabilities = caps, flags = flags }
            lspconfig.typst_lsp.setup { capabilities = caps, flags = flags }
            lspconfig.nil_ls.setup { capabilities = caps, flags = flags } -- nix

            -- programming-langs
            lspconfig.rust_analyzer.setup { capabilities = caps, flags = flags }
            lspconfig.clangd.setup { capabilities = caps, flags = flags }
            lspconfig.gopls.setup { capabilities = caps, flags = flags }
            lspconfig.zls.setup { capabilities = caps, flags = flags } -- zig
            lspconfig.ocamllsp.setup { capabilities = caps, flags = flags } -- ocamllsp
            lspconfig.hls.setup { capabilities = caps, flags = flags } -- haskell
            lspconfig.julials.setup { capabilities = caps, flags = flags }

            -- web
            lspconfig.tsserver.setup { capabilities = caps, flags = flags }
            lspconfig.denols.setup { capabilities = caps, flags = flags }
            lspconfig.svelte.setup { capabilities = caps, flags = flags }
            lspconfig.astro.setup { capabilities = caps, flags = flags }
            lspconfig.tailwindcss.setup { capabilities = caps, flags = flags }
            lspconfig.jsonls.setup { capabilities = caps, flags = flags }

            lspconfig.html.setup { capabilities = allow_snippets, flags = flags }

            -- dsls
            lspconfig.pest_ls.setup { capabilities = caps, flags = flags }
            lspconfig.slint_lsp.setup { capabilities = caps, flags = flags }
            lspconfig.wgsl_analyzer.setup { capabilities = caps, flags = flags }

            -- others: omnisharp, sql-language-server, unocss

            -- lua
            -- lspconfig.lua_ls.setup {
            --     capabilities = caps, flags = flags,
            --     settings = {
            --         Lua = {
            --             runtime = { version = "LuaJIT", },
            --             diagnostics = { globals = {"vim"} },
            --             workspace = { library = vim.api.nvim_get_runtime_file("", true) },
            --             telemetry = { enable = false },
            --         },
            --     },
            -- }

            -- emmet
            -- lspconfig.emmet_language_server.setup { capabilities = allow_snippets, flags = flags }
            -- lspconfig.emmet_ls.setup {
            --     capabilities = allow_snippets,
            --     flags = flags,
            --     filetypes = {
            --         "css", "html", "javascriptreact",
            --         "svelte", "typescriptreact", "vue"
            --     },
            -- }

            -- attach
            vim.api.nvim_create_autocmd("LspAttach", {
                group = vim.api.nvim_create_augroup("UserLspConfig", {}),
                callback = function(ev)
                    vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"
                    vim.opt.signcolumn = "yes"

                    local opts = { buffer = ev.buf }
                    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
                    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)

                    vim.keymap.set("n", "<leader>l", vim.diagnostic.open_float, opts)
                    vim.keymap.set("n", "<leader>k", vim.lsp.buf.hover, opts)
                    vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, opts)
                    vim.keymap.set("n", "<leader>a", vim.lsp.buf.code_action, opts)
                end,
            })
        end
    },
    {
        "L3MON4D3/LuaSnip",
        lazy = false,
        version = "2.*",
        -- build = "make install_jsregexp",
    },
    {
        "hrsh7th/nvim-cmp",
        lazy = false,
        dependencies = { "hrsh7th/cmp-nvim-lsp" },
        config = function()
            local cmp = require("cmp")
            local luasnip = require("luasnip")

            cmp.setup {
                sources = {
                    { name = "nvim_lsp" },
                    { name = "luasnip" },
                },
                snippet = {
                    expand = function(args) luasnip.lsp_expand(args.body) end
                },
                mapping = {
                    ["<Up>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item()
                        else fallback() end
                    end, { "i", "s" }),
                    ["<Down>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        else fallback() end
                    end, { "i", "s" }),

                    ["<Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            if not cmp.get_selected_entry() then
                                cmp.select_next_item()
                            --elseif cmp.select_next_item() then
                            else
                                cmp.confirm()
                            end
                        elseif luasnip.expand_or_jumpable() then
                            luasnip.expand_or_jump()
                        else fallback() end
                    end, { "i", "s" }),
                },
            }
	end,
    },

    -- languages
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
            local configs = require("nvim-treesitter.configs")

            -- use to compile
            require("nvim-treesitter.install").compilers = { "gcc", "g++" }

            configs.setup {
                ensure_installed = {
                    "astro", "c", "clojure",
                    "cmake", "cpp", "css",
                    "gitignore", "glsl", "go",
                    "haskell",
                    "html", "java", "javascript",
                    "json", "julia", "kotlin",
                    "latex", "lua", "make",
                    "markdown", "markdown_inline", "nix",
                    "ocaml", "proto", "python",
                    "rust", "sql", "svelte",
                    "swift", "toml", "tsx",
                    "typescript", "wgsl", "yaml",
                    "zig",
                },
                highlight = {
                    enable = true,
                },
            }
        end
    },

    -- decorations
    {
        "nvim-lualine/lualine.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require("lualine").setup {
                options = {
                    icons_enabled = true,
                    theme = "auto",
                },
                sections = {
                    lualine_a = { "mode" },
                    lualine_b = { "branch", "diff", "diagnostics" },
                    lualine_c = { "filename" },

                    lualine_x = { "encoding", "fileformat", "filetype" },
                    lualine_y = { "progress" },
                    lualine_z = { "location" },
                }
            }
        end
    },
    {
        "folke/zen-mode.nvim", lazy = true,
        config = function()
            require("zen-mode").setup {
                plugins = {
                    options = {
                        showcmd = false,
                    },
                },
            }
        end
    },
    { "stevearc/dressing.nvim", event = "VeryLazy", },

    -- pickers
    {
        "nvim-telescope/telescope.nvim", branch = "0.1.x",
        dependencies = { "nvim-lua/plenary.nvim" },
        lazy = true,
        keys = {
            { "<leader>f", desc = "open file picker" },
            { "<leader>pb", desc = "open buffer picker" },
            { "<leader>pt", desc = "open colorscheme picker" },
            { "<leader>pp", desc = "open telescope builtin picker" },
        },
        config = function() 
            local builtin = require("telescope.builtin")

            vim.keymap.set("n", "<leader>f", builtin.find_files)
            vim.keymap.set("n", "<leader>pb", builtin.buffers)
            vim.keymap.set("n", "<leader>pt", builtin.colorscheme)
            vim.keymap.set("n", "<leader>pp", builtin.builtin)
        end
    },
})


-- includes
require "dvmujic.remap"

-- make autocommands for filetypes

