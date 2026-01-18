local wezterm = require("wezterm")
local config = {}

-- Use WSL Ubuntu as default
config.default_prog = { "wsl.exe", "~" }

config.colors = {
	background = "#1a1b26",
}

config.enable_bracketed_paste = false
config.enable_tab_bar = true
config.initial_rows = 40
config.initial_cols = 150

--config.window_decorations = "NONE"
config.window_decorations = "RESIZE"

config.keys = {
	{
		key = "w",
		mods = "CTRL",
		action = wezterm.action.CloseCurrentTab({ confirm = true }),
	},
	-- Copy with Alt+C (keep this for terminal)
	{
		key = "c",
		mods = "ALT",
		action = wezterm.action.CopyTo("Clipboard"),
	},
	-- Paste with Alt+V (keep this for terminal)
	{
		key = "v",
		mods = "ALT",
		action = wezterm.action.PasteFrom("Clipboard"),
	},

	-- Send Escape sequences for Neovim keymaps
	-- Copy (Ctrl+C in visual mode)
	{
		key = "c",
		mods = "ALT",
		action = wezterm.action.SendString("\x1bc"),
	},
	{
		key = "c",
		mods = "CTRL",
		action = wezterm.action.SendString("\x1bc"),
	},
	-- Paste (Ctrl+V)
	{
		key = "v",
		mods = "CTRL",
		action = wezterm.action.SendString("\x1bp"),
	},
	-- Cut (Ctrl+X)
	{
		key = "x",
		mods = "CTRL",
		action = wezterm.action.SendString("\x1bx"),
	},
	-- Select All (Ctrl+A)
	{
		key = "a",
		mods = "CTRL",
		action = wezterm.action.SendString("\x1ba"),
	},
	-- Save (Ctrl+S)
	{
		key = "s",
		mods = "CTRL",
		action = wezterm.action.SendString("\x1bs"),
	},
	-- Close buffer (Ctrl+W)
	{
		key = "w",
		mods = "CTRL",
		action = wezterm.action.SendString("\x1bw"),
	},
	-- Undo (Ctrl+Z)
	{
		key = "z",
		mods = "CTRL",
		action = wezterm.action.SendString("\x1bz"),
	},
	-- Redo (Ctrl+Shift+Z)
	{
		key = "Z",
		mods = "CTRL|SHIFT",
		action = wezterm.action.SendString("\x1bZ"),
	},

	-- Windows/Super + 1-9 to switch to tab
	{ key = "1", mods = "SUPER", action = wezterm.action.ActivateTab(0) },
	{ key = "2", mods = "SUPER", action = wezterm.action.ActivateTab(1) },
	{ key = "3", mods = "SUPER", action = wezterm.action.ActivateTab(2) },
	{ key = "4", mods = "SUPER", action = wezterm.action.ActivateTab(3) },
	{ key = "5", mods = "SUPER", action = wezterm.action.ActivateTab(4) },
	{ key = "6", mods = "SUPER", action = wezterm.action.ActivateTab(5) },
	{ key = "7", mods = "SUPER", action = wezterm.action.ActivateTab(6) },
	{ key = "8", mods = "SUPER", action = wezterm.action.ActivateTab(7) },
	{ key = "9", mods = "SUPER", action = wezterm.action.ActivateTab(8) },
}

return config
