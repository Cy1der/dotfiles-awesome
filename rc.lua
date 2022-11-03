-- awesome_mode: api-level=4:screen=on

-- load luarocks if installed
pcall(require, 'luarocks.loader')

local awful = require 'awful'

-- load theme
local beautiful = require 'beautiful'
beautiful.init(string.format("%s/.config/awesome/theme/theme.lua", os.getenv("HOME")))

-- load key and mouse bindings
require 'bindings'

-- load rules
require 'rules'

-- load signals
require 'signals'

-- load modules
require 'modules'

awful.spawn("bash /home/ahmed/.config/awesome/autostart")
