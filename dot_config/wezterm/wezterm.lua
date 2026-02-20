-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the config
local config = wezterm.config_builder()

config.font_size = 16
config.color_scheme = 'Catppuccin Frappe'
config.window_decorations = "RESIZE"

-- wezterm key overrides and extensions
config.keys = {
	-- by default, left opt + num triggered a repeat key press
	-- Map Option-2 to euro symbol
	{
	  key = '2',
	  mods = 'OPT',
	  action = wezterm.action.SendString('€')
  	},
	-- Map Option-3 to hash symbol
	{
	  key = '3',
	  mods = 'OPT',
	  action = wezterm.action.SendString('#')
	}
}
return config
