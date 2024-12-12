
return {
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
                "gitignore", "glsl", "go", "gleam",
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
}

