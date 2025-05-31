-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

config.send_composed_key_when_left_alt_is_pressed = true;
config.use_dead_keys = true;
config.use_ime = true;

-- This is where you actually apply your config choices
config.color_scheme = 'rose-pine'

config.font = wezterm.font_with_fallback { 'CaskaydiaCove Nerd Font Mono', 'JetBrains Mono' }
config.font_size = 16.0

-- Buttons are integrated inside the window instead of title bar:
-- config.window_decorations = 'RESIZE|INTEGRATED_BUTTONS'
config.window_decorations = 'RESIZE|INTEGRATED_BUTTONS'

config.window_padding = {
  -- Uncomment if integrated buttons are set in window_decorations:
  top = 30
}

config.tab_bar_at_bottom = false

config.window_background_opacity = 1.00

-- From now on, colors were set manually
-- TODO: find a way to get color values directly from selected color_scheme
config.window_frame = {
  active_titlebar_bg = '#232136'
}

config.colors = {

  -- Selection background was not set, for some reason.
  -- Maybe it's the rose-pine theme...
  selection_bg = '#44415a';

  -- For some reason color_scheme does not apply to tab and window styles,
  -- have to set it manually.
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
