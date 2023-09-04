
local lspconfig = require("lspconfig")

local configs = require("lspconfig.configs")
local util = require("lspconfig.util")

if not configs.rust_dev then
    configs.rust_dev = {
        default_config = {
            -- cmd = {"/home/david/dev/rust/lsp-playground/start.sh"},
            cmd = {"cargo", "run", "-q"},
            filetypes = {"markdown"},
            root_dir = function(fname)
                return util.root_pattern("Cargo.toml")(fname)
            end,
            settings = {},
        },
    }
end

-- lspconfig.rust_dev.setup { }

