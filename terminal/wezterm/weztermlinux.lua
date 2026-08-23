local wezterm = require("wezterm")
local config = {}

config.colors = {
	background = "#1a1b26",
}

config.enable_tab_bar = true
config.initial_rows = 45
config.initial_cols = 180

--config.window_decorations = "NONE"
config.window_decorations = "RESIZE"

config.font = wezterm.font_with_fallback({
	"Fira Code",
	"DengXian",
})

local mux = wezterm.mux

wezterm.on("gui-startup", function(cmd)
	if mux then
		local tab, pane, window = mux.spawn_window(cmd or {})
		window:gui_window():maximize()
	end
end)

config.hide_mouse_cursor_when_typing = false

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
	{
		key = "Enter",
		mods = "ALT",
		action = wezterm.action.ToggleFullScreen,
	},
	{
		key = "F11",
		action = wezterm.action.ToggleFullScreen,
	},
}

return config
