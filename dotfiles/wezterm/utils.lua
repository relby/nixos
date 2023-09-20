local M = {}

M.merge = function(first_table, second_table)
    for key, value in pairs(second_table) do
        first_table[key] = value
    end
end

M.concat = function(first_table, second_table)
    for _, value in ipairs(second_table) do
        table.insert(first_table, value)
    end

    return out
end

M.register_leader_keybindings_with_ctrl = function(keys)
    for _, key in ipairs(keys) do
        if key.mods == 'LEADER' then
            local new_key = {}
            M.merge(new_key, key)
            new_key.mods = 'LEADER|CTRL'
            table.insert(keys, new_key)
        end
    end
end

return M
