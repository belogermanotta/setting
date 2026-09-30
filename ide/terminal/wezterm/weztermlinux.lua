local wezterm = require("wezterm")
local config = {}

-- Follow the Omarchy theme: regenerated on every `omarchy theme set` from
-- ~/.config/omarchy/themed/wezterm-colors.lua.tpl.
local theme_colors_path = wezterm.home_dir .. "/.local/state/omarchy/current/theme/wezterm-colors.lua"
wezterm.add_to_config_reload_watch_list(theme_colors_path)
local ok, theme_colors = pcall(dofile, theme_colors_path)
if ok then
	config.colors = theme_colors
else
	config.colors = {
		background = "#1a1b26",
	}
end

config.enable_tab_bar = true
config.initial_rows = 45
config.initial_cols = 180

--config.window_decorations = "NONE"
config.window_decorations = "RESIZE"

config.font = wezterm.font_with_fallback({
	"Fira Code",
	"FiraCode Nerd Font",
	"Symbols Nerd Font Mono",
	"DengXian",
})

local mux = wezterm.mux

wezterm.on("gui-startup", function(cmd)
	if mux then
		local tab, pane, window = mux.spawn_window(cmd or {})
		-- Plain startup (autostart) has no program. Omarchy TUI launches pass
		-- args via xdg-terminal-exec and must stay sizeable.
		if not (cmd and cmd.args and #cmd.args > 0) then
			window:gui_window():maximize()
		end
	end
end)

config.hide_mouse_cursor_when_typing = false

-- Neovim maps want ESC+letter. spf (and everything else) needs the real
-- control character; otherwise copy/cut/paste/compress never arrive.
local function nvim_or_ctrl(ctrl_byte, nvim_seq)
	return wezterm.action_callback(function(window, pane)
		local name = pane:get_foreground_process_name() or ""
		local base = name:match("[^/]+$") or ""
		local seq = (base == "nvim" or base == "vim" or base == "vi") and nvim_seq or ctrl_byte
		window:perform_action(wezterm.action.SendString(seq), pane)
	end)
end

-- superfile image preview uses the kitty graphics protocol.
config.enable_kitty_graphics = true


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
		action = nvim_or_ctrl("\x03", "\x1bc"),
	},
	-- Paste (Ctrl+V)
	{
		key = "v",
		mods = "CTRL",
		action = nvim_or_ctrl("\x16", "\x1bp"),
	},
	-- Cut (Ctrl+X)
	{
		key = "x",
		mods = "CTRL",
		action = nvim_or_ctrl("\x18", "\x1bx"),
	},
	-- Select All (Ctrl+A)
	{
		key = "a",
		mods = "CTRL",
		action = nvim_or_ctrl("\x01", "\x1ba"),
	},
	-- Save (Ctrl+S)
	{
		key = "s",
		mods = "CTRL",
		action = nvim_or_ctrl("\x13", "\x1bs"),
	},
	-- Close buffer (Ctrl+W)
	{
		key = "w",
		mods = "CTRL",
		action = nvim_or_ctrl("\x17", "\x1bw"),
	},
	-- Undo (Ctrl+Z)
	{
		key = "z",
		mods = "CTRL",
		action = nvim_or_ctrl("\x1a", "\x1bz"),
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
	-- Scroll ~1/5 page without PageUp/PageDown (Ctrl+U/D left for nvim/shell)
	{
		key = "UpArrow",
		mods = "CTRL",
		action = wezterm.action.ScrollByPage(-0.2),
	},
	{
		key = "DownArrow",
		mods = "CTRL",
		action = wezterm.action.ScrollByPage(0.2),
	},
}

return config
