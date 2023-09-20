local utils = require('utils')

local config = {
    disable_default_key_bindings = false,
    leader = { key = 'Space', mods = 'CTRL' },
    keys = {},
}

utils.concat(config.keys, require('modules/key-bindings/panes'))
utils.concat(config.keys, require('modules/key-bindings/tabs'))

utils.register_leader_keybindings_with_ctrl(config.keys)

return config
