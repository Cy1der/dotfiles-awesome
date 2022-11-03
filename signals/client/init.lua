local awful = require 'awful'
require 'awful.autofocus'
local wibox = require 'wibox'

-- client.connect_signal('mouse::enter', function(c)
--    c:activate { context = 'mouse_enter', raise = false }
-- end)

client.connect_signal('request::titlebars', function(c)
   -- buttons for the titlebar
   local buttons = {
      awful.button {
         modifiers = {},
         button    = 1,
         on_press  = function()
            c:activate { context = 'titlebar', action = 'mouse_move' }
         end
      },
      awful.button {
         modifiers = {},
         button    = 3,
         on_press  = function()
            c:activate { context = 'titlebar', action = 'mouse_resize' }
         end
      },
   }

   awful.titlebar(c, { size = 36 }).widget = {
      {
         { -- Left
            wibox.container.margin(
               awful.titlebar.widget.stickybutton(c),
               7,
               7,
               7,
               7,
               "#1E2128"
            ),
            wibox.container.margin(
               awful.titlebar.widget.floatingbutton(c),
               7,
               7,
               7,
               7,
               "#1E2128"
            ),
            wibox.container.margin(
               awful.titlebar.widget.ontopbutton(c),
               7,
               7,
               7,
               7,
               "#1E2128"
            ),
            wibox.container.margin(
               awful.titlebar.widget.iconwidget(c),
               4,
               4,
               4,
               4,
               "#1E2128"
            ),
            buttons = buttons,
            layout = wibox.layout.fixed.horizontal
         },
         widget = wibox.container.margin
      },
      { -- Middle
         { -- Title
            align = "center",
            widget = awful.titlebar.widget.titlewidget(c)
         },
         buttons = buttons,
         layout = wibox.layout.flex.horizontal
      },
      { -- Right
         wibox.container.margin(
            awful.titlebar.widget.minimizebutton(c),
            7,
            7,
            7,
            7,
            "#1E2128"
         ),
         wibox.container.margin(
            awful.titlebar.widget.maximizedbutton(c),
            7,
            7,
            7,
            7,
            "#1E2128"
         ),
         wibox.container.margin(
            awful.titlebar.widget.closebutton(c),
            7,
            7,
            7,
            7,
            "#1E2128"
         ),
         layout = wibox.layout.fixed.horizontal()
      },
      layout = wibox.layout.align.horizontal
   }
end)
