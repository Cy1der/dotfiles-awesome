pcall(require, 'luarocks.loader')
local awful = require 'awful'
local beautiful = require 'beautiful'
beautiful.init(string.format("%s/.config/awesome/theme/theme.lua", os.getenv("HOME")))
require 'bindings'
require 'rules'
require 'signals'
require 'modules'
awful.util.spawn_with_shell("bash ~/.config/awesome/autostart")
