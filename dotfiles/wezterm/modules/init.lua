local utils = require('utils')

local config = {}

utils.merge(config, require('modules/ui'))
utils.merge(config, require('modules/key-bindings'))

return config
