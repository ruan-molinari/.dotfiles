-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices
config.color_scheme = 'rose-pine-moon'

config.tab_bar_at_bottom = true

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
