-- Keep only your personal keybinding overrides here. Add new bindings or
-- unbind defaults before replacing them.

-- See current bindings and descriptions:
--   omarchy menu keybindings --print

-- To disable every Omarchy default binding, set this in
-- ~/.config/hypr/hyprland.lua before require("default.hypr.omarchy"), then add
-- only the bindings you want below:
--   omarchy_default_bindings = false

-- To disable all preinstalled app/webapp bindings, set:
--   omarchy_preinstalled_bindings = false

-- Add a new binding.
-- o.bind("SUPER + SHIFT + R", "SSH", "alacritty -e ssh your-server")

-- Change an existing binding by unbinding it first, then binding the key again.
-- This example changes SUPER+SPACE from the launcher to the Omarchy root menu.
-- hl.unbind("SUPER + SPACE")
-- o.bind("SUPER + SPACE", "Omarchy menu", "omarchy-menu toggle root")

-- Disable a default binding without replacing it.
-- hl.unbind("SUPER + SHIFT + B")

-- Rebind Toggle dictation from SUPER+CTRL+X to right Alt (tap)
o.bind("Control_R", "Toggle dictation", "voxtype record toggle")

-- Logitech MX Keys examples:
-- o.bind("SUPER + SHIFT + S", nil, "omarchy-capture-screenshot")
-- o.bind("SUPER + H", nil, "voxtype record toggle")
-- o.bind("SUPER + PERIOD", nil, "omarchy-shell shell toggle omarchy.emojis")

-- Lafal: plain shell commands, not real global hotkey grabs -- pynput's
-- X11-based listener can't reliably reach a native-Wayland-focused app
-- (see lafal/hotkey.py's module docstring), so these call
-- `--trigger-action` instead, which relays into the already-running
-- instance over its local single-instance socket. Lafal needs to already
-- be running (tray icon or a background launch) for these to do
-- anything -- each just exits quietly if it isn't.
o.bind("CTRL + ALT + 1", "Lafal: Proofread", "/mnt/Data/WORK/lafal/dist/Lafal/Lafal --trigger-action proofread")
o.bind("CTRL + ALT + 2", "Lafal: Concise", "/mnt/Data/WORK/lafal/dist/Lafal/Lafal --trigger-action concise")
o.bind("CTRL + ALT + 3", "Lafal: Rephrase", "/mnt/Data/WORK/lafal/dist/Lafal/Lafal --trigger-action rephrase")
o.bind("CTRL + ALT + 4", "Lafal: Summarize", "/mnt/Data/WORK/lafal/dist/Lafal/Lafal --trigger-action summarize")
o.bind("CTRL + ALT + 5", "Lafal: Fact Check", "/mnt/Data/WORK/lafal/dist/Lafal/Lafal --trigger-action fact_check")
o.bind("CTRL + ALT + 6", "Lafal: Lafalify (TTS)", "/mnt/Data/WORK/lafal/dist/Lafal/Lafal --trigger-action tts")

-- IJKL as extra arrow-key equivalents (SUPER+arrows already do this;
-- these are additive, nothing existing is unbound)
o.bind("SUPER + ALT + CTRL + J", "Focus on left window", hl.dsp.focus({ direction = "l" }))
o.bind("SUPER + ALT + CTRL + L", "Focus on right window", hl.dsp.focus({ direction = "r" }))
o.bind("SUPER + ALT + CTRL + I", "Focus on above window", hl.dsp.focus({ direction = "u" }))
o.bind("SUPER + ALT  + CTRL + K", "Focus on below window", hl.dsp.focus({ direction = "d" }))
