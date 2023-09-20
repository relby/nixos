local wezterm = require('wezterm')
local utils = require('utils')

local config = {}

if wezterm.config_builder then
    config = wezterm.config_builder()
end

utils.merge(config, require('modules'))

return config
