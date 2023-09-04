

return {
    "L3MON4D3/LuaSnip",
    -- lazy = false,
    event = "InsertEnter",
    version = "2.*",
    -- build = "make install_jsregexp",
    config = function()
        local ls = require("luasnip")
        local snip = ls.snippet
        local text = ls.text_node

        ls.add_snippets(nil, {
            -- use for all langs
            all = {
                snip({
                    trig = "ae",
                    namr = "umlaut ae",
                    desc = "umlaut ä (lower)",
                }, { text("ä") }),
                snip({
                    trig = "Ae",
                    namr = "umlaut Ae",
                    desc = "umlaut Ä (upper)",
                }, { text("Ä") }),

                snip({
                    trig = "oe",
                    namr = "umlaut oe",
                    desc = "umlaut ö (lower)",
                }, { text("ö") }),
                snip({
                    trig = "Oe",
                    namr = "umlaut Oe",
                    desc = "umlaut Ö (upper)",
                }, { text("Ö") }),

                snip({
                    trig = "ue",
                    namr = "umlaut ue",
                    desc = "umlaut ü (lower)",
                }, { text("ü") }),
                snip({
                    trig = "Ue",
                    namr = "umlaut Ue",
                    desc = "umlaut Ü (upper)",
                }, { text("Ü") }),

                snip({
                    trig = "ss",
                    namr = "sharp s",
                    desc = "umlaut ß",
                }, { text("ß") }),
            },
        })

    end
}

