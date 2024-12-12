

return {
    "nvim-telescope/telescope.nvim", branch = "0.1.x",
    dependencies = { "nvim-lua/plenary.nvim" },
    lazy = true,
    keys = {
        { "<leader>f", desc = "open file picker" },
        { "<leader>jg", desc = "open grep picker" },
        { "<leader>jb", desc = "open buffer picker" },
        { "<leader>jt", desc = "open colorscheme picker" },
        { "<leader>jd", desc = "open diagnostics picker" },
        { "<leader>jp", desc = "open telescope builtin picker" },
    },
    config = function() 
        local builtin = require("telescope.builtin")

        vim.keymap.set("n", "<leader>f", builtin.find_files)
        vim.keymap.set("n", "<leader>jg", builtin.live_grep)
        vim.keymap.set("n", "<leader>jb", builtin.buffers)
        vim.keymap.set("n", "<leader>jt", builtin.colorscheme)
        vim.keymap.set("n", "<leader>jd", builtin.diagnostics)
        vim.keymap.set("n", "<leader>jp", builtin.builtin)
    end
}

