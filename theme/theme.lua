local themes_path = string.format("%s/.config/awesome/theme/", os.getenv("HOME"))
local dpi = require("beautiful.xresources").apply_dpi

-- {{{ Main
local theme = {}
theme.wallpaper = themes_path .. "background.png"

theme.icon_theme = "Win11-Dark"

-- {{{ Styles
theme.font = "ComicCodeLigatures Nerd Font Regular 10"
theme.notification_font = "ComicCodeLigatures Nerd Font Regular 12"
theme.taglist_font = "ComicCodeLigatures Nerd Font Regular 12"

-- {{{ Colors
theme.fg_normal  = "#586074"
theme.fg_focus   = "#FFCC66"
theme.fg_urgent  = "#FF5250"
theme.bg_normal  = "#1E2128"
theme.bg_focus   = "#1E2128"
theme.bg_urgent  = "#1E2128"
theme.bg_systray = theme.bg_normal
-- }}}

-- {{{ Borders
theme.useless_gap       = dpi(4)
theme.gap_single_client = true
theme.border_width      = dpi(2)
theme.border_normal     = "#1E2128"
theme.border_focus      = "#FFCC66"
theme.border_marked     = "#FF5250"
-- }}}

-- {{{ Titlebars
theme.titlebar_bg_focus  = "#1E2128"
theme.titlebar_bg_normal = "#1E2128"
-- }}}

theme.systray_icon_spacing = dpi(4)

-- There are other variable sets
-- overriding the default one when
-- defined, the sets are:
-- [taglist|tasklist]_[bg|fg]_[focus|urgent|occupied|empty|volatile]
-- titlebar_[normal|focus]
-- tooltip_[font|opacity|fg_color|bg_color|border_width|border_color]
-- Example:
--theme.taglist_bg_focus = "#CC9393"
-- }}}

-- {{{ Widgets
-- You can add as many variables as
-- you wish and access them by using
-- beautiful.variable in your rc.lua
--theme.fg_widget        = "#AECF96"
--theme.fg_center_widget = "#88A175"
--theme.fg_end_widget    = "#FF5656"
--theme.bg_widget        = "#494B4F"
--theme.border_widget    = "#3F3F3F"
-- }}}

-- {{{ Mouse finder
theme.mouse_finder_color = "#FF5250"
-- mouse_finder_[timeout|animate_timeout|radius|factor]
-- }}}

-- {{{ Menu
-- Variables set for theming the menu:
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
theme.menu_height       = dpi(25)
theme.menu_width        = dpi(250)
theme.menu_border_color = "#FFCC66"
theme.menu_border_width = dpi(2)
-- }}}

-- {{{ Icons
-- {{{ Taglist
theme.taglist_squares_sel   = themes_path .. "icons/taglist/squarefz.png"
theme.taglist_squares_unsel = themes_path .. "icons/taglist/squarez.png"
--theme.taglist_squares_resize = "false"
-- }}}

-- {{{ Misc
theme.awesome_icon      = themes_path .. "icons/menu/awesome.png"
theme.menu_submenu_icon = themes_path .. "icons/menu/submenu.png"
-- }}}

-- {{{ Layout
theme.layout_tile       = themes_path .. "icons/layouts/tile.png"
theme.layout_tileleft   = themes_path .. "icons/layouts/tileleft.png"
theme.layout_tilebottom = themes_path .. "icons/layouts/tilebottom.png"
theme.layout_tiletop    = themes_path .. "icons/layouts/tiletop.png"
theme.layout_fairv      = themes_path .. "icons/layouts/fairv.png"
theme.layout_fairh      = themes_path .. "icons/layouts/fairh.png"
theme.layout_spiral     = themes_path .. "icons/layouts/spiral.png"
theme.layout_dwindle    = themes_path .. "icons/layouts/dwindle.png"
theme.layout_max        = themes_path .. "icons/layouts/max.png"
theme.layout_fullscreen = themes_path .. "icons/layouts/fullscreen.png"
theme.layout_magnifier  = themes_path .. "icons/layouts/magnifier.png"
theme.layout_floating   = themes_path .. "icons/layouts/floating.png"
theme.layout_cornernw   = themes_path .. "icons/layouts/cornernw.png"
theme.layout_cornerne   = themes_path .. "icons/layouts/cornerne.png"
theme.layout_cornersw   = themes_path .. "icons/layouts/cornersw.png"
theme.layout_cornerse   = themes_path .. "icons/layouts/cornerse.png"
-- }}}

-- {{{ Titlebar
theme.titlebar_close_button_focus = themes_path .. "icons/titlebar/right/close/focus.png"
theme.titlebar_close_button_focus_hover = themes_path .. "icons/titlebar/right/close/focus-hover.png"
theme.titlebar_close_button_focus_press = themes_path .. "icons/titlebar/right/close/focus-press.png"
theme.titlebar_close_button_normal = themes_path .. "icons/titlebar/right/close/normal.png"
theme.titlebar_close_button_normal_hover = themes_path .. "icons/titlebar/right/close/normal-hover.png"
theme.titlebar_close_button_normal_press = themes_path .. "icons/titlebar/right/close/normal-press.png"

theme.titlebar_minimize_button_focus = themes_path .. "icons/titlebar/right/minimize/focus.png"
theme.titlebar_minimize_button_focus_hover = themes_path .. "icons/titlebar/right/minimize/focus-hover.png"
theme.titlebar_minimize_button_focus_press = themes_path .. "icons/titlebar/right/minimize/focus-press.png"
theme.titlebar_minimize_button_normal = themes_path .. "icons/titlebar/right/minimize/normal.png"
theme.titlebar_minimize_button_normal_hover = themes_path .. "icons/titlebar/right/minimize/normal-hover.png"
theme.titlebar_minimize_button_normal_press = themes_path .. "icons/titlebar/right/minimize/normal-press.png"

theme.titlebar_maximized_button_focus_active          = themes_path ..
    "icons/titlebar/right/maximize/focus-press.png"
theme.titlebar_maximized_button_normal_active         = themes_path .. "icons/titlebar/right/maximize/normal.png"
theme.titlebar_maximized_button_focus_inactive        = themes_path .. "icons/titlebar/right/maximize/focus.png"
theme.titlebar_maximized_button_normal_inactive       = themes_path .. "icons/titlebar/right/maximize/normal.png"
theme.titlebar_maximized_button_focus_active_hover    = themes_path ..
    "icons/titlebar/right/maximize/focus-hover.png"
theme.titlebar_maximized_button_normal_active_hover   = themes_path ..
    "icons/titlebar/right/maximize/normal-hover.png"
theme.titlebar_maximized_button_focus_inactive_hover  = themes_path ..
    "icons/titlebar/right/maximize/focus-hover.png"
theme.titlebar_maximized_button_normal_inactive_hover = themes_path ..
    "icons/titlebar/right/maximize/normal-hover.png"
theme.titlebar_maximized_button_focus_active_press    = themes_path ..
    "icons/titlebar/right/maximize/focus-press.png"
theme.titlebar_maximized_button_normal_active_press   = themes_path ..
    "icons/titlebar/right/maximize/normal-press.png"
theme.titlebar_maximized_button_focus_inactive_press  = themes_path ..
    "icons/titlebar/right/maximize/focus-press.png"
theme.titlebar_maximized_button_normal_inactive_press = themes_path ..
    "icons/titlebar/right/maximize/normal-press.png"

theme.titlebar_sticky_button_normal_inactive = themes_path .. "icons/titlebar/left/sticky/normal.png"
theme.titlebar_sticky_button_normal_inactive_hover = themes_path .. "icons/titlebar/left/sticky/inactive.png"
theme.titlebar_sticky_button_normal_inactive_press = themes_path .. "icons/titlebar/left/sticky/inactive.png"
theme.titlebar_sticky_button_normal_active = themes_path .. "icons/titlebar/left/sticky/normal.png"
theme.titlebar_sticky_button_normal_active_hover = themes_path .. "icons/titlebar/left/sticky/active.png"
theme.titlebar_sticky_button_normal_active_press = themes_path .. "icons/titlebar/left/sticky/active.png"
theme.titlebar_sticky_button_focus_inactive = themes_path .. "icons/titlebar/left/sticky/inactive.png"
theme.titlebar_sticky_button_focus_inactive_hover = themes_path .. "icons/titlebar/left/sticky/inactive.png"
theme.titlebar_sticky_button_focus_inactive_press = themes_path .. "icons/titlebar/left/sticky/inactive.png"
theme.titlebar_sticky_button_focus_active = themes_path .. "icons/titlebar/left/sticky/active.png"
theme.titlebar_sticky_button_focus_active_hover = themes_path .. "icons/titlebar/left/sticky/active.png"
theme.titlebar_sticky_button_focus_active_press = themes_path .. "icons/titlebar/left/sticky/active.png"

theme.titlebar_ontop_button_normal_inactive = themes_path .. "icons/titlebar/left/ontop/normal.png"
theme.titlebar_ontop_button_normal_inactive_hover = themes_path .. "icons/titlebar/left/ontop/inactive.png"
theme.titlebar_ontop_button_normal_inactive_press = themes_path .. "icons/titlebar/left/ontop/inactive.png"
theme.titlebar_ontop_button_normal_active = themes_path .. "icons/titlebar/left/ontop/normal.png"
theme.titlebar_ontop_button_normal_active_hover = themes_path .. "icons/titlebar/left/ontop/active.png"
theme.titlebar_ontop_button_normal_active_press = themes_path .. "icons/titlebar/left/ontop/active.png"
theme.titlebar_ontop_button_focus_inactive = themes_path .. "icons/titlebar/left/ontop/inactive.png"
theme.titlebar_ontop_button_focus_inactive_hover = themes_path .. "icons/titlebar/left/ontop/inactive.png"
theme.titlebar_ontop_button_focus_inactive_press = themes_path .. "icons/titlebar/left/ontop/inactive.png"
theme.titlebar_ontop_button_focus_active = themes_path .. "icons/titlebar/left/ontop/active.png"
theme.titlebar_ontop_button_focus_active_hover = themes_path .. "icons/titlebar/left/ontop/active.png"
theme.titlebar_ontop_button_focus_active_press = themes_path .. "icons/titlebar/left/ontop/active.png"

theme.titlebar_floating_button_normal_inactive = themes_path .. "icons/titlebar/left/floating/normal.png"
theme.titlebar_floating_button_normal_inactive_hover = themes_path .. "icons/titlebar/left/floating/inactive.png"
theme.titlebar_floating_button_normal_inactive_press = themes_path .. "icons/titlebar/left/floating/inactive.png"
theme.titlebar_floating_button_normal_active = themes_path .. "icons/titlebar/left/floating/normal.png"
theme.titlebar_floating_button_normal_active_hover = themes_path .. "icons/titlebar/left/floating/active.png"
theme.titlebar_floating_button_normal_active_press = themes_path .. "icons/titlebar/left/floating/active.png"
theme.titlebar_floating_button_focus_inactive = themes_path .. "icons/titlebar/left/floating/inactive.png"
theme.titlebar_floating_button_focus_inactive_hover = themes_path .. "icons/titlebar/left/floating/inactive.png"
theme.titlebar_floating_button_focus_inactive_press = themes_path .. "icons/titlebar/left/floating/inactive.png"
theme.titlebar_floating_button_focus_active = themes_path .. "icons/titlebar/left/floating/active.png"
theme.titlebar_floating_button_focus_active_hover = themes_path .. "icons/titlebar/left/floating/active.png"
theme.titlebar_floating_button_focus_active_press = themes_path .. "icons/titlebar/left/floating/active.png"

-- }}}
-- }}}

return theme
