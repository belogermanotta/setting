local wezterm = require("wezterm")
local act = wezterm.action
local action_callback = wezterm.action_callback
local mux = wezterm.mux

wezterm.on("gui-startup", function()
	local tab, pane, window = mux.spawn_window({})
	window:gui_window():maximize()
end)

return {
	hide_tab_bar_if_only_one_tab = true,
	animation_fps = 120,
	scrollback_lines = 50000,
	default_cursor_style = "BlinkingBar",
	window_frame = {
		font_size = 17.0,
	},
	font_size = 18.0,
	initial_cols = 200,
	initial_rows = 60,
	color_scheme = "tokyonight_night",
	inactive_pane_hsb = {
		saturation = 0.9,
		brightness = 0.7,
	},
	window_padding = { left = 0, right = 0, top = 0, bottom = 0 },

	keys = {

		{ key = "a", mods = "CMD|SHIFT", action = wezterm.action.QuickSelect, copy_on_select = true },

		-- Cmd-C: send Esc+c to Neovim
		{ key = "c", mods = "CMD", action = wezterm.action.SendString("\x1bc") },

		{
			key = "v",
			mods = "CMD",
			action = action_callback(function(window, pane)
				local prog = pane:get_foreground_process_name() or ""

				if prog:match("nvim") then
					-- send ESC p to Neovim
					window:perform_action(act.SendString("\x1bp"), pane)
				else
					window:perform_action(act.PasteFrom("Clipboard"), pane)
				end
			end),
		},
		-- Cmd-X: send Esc+x for "cut"
		{ key = "x", mods = "CMD", action = wezterm.action.SendString("\x1bx") },

		-- Cmd-A: send Esc+a for select-all
		{ key = "a", mods = "CMD", action = wezterm.action.SendString("\x1ba") },

		-- Cmd-S: send Esc+s for save
		{ key = "s", mods = "CMD", action = wezterm.action.SendString("\x1bs") },

		-- Cmd-Z: undo
		{ key = "z", mods = "CMD", action = wezterm.action.SendString("\x1bz") },

		-- Cmd-Shift-Z: redo
		{ key = "z", mods = "CMD|SHIFT", action = wezterm.action.SendString("\x1bZ") },

		-- Split window
		{ key = "_", mods = "CMD", action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
		{ key = "-", mods = "CMD", action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }) },
		{ key = "h", mods = "CMD", action = wezterm.action.ActivatePaneDirection("Left") },
		{ key = "j", mods = "CMD", action = wezterm.action.ActivatePaneDirection("Down") },
		{ key = "k", mods = "CMD", action = wezterm.action.ActivatePaneDirection("Up") },
		{ key = "l", mods = "CMD", action = wezterm.action.ActivatePaneDirection("Right") },

		-- MULTICURSOR (for later, if you use a plugin) ---------
		-- 🔹 Cmd+D = Ctrl+n  (add next cursor with vim-visual-multi)
		{ key = "d", mods = "CMD", action = act.SendKey({ key = "n", mods = "CTRL" }) },
		-- 🔹 Cmd+Shift+L = g<C-n> (select all occurrences)
		{
			key = "l",
			mods = "CMD|SHIFT",
			action = act.Multiple({
				act.SendString("g"),
				act.SendKey({ key = "n", mods = "CTRL" }),
			}),
		},

		-- WORD MOVEMENT WITH OPTION ----------------------------
		-- WezTerm already sends ESC+b / ESC+f for Option+Left/Right by default,
		-- which Neovim reads as "move by word", so you may not need extra config.
		-- Keeping arrows here in case you want explicit mappings later.

		-- CMD + ARROWS (line start/end) ------------------------
		{ key = "LeftArrow", mods = "CMD", action = act.SendString("\x1b0") }, -- ESC 0  -> go to line start
		{ key = "RightArrow", mods = "CMD", action = act.SendString("\x1b$") }, -- ESC $  -> go to line end
	},

	tab_bar_style = {
		new_tab = wezterm.format({
			{ Foreground = { Color = "#7aa2f7" } }, -- brighter blue
			{ Background = { Color = "#1f2335" } }, -- lighter background
			{ Text = " + " },
		}),
		new_tab_hover = wezterm.format({
			{ Foreground = { Color = "#ffffff" } },
			{ Background = { Color = "#2a2e47" } },
			{ Text = " + " },
		}),
	},
	colors = {
		tab_bar = {
			background = "#1f2335", -- much brighter than default (#0f0f10)

			active_tab = {
				bg_color = "#1a1b26", -- editable lighter background
				fg_color = "#c0caf5", -- the TokyoNight foreground blue
			},

			inactive_tab = {
				bg_color = "#2a2e47", -- brighter inactive tab
				fg_color = "#737aa2",
			},

			inactive_tab_hover = {
				bg_color = "#3b4261",
				fg_color = "#c0caf5",
			},

			new_tab = {
				bg_color = "#1f2335",
				fg_color = "#7aa2f7",
			},
			new_tab_hover = {
				bg_color = "#2a2e47",
				fg_color = "#ffffff",
			},
		},
	},
}
