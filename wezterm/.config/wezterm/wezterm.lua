-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices
config.color_scheme = 'rose-pine-moon'

-- Buttons are integrated inside the window instead of title bar:
-- config.window_decorations = 'RESIZE|INTEGRATED_BUTTONS'
config.window_decorations = 'RESIZE'
config.window_padding = {
  -- Uncomment if integrated buttons are set in window_decorations:
  -- top = 20
}

config.tab_bar_at_bottom = true

config.window_background_opacity = 0.5

-- From now on, colors were set manually
-- TODO: find a way to get color values directly from selected color_scheme
config.window_frame = {
  active_titlebar_bg = '#232136'
}

config.colors = {
  tab_bar = {
    background = '#232136',

    active_tab = {
      -- The color of the background area for the tab
      bg_color = '#44415a',
      -- The color of the text for the tab
      fg_color = '#e0def4',
    },
    -- Inactive tabs
    inactive_tab = {
      bg_color = '#232136',
      fg_color = '#e0def4',
    },
    -- New tab button
    new_tab = {
      bg_color = '#232136',
      fg_color = '#e0def4',
    }
  }
}

-- and finally, return the configuration to wezterm
return config
