-- WezTerm config — starter (Linux). See https://wezfurlong.org/wezterm/config/
local wezterm = require 'wezterm'
local config = {}

-- Font: needs a Nerd Font installed (install.sh -> ttf-jetbrains-mono-nerd)
config.font = wezterm.font('JetBrainsMono Nerd Font', { size = 13.0 })
config.font_size = 13.0

-- Color scheme (built-in)
config.color_scheme = 'Catppuccin Mocha'

-- Shell
config.default_prog = { '/bin/zsh' }

-- UX
config.enable_tab_bar = true
config.scrollback_lines = 10000
config.window_padding = { left = 8, right = 8, top = 6, bottom = 6 }
config.window_close_confirmation = 'NeverPrompt'

-- Keybindings: SUPER+d split right, SUPER+Shift+d split down
config.keys = {
  {
    key = 'd',
    mods = 'SUPER',
    action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' },
  },
  {
    key = 'D',
    mods = 'SUPER|SHIFT',
    action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' },
  },
  {
    key = 'w',
    mods = 'SUPER',
    action = wezterm.action.CloseCurrentPane { confirm = false },
  },
}

return config
