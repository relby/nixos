local wezterm = require('wezterm')

local keys = {
    {
        key = 'Tab',
        mods = 'CTRL',
        action = wezterm.action.ActivateTabRelative(1),
    },
    {
        key = 'Tab',
        mods = 'CTRL|SHIFT',
        action = wezterm.action.ActivateTabRelative(-1),
    },
    {
        key = 't',
        mods = 'LEADER',
        action = wezterm.action.SpawnTab('CurrentPaneDomain'),
    },
    {
        key = 'w',
        mods = 'LEADER',
        action = wezterm.action.CloseCurrentTab({ confirm = false }),
    }
}

return keys
