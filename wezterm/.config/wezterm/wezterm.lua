local wezterm = require("wezterm")
-- local bar = wezterm.plugin.require("https://github.com/adriankarlen/bar.wezterm")

local config = wezterm.config_builder()

-- tabline
local bar = require("tab")
bar.apply_to_config(config, {
	padding = {
		tabs = {
			left = 2,
			right = 2,
		},
	},
	modules = {
		workspace = { enabled = false },
		username = { enabled = false },
		hostname = { enabled = false },
		clock = { enabled = false },
		cwd = { enabled = false },
	},
	separator = {
		space = 1,
		left_icon = "",
		right_icon = "",
		field_icon = "",
	},
})

-- color scheme
config.color_scheme = "Tokyo Night"

-- window appearance
config.window_decorations = "RESIZE"
config.window_background_opacity = 0.7
config.window_padding = { left = 0, right = 0, top = 0, bottom = 0 }

-- cursor
config.cursor_blink_rate = 0

-- font
config.font = wezterm.font_with_fallback({
	{ family = "Hack Nerd Font", weight = "Regular" },
})
config.font_size = 16.0

-- key bindings
config.leader = { key = "a", mods = "ALT", timeout_milliseconds = 1000 }
config.keys = {
	-- launch terminal
	{
		key = "Enter",
		mods = "CTRL|SHIFT",
		action = wezterm.action.SpawnCommandInNewTab({
			cwd = wezterm.home_dir,
		}),
	},

	-- window management
	{
		key = "w",
		mods = "ALT",
		action = wezterm.action.CloseCurrentPane({ confirm = false }),
	},
	{
		key = "Enter",
		mods = "ALT",
		action = wezterm.action.SplitPane({
			direction = "Right",
		}),
	},

	-- tab management
	{
		key = "t",
		mods = "ALT",
		action = wezterm.action.SpawnTab("CurrentPaneDomain"),
	},
	{
		key = "n",
		mods = "ALT",
		action = wezterm.action.SpawnTab("CurrentPaneDomain"),
	},
	{
		key = "q",
		mods = "ALT",
		action = wezterm.action.CloseCurrentTab({ confirm = false }),
	},

	-- tab navigation
	{
		key = "1",
		mods = "ALT",
		action = wezterm.action.ActivateTab(0),
	},
	{
		key = "2",
		mods = "ALT",
		action = wezterm.action.ActivateTab(1),
	},
	{
		key = "3",
		mods = "ALT",
		action = wezterm.action.ActivateTab(2),
	},
	{
		key = "4",
		mods = "ALT",
		action = wezterm.action.ActivateTab(3),
	},
	{
		key = "5",
		mods = "ALT",
		action = wezterm.action.ActivateTab(4),
	},
	{
		key = "6",
		mods = "ALT",
		action = wezterm.action.ActivateTab(5),
	},

	-- tab switching with arrows and hjkl
	{
		key = "LeftArrow",
		mods = "ALT",
		action = wezterm.action.ActivateTabRelative(-1),
	},
	{
		key = "RightArrow",
		mods = "ALT",
		action = wezterm.action.ActivateTabRelative(1),
	},
	{
		key = "h",
		mods = "ALT",
		action = wezterm.action.ActivateTabRelative(-1),
	},
	{
		key = "l",
		mods = "ALT",
		action = wezterm.action.ActivateTabRelative(1),
	},

	-- scrolling
	{
		key = "j",
		mods = "ALT",
		action = wezterm.action.ScrollByLine(1),
	},
	{
		key = "k",
		mods = "ALT",
		action = wezterm.action.ScrollByLine(-1),
	},
	{
		key = "d",
		mods = "ALT",
		action = wezterm.action.ScrollByLine(1),
	},
	{
		key = "u",
		mods = "ALT",
		action = wezterm.action.ScrollByLine(-1),
	},
}

return config
