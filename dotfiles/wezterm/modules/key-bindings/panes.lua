local wezterm = require('wezterm')
local utils = require('utils')

local keys = {
    {
        key = 'v',
        mods = 'LEADER',
        action = wezterm.action.SplitHorizontal({ domain = 'CurrentPaneDomain' }),
    },
    {
        key = 's',
        mods = 'LEADER',
        action = wezterm.action.SplitVertical({ domain = 'CurrentPaneDomain' }),
    },
    {
        key = 'q',
        mods = 'LEADER',
        action = wezterm.action.CloseCurrentPane({ confirm = false }),
    },
    {
        key = 'f',
        mods = 'LEADER',
        action = wezterm.action.TogglePaneZoomState,
    },
}

for key, direction in pairs({ h = 'Left', j = 'Down', k = 'Up', l = 'Right' }) do
    table.insert(keys, {
        key = key,
        mods = 'LEADER',
        action = wezterm.action.ActivatePaneDirection(direction)
    })
end

return keys
