-------------------------------------------------
-- Brightness Widget for Awesome Window Manager
-- Shows the brightness level of the laptop display
-- More details could be found here:
-- https://github.com/streetturtle/awesome-wm-widgets/tree/master/brightness-widget

-- @author Pavel Makhov
-- @copyright 2021 Pavel Makhov
-------------------------------------------------

local awful = require("awful")
local wibox = require("wibox")
local watch = require("awful.widget.watch")
local spawn = require("awful.spawn")
local naughty = require("naughty")
local beautiful = require("beautiful")

local dpi = require('beautiful').xresources.apply_dpi

local get_brightness_cmd
local set_brightness_cmd
local inc_brightness_cmd
local dec_brightness_cmd

local brightness_widget = {}

local function show_warning(message)
    naughty.notify({
        preset = naughty.config.presets.critical,
        title = "Brightness Widget",
        text = message,
    })
end

local function worker(user_args)
    local args = user_args or {}

    local type = "icon_and_text"
    local path_to_icon = os.getenv("HOME") .. "/.config/awesome/theme/icons/widgets/brightness/"
    local font = args.font or beautiful.font
    local timeout = 3

    local program = "brightnessctl"
    local step = args.step or 5
    --local base = args.base or 20
    local current_level = 0 -- current brightness value
    local tooltip = args.tooltip or false
    local percentage = true
    if program == 'light' then
        get_brightness_cmd = 'light -G'
        set_brightness_cmd = 'light -S %d' -- <level>
        inc_brightness_cmd = 'light -A ' .. step
        dec_brightness_cmd = 'light -U ' .. step
    elseif program == 'xbacklight' then
        get_brightness_cmd = 'xbacklight -get'
        set_brightness_cmd = 'xbacklight -set %d' -- <level>
        inc_brightness_cmd = 'xbacklight -inc ' .. step
        dec_brightness_cmd = 'xbacklight -dec ' .. step
    elseif program == 'brightnessctl' then
        get_brightness_cmd = 'sh -c "brightnessctl -m | cut -d, -f4 | tr -d %"'
        set_brightness_cmd = "brightnessctl set %d%%" -- <level>
        inc_brightness_cmd = "brightnessctl set +" .. step .. "%"
        dec_brightness_cmd = "brightnessctl set " .. step .. "-%"
    else
        show_warning(program .. " command is not supported by the widget")
        return
    end

    if type == 'icon_and_text' then
        brightness_widget.widget = wibox.widget {
            {
                {
                    id = "icon",
                    resize = true,
                    widget = wibox.widget.imagebox,
                },
                valign = 'center',
                layout = wibox.container.margin
            },
            {
                id = 'txt',
                font = font,
                widget = wibox.widget.textbox
            },
            spacing = 4,
            layout = wibox.layout.fixed.horizontal,
            set_value = function(self, level)
                local iconLevel
                local display_level = level
                if percentage then
                    display_level = display_level .. '%'
                end

                local levelnum = tonumber(level)

                if (levelnum >= 1 and levelnum < 14) then
                    iconLevel = "1"
                elseif (levelnum >= 14 and levelnum < 28) then
                    iconLevel = "2"
                elseif (levelnum >= 28 and levelnum < 42) then
                    iconLevel = "3"
                elseif (levelnum >= 42 and levelnum < 56) then
                    iconLevel = "4"
                elseif (levelnum >= 56 and levelnum < 70) then
                    iconLevel = "5"
                elseif (levelnum >= 70 and levelnum < 84) then
                    iconLevel = "6"
                else
                    iconLevel = "7"
                end

                self:get_children_by_id('icon')[1]:set_image(path_to_icon .. iconLevel .. ".png")
                self:get_children_by_id('txt')[1]:set_text(display_level)
            end
        }
    else
        show_warning(type .. " type is not supported by the widget")
        return

    end

    local update_widget = function(widget, stdout, _, _, _)
        local brightness_level = tonumber(string.format("%.0f", stdout))
        current_level = brightness_level
        widget:set_value(brightness_level)
    end

    function brightness_widget:set(value)
        current_level = value
        spawn.easy_async(string.format(set_brightness_cmd, value), function()
            spawn.easy_async(get_brightness_cmd, function(out)
                update_widget(brightness_widget.widget, out)
            end)
        end)
    end

    local old_level = 0
    function brightness_widget:toggle()
        if old_level < 0.1 then
            -- avoid toggling between '0' and 'almost 0'
            old_level = 1
        end
        if current_level < 0.1 then
            -- restore previous level
            current_level = old_level
        else
            -- save current brightness for later
            old_level = current_level
            current_level = 0
        end
        brightness_widget:set(current_level)
    end

    function brightness_widget:inc()
        spawn.easy_async(inc_brightness_cmd, function()
            spawn.easy_async(get_brightness_cmd, function(out)
                update_widget(brightness_widget.widget, out)
            end)
        end)
    end

    function brightness_widget:dec()
        spawn.easy_async(dec_brightness_cmd, function()
            spawn.easy_async(get_brightness_cmd, function(out)
                update_widget(brightness_widget.widget, out)
            end)
        end)
    end

    brightness_widget.widget:buttons(
        awful.util.table.join(
        -- awful.button({}, 1, function() brightness_widget:set(base) end),
        -- awful.button({}, 3, function() brightness_widget:toggle() end),
            awful.button({}, 4, function() brightness_widget:inc() end),
            awful.button({}, 5, function() brightness_widget:dec() end)
        )
    )

    watch(get_brightness_cmd, timeout, update_widget, brightness_widget.widget)

    if tooltip then
        awful.tooltip {
            objects        = { brightness_widget.widget },
            timer_function = function()
                return current_level .. " %"
            end,
        }
    end

    return brightness_widget.widget
end

return setmetatable(brightness_widget, {
    __call = function(_, ...)
        return worker(...)
    end,
})
