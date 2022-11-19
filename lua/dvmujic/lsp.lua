local lspconfig = require("lspconfig")
local nnoremap = require("dvmujic.keymap").nnoremap

local on_attach = function(client, bufnr)
    vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

    vim.opt.signcolumn = "yes"

    local bufopts = { buffer = bufnr } 
    nnoremap("gD", vim.lsp.buf.declaration, bufopts)
    nnoremap("gd", vim.lsp.buf.definition, bufopts)

    nnoremap("<leader>k", vim.lsp.buf.hover, bufopts)
    nnoremap("<leader>l", vim.diagnostic.open_float, bufopts)
    nnoremap("<leader>r", vim.lsp.buf.rename, bufopts)
    nnoremap("<leader>a", vim.lsp.buf.code_action, bufopts)

end

-- error diagnostics
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics, {
        virtual_text = false,
        underline = true,
        signs = true,
    }
)


-- init mason
require("mason").setup()

local cmp = require("cmp")
local luasnip = require("luasnip")

local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

vim.diagnostic.config({
    -- signs = false,
})

cmp.setup {
    sources = {
        { name = "nvim_lsp" },
        { name = "luasnip" },
    },
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end
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

        --["<Esc>"] = cmp.mapping(function(fallback)
        --    if cmp.visible() then
        --        cmp.abort()
        --    else
        --        fallback()
        --    end
        --end)
    },
}

local lsp_flags = { debounce_text_changes = 150 } 
local capabilities = require("cmp_nvim_lsp").default_capabilities()
capabilities.textDocument.completion.completionItem = { snippetSupport = false }

local lang_servers = {
    "rust_analyzer",
    "svelte",
    "astro",
}

local nvim_lsp = require("lspconfig")
for _, lang in pairs(lang_servers) do
    nvim_lsp[lang].setup {
        on_attach = on_attach,
        flags = lsp_flags,
        capabilities = capabilities,
    }
end

nvim_lsp["denols"].setup {
    on_attach = on_attach,
    flags = lsp_flags,
    capabilities = capabilities,
    root_dir = nvim_lsp.util.root_pattern("deno.json"),
}

nvim_lsp["tsserver"].setup {
    on_attach = on_attach,
    flags = lsp_flags,
    capabilities = capabilities,
    root_dir = nvim_lsp.util.root_pattern("package.json"),
}

local allow_snippets = capabilities
allow_snippets.textDocument.completion.completionItem = { snippetSupport = true }
nvim_lsp["emmet_ls"].setup {
    on_attach = on_attach,
    flags = lsp_flags,
    capabilities = allow_snippets,
    filetypes = { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less" },
}


