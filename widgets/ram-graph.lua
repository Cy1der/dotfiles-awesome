local awful = require("awful")
local beautiful = require("beautiful")
local watch = require("awful.widget.watch")
local wibox = require("wibox")
local dpi = require("beautiful.xresources").apply_dpi

local ramgraph_widget = {}

local function worker()
    local timeout         = 1
    local color_used      = "#FF5250"
    local color_free      = beautiful.fg_normal
    local color_buf       = "#43A047"
    local widget_show_buf = true
    local widget_height   = 50
    local widget_width    = 50

    --- Main ram widget shown on wibar
    ramgraph_widget = wibox.widget {
        border_width = 0,
        colors = {
            color_used,
            color_free,
            color_buf,
        },
        display_labels = false,
        forced_height = widget_height,
        forced_width = widget_width,
        widget = wibox.widget.piechart
    }

    --- Widget which is shown when user clicks on the ram widget
    local popup = awful.popup {
        ontop = true,
        visible = false,
        widget = {
            widget = wibox.widget.piechart,
            forced_height = 200,
            forced_width = 400,
            colors = {
                color_used,
                color_free,
                color_buf, -- buf_cache
            },
        },
        border_color = "#FFCC66",
        border_width = dpi(2),
        offset = { y = 5 },
    }

    local total, used, free, shared, buff_cache, available, total_swap, used_swap, free_swap

    local function getPercentage(value)
        return math.floor(value / (total + total_swap) * 100 + 0.5) .. '%'
    end

    watch('bash -c "LANGUAGE=en_US.UTF-8 free | grep -z Mem.*Swap.*"', timeout,
        function(widget, stdout)
            total, used, free, shared, buff_cache, available, total_swap, used_swap, free_swap =
            stdout:match('(%d+)%s*(%d+)%s*(%d+)%s*(%d+)%s*(%d+)%s*(%d+)%s*Swap:%s*(%d+)%s*(%d+)%s*(%d+)')

            if widget_show_buf then
                widget.data = { used, free, buff_cache }
            else
                widget.data = { used, total - used }
            end

            if popup.visible then
                popup:get_widget().data_list = {
                    { 'used ' .. getPercentage(used + used_swap), used + used_swap },
                    { 'free ' .. getPercentage(free + free_swap), free + free_swap },
                    { 'buff_cache ' .. getPercentage(buff_cache), buff_cache }
                }
            end
        end,
        ramgraph_widget
    )

    ramgraph_widget:buttons(
        awful.util.table.join(
            awful.button({}, 1, function()
                popup:get_widget().data_list = {
                    { 'used ' .. getPercentage(used + used_swap), used + used_swap },
                    { 'free ' .. getPercentage(free + free_swap), free + free_swap },
                    { 'buff_cache ' .. getPercentage(buff_cache), buff_cache }
                }

                if popup.visible then
                    popup.visible = not popup.visible
                else
                    popup:move_next_to(mouse.current_widget_geometry)
                end
            end)
        )
    )

    return ramgraph_widget
end

return setmetatable(ramgraph_widget, { __call = function(_, ...)
    return worker(...)
end })
