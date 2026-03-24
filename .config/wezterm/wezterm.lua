local wezterm = require("wezterm")
local config = {}

if wezterm.config_builder then
	config = wezterm.config_builder()
end

config.default_cursor_style = "SteadyBar"
config.automatically_reload_config = true
config.window_close_confirmation = "NeverPrompt"
config.adjust_window_size_when_changing_font_size = false
config.window_decorations = "TITLE | RESIZE"
config.check_for_updates = false
config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = true
config.enable_tab_bar = false
config.max_fps = 60
config.use_resize_increments = false
config.enable_kitty_graphics = true

config.font_size = 9
config.line_height = 1.0
config.font = wezterm.font("HackNerdFont", { weight = "Bold" })

config.window_padding = {
	bottom = 0,
	left = 0,
	right = 0,
	top = 0,
}

config.default_prog = { os.getenv("HOME") .. "/.cargo/bin/zellij" }

config.background = {
	{
		source = {
			File = os.getenv("HOME") .. "/.config/wezterm/dark-desert.jpg",
		},
		hsb = {
			hue = 1.0,
			saturation = 1.02,
			brightness = 0.25,
		},
	},
	{
		source = {
			Color = "#000000",
		},
		width = "100%",
		height = "100%",
		opacity = 0.85,
	},
}

config.hyperlink_rules = {
	{ regex = "\\((\\w+://\\S+)\\)", format = "$1", highlight = 1 },
	{ regex = "\\[(\\w+://\\S+)\\]", format = "$1", highlight = 1 },
	{ regex = "\\{(\\w+://\\S+)\\}", format = "$1", highlight = 1 },
	{ regex = "<(\\w+://\\S+)>", format = "$1", highlight = 1 },
	{ regex = "[^(]\\b(\\w+://\\S+[)/a-zA-Z0-9-]+)", format = "$1", highlight = 1 },
	{ regex = "\\b\\w+@[\\w-]+(\\.[\\w-]+)+\\b", format = "mailto:$0" },
}

return config
