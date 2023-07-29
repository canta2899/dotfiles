local languages = require("canta2899.languages")

local M = {}

function M.get_language(field)
    local out_t = {}

    for _, value in pairs(languages) do
        if value[field] then table.insert(out_t, value[field]) end
    end

    return out_t
end


return M
