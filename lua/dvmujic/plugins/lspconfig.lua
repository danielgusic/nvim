
return {
    "neovim/nvim-lspconfig",
    config = function()
        -- error diagnostics (dont show virtual text in diagnostics)
        vim.diagnostic.config {
            virtual_text = false,
            signs = true,
            underline = true,
        }

        -- setup diagnostic icons
        local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
        for type, icon in pairs(signs) do
            local hl = "DiagnosticSign" .. type
            vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
        end

        local lspconfig = require("lspconfig")
        local caps = vim.lsp.protocol.make_client_capabilities()
        caps = require("cmp_nvim_lsp").default_capabilities(caps)
        caps.textDocument.completion.completionItem.snippetSupport = false
        -- `true` to enable auto-imports for rust-analzyer
        caps.textDocument.completion.completionItem.additionalTextEdits = true

        local flags = { debounce_text_changes = 150 }

        vim.g.zig_fmt_autosave = 0 -- disable format on autosave for zig lang-server
        
        local servers = {
            -- misc
            marksman = {},      -- markdown
            typst_lsp = {       -- typst
                -- ["typst_lsp"] = {
                --     exportPdf = "onType",
                -- },
            },
            nil_ls = {},        -- nix

            -- programming-langs
            clangd = {},        -- c/cpp
            gopls = {},         -- go
            zls = {},           -- zig
            ocamllsp = {},      -- ocaml (ocamllsp)
            hls = {},           -- haskell
            rust_analyzer = {   -- rust
                ["rust-analyzer"] = {
                    cargo = { autoreload = true },
                    completion = {
                        autoimport = { enable = false },
                    },
                },
            },

            -- web
            tsserver = {},
            denols = {},
            svelte = {},

            -- dsls
            -- pest_ls = {},
            slint_lsp = {},
            -- wgsl_analyzer = {},

            lua_ls = {
                Lua = {
                    runtime = { version = "LuaJIT" },
                    diagnostics = { globals = {"vim"} },
                    workspace = { library = vim.api.nvim_get_runtime_file("", true) },
                    telemetry = { enable = false },
                },
            },

            sourcekit = {},
        }

        for k, v in pairs(servers) do
            lspconfig[k].setup {
                capabilities = caps,
                flags = flags,
                settings = v,
            }
        end

        local allow_snippets = caps
        allow_snippets.textDocument.completion.completionItem.snippetSupport = true

        lspconfig.html.setup { capabilities = allow_snippets, flags = flags }

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

        require("dvmujic.plugins.lspconfig.custom")

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
}

