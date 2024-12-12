
local umlaut = {}

local registered = false

local replacements = {
    ["ae"] = "ä",
    ["Ae"] = "Ä",

    ["ue"] = "ü",
    ["Ue"] = "Ü",

    ["oe"] = "ö",
    ["Oe"] = "Ö",
    ["ss"] = "ß",
}

umlaut.setup = function()
    if registered then return end

    local has_cmp, cmp = pcall(require, "cmp")
    if not has_cmp then return end

    local source = {}
    source.new = function()
        return setmetatable({}, { __index = source })
    end

    function source:complete(req, cb)
        local input = string.sub(req.context.cursor_before_line, req.offset - 1)
        -- local prefix = string.sub(req.context.cursor_before_line, 1, req.offset - 1)

        local items = {}
        for lbl, rep in pairs(replacements) do
            table.insert(items, {
                -- filterText = lbl,
                label = lbl,
                textEdit = {
                    newText = rep,
                    range = {
                        start = {
                            line = req.context.cursor.row - 1,
                            character = req.context.cursor.col - 1 - #input,
                        },
                        ["end"] = {
                            line = req.context.cursor.row - 1,
                            character = req.context.cursor.col - 1,
                        },
                    },
                }
            })
        end

        cb({ items = items, isIncomplete = true })
    end

    cmp.register_source("umlaut", source.new())
end

return umlaut

