local wezterm = require("wezterm")
local config = wezterm.config_builder()

config.font = wezterm.font("HackNerdFont", { weight = "Bold" })
config.font_size = 9
config.window_decorations = "NONE"
config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0,
}
config.enable_tab_bar = false
config.use_resize_increments = false
config.window_close_confirmation = "NeverPrompt"
config.check_for_updates = false

config.background = {
	{
		source = { Color = "#0b0712" },
		width = "100%",
		height = "100%",
		opacity = 0.85,
	},
}

return config
