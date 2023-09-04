
return {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
        keywords = {
            todo = {
                icon = " ",
                color = "info",
                alt = { "TODO" },
            },
            warn = {
                icon = " ",
                color = "warning",
                alt = { "WARN" },
            },
            hint = {
                icon = " ",
                color = "hint",
                alt = { "HINT", "info", "INFO" },
            },
            fixme = {
                icon = " ",
                color = "error",
                alt = { "FIXME", "fix", "FIX", "error", "ERROR" },
            },
            note = {
                icon = "󰠮 ",
                color = "hint",
                alt = { "NOTE", "hint", "HINT" },
            },
        }
    },
}

