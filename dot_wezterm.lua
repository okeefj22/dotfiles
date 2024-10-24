-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the config
local config = wezterm.config_builder()

config.font_size = 16
config.color_scheme = 'Catppuccin Frappe'
config.window_decorations = "RESIZE"

return config
