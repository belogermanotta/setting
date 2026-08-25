-- WezTerm config — starter (Windows). See https://wezfurlong.org/wezterm/config/
local wezterm = require 'wezterm'
local config = {}

-- Font: must be installed (install.ps1 -> JetBrainsMono Nerd Font)
config.font = wezterm.font('JetBrainsMono Nerd Font', { size = 12.0 })
config.font_size = 12.0

-- Color scheme (built-in)
config.color_scheme = 'Catppuccin Mocha'

-- Shell
config.default_prog = { 'pwsh.exe' }

-- UX
config.enable_tab_bar = true
config.scrollback_lines = 10000
config.window_padding = { left = 8, right = 8, top = 6, bottom = 6 }
config.window_close_confirmation = 'NeverPrompt'

-- Keybindings: ALT+d split right, ALT+Shift+d split down (CMD is taken by Windows)
config.keys = {
  {
    key = 'd',
    mods = 'ALT',
    action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' },
  },
  {
    key = 'D',
    mods = 'ALT|SHIFT',
    action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' },
  },
  {
    key = 'w',
    mods = 'ALT',
    action = wezterm.action.CloseCurrentPane { confirm = false },
  },
}

return config
