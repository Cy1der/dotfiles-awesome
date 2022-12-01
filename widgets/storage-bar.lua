local awful = require("awful")
local watch = require("awful.widget.watch")
local wibox = require("wibox")
local beautiful = require("beautiful")
local gears = require("gears")

local xresources = require 'beautiful.xresources'
local dpi = xresources.apply_dpi

local storage_bar_widget = {}

local config = {}

config.mounts = { '/' }
config.refresh_rate = 60

config.widget_width = 40
config.widget_bar_color = '#586074'
config.widget_onclick_bg = '#ff0000'
config.widget_border_color = '#586074'
config.widget_background_color = '#1E2128'

config.popup_bg = '#1E2128'
config.popup_border_width = dpi(2)
config.popup_border_color = '#FFCC66'
config.popup_bar_color = '#586074'
config.popup_bar_background_color = '#1E2128'
config.popup_bar_border_color = '#586074'

local function round(num, numDecimalPlaces)
    local mult = 10 ^ (numDecimalPlaces or 0)
    return math.floor(num * mult + 0.5) / mult
end

local function worker(user_args)
    local args = user_args or {}

    local _config = {}
    for prop, value in pairs(config) do
        _config[prop] = args[prop] or beautiful[prop] or value
    end

    storage_bar_widget = wibox.widget {
        {
            id = 'progressbar',
            color = _config.widget_bar_color,
            max_value = 100,
            forced_height = 20,
            forced_width = _config.widget_width,
            paddings = 2,
            margins = 4,
            border_width = 1,
            border_radius = 0,
            border_color = _config.widget_border_color,
            background_color = _config.widget_background_color,
            widget = wibox.widget.progressbar
        },
        shape = function(cr, width, height)
            gears.shape.rounded_rect(cr, width, height, 4)
        end,
        widget = wibox.container.background,
        set_value = function(self, new_value)
            self:get_children_by_id("progressbar")[1].value = new_value
        end
    }

    local disk_rows = {
        { widget = wibox.widget.textbox },
        spacing = 4,
        layout = wibox.layout.fixed.vertical,
    }

    local disk_header = wibox.widget {
        {
            markup = '<b>Mount</b>',
            forced_width = 150,
            align = 'left',
            widget = wibox.widget.textbox,
        },
        {
            markup = '<b>Used</b>',
            align = 'left',
            widget = wibox.widget.textbox,
        },
        layout = wibox.layout.ratio.horizontal
    }
    disk_header:ajust_ratio(1, 0, 0.3, 0.7)

    local popup = awful.popup {
        bg = _config.popup_bg,
        ontop = true,
        visible = false,
        border_width = _config.popup_border_width,
        border_color = _config.popup_border_color,
        maximum_width = dpi(550),
        offset = { y = 5 },
        widget = {}
    }

    storage_bar_widget:buttons(
        awful.util.table.join(
            awful.button({}, 1, function()
                if popup.visible then
                    popup.visible = not popup.visible
                    storage_bar_widget:set_bg('#00000000')
                else
                    storage_bar_widget:set_bg(_config.widget_background_color)
                    popup:move_next_to(mouse.current_widget_geometry)
                end
            end)
        )
    )

    local disks = {}
    watch([[bash -c "df | tail -n +2"]], _config.refresh_rate,
        function(widget, stdout)
            for line in stdout:gmatch("[^\r\n$]+") do
                local filesystem, size, used, avail, perc, mount =
                line:match('([%p%w]+)%s+([%d%w]+)%s+([%d%w]+)%s+([%d%w]+)%s+([%d]+)%%%s+([%p%w]+)')

                disks[mount] = {}
                disks[mount].filesystem = filesystem
                disks[mount].size = size
                disks[mount].used = used
                disks[mount].avail = avail
                disks[mount].perc = perc
                disks[mount].mount = mount

                if disks[mount].mount == _config.mounts[1] then
                    widget:set_value(tonumber(disks[mount].perc))
                end
            end

            for k, v in ipairs(_config.mounts) do

                local row = wibox.widget {
                    {
                        text = disks[v].mount,
                        forced_width = 150,
                        widget = wibox.widget.textbox
                    },
                    {
                        color = _config.popup_bar_color,
                        max_value = 100,
                        value = tonumber(disks[v].perc),
                        forced_height = 20,
                        paddings = 1,
                        margins = 4,
                        border_width = 1,
                        border_color = _config.popup_bar_border_color,
                        background_color = _config.popup_bar_background_color,
                        bar_border_width = 1,
                        bar_border_color = _config.popup_bar_border_color,
                        widget = wibox.widget.progressbar,
                    },
                    {
                        text = round(disks[v].used / 1024 / 1024, 2)
                            .. '/'
                            .. round(disks[v].size / 1024 / 1024, 2) .. 'GB('
                            .. round(disks[v].perc, 2) .. '%)',
                        widget = wibox.widget.textbox
                    },
                    layout = wibox.layout.ratio.horizontal
                }
                row:ajust_ratio(2, 0.3, 0.3, 0.4)

                disk_rows[k] = row
            end
            popup:setup {
                {
                    disk_header,
                    disk_rows,
                    layout = wibox.layout.fixed.vertical,
                },
                margins = 8,
                widget = wibox.container.margin
            }
        end,
        storage_bar_widget
    )

    return storage_bar_widget
end

--[[
    text = math.floor(disks[v].used / 1024 / 1024)
    .. '/'
    .. math.floor(disks[v].size / 1024 / 1024) .. 'GB('
    .. math.floor(disks[v].perc) .. '%)',
]] --

return setmetatable(storage_bar_widget, { __call = function(_, ...)
    return worker(...)
end })
