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

-- OmaJump: controls, visible text, and scroll regions on every screen.
o.bind("SUPER + ALT + CTRL + SPACE", "OmaJump", "omarchy-shell shell toggle io.github.belogermanotta.omajump '{}'")
o.bind("SUPER + ALT + CTRL + SLASH", "OmaJump text search", "omarchy-shell shell summon io.github.belogermanotta.omajump '{\"mode\":\"search\"}'")
o.bind("SUPER + ALT + CTRL + P", "OmaJump copy paragraph", "omarchy-shell shell summon io.github.belogermanotta.omajump '{\"mode\":\"paragraph\"}'")
hl.unbind("SUPER + CTRL + ALT + Z")
o.bind("SUPER + CTRL + ALT + Z", "Omazendo notes", "omarchy-shell shell toggle io.github.belogermanotta.omazendo '{}'")
o.bind("SUPER + ALT + CTRL + N", "Omazendo quick note", "omarchy-shell shell summon io.github.belogermanotta.omazendo '{\"page\":\"quick-note\"}'")

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
hl.unbind("CTRL + ALT + 6")
o.bind("CTRL + ALT + SHIFT + L", "Lafal: Lafalify (TTS)", "/mnt/Data/WORK/lafal/dist/Lafal/Lafal --trigger-action tts")
o.bind("ESCAPE", "Lafal: Cancel Lafalify", "/mnt/Data/WORK/lafal/dist/Lafal/Lafal --trigger-action tts_cancel", { non_consuming = true })

-- Dictation is a single toggle bind, not a press/release pair -- o.bind
-- only fires on press, and Lafal's own trigger_action("dictate") handler
-- already simulates a full instant tap (press+release) per call, which
-- its existing hybrid-mode logic treats as "open a session" on the first
-- tap and "close + transcribe it" on the next (see app.py's
-- _on_dictate_toggle_action). Alt_R, matching Lafal's own configured
-- Right Alt default -- Control_R above is a different app (voxtype).
o.bind("Alt_R", "Lafal: Toggle dictation", "/mnt/Data/WORK/lafal/dist/Lafal/Lafal --trigger-action dictate")

-- IJKL as extra arrow-key equivalents (SUPER+arrows already do this;
-- these are additive, nothing existing is unbound)
-- SUPER+ALT+K was previously bound to "Tmux keybindings" (default binding); unbound below.
hl.unbind("SUPER + ALT + K")
o.bind("SUPER + ALT + J", "Focus on left window", hl.dsp.focus({ direction = "l" }))
o.bind("SUPER + ALT + L", "Focus on right window", hl.dsp.focus({ direction = "r" }))
o.bind("SUPER + ALT + I", "Focus on above window", hl.dsp.focus({ direction = "u" }))
o.bind("SUPER + ALT + K", "Focus on below window", hl.dsp.focus({ direction = "d" }))
o.bind("SUPER + ALT + CTRL + H", "OmaJump scroll regions", "omarchy-shell shell summon io.github.belogermanotta.omajump '{\"mode\":\"scroll\"}'")
o.bind("SUPER + ALT + CTRL + J", "Focus on left window", hl.dsp.focus({ direction = "l" }))
o.bind("SUPER + ALT + CTRL + L", "Focus on right window", hl.dsp.focus({ direction = "r" }))
o.bind("SUPER + ALT + CTRL + I", "Focus on above window", hl.dsp.focus({ direction = "u" }))
o.bind("SUPER + ALT + CTRL + K", "Focus on below window", hl.dsp.focus({ direction = "d" }))
o.bind("SUPER + CTRL + ALT + LEFT", "Focus on left window", hl.dsp.focus({ direction = "l" }))
o.bind("SUPER + CTRL + ALT + RIGHT", "Focus on right window", hl.dsp.focus({ direction = "r" }))
o.bind("SUPER + CTRL + ALT + UP", "Focus on above window", hl.dsp.focus({ direction = "u" }))
o.bind("SUPER + CTRL + ALT + DOWN", "Focus on below window", hl.dsp.focus({ direction = "d" }))

-- G502 X PLUS sniper is Ctrl+W in the mouse onboard profile (Solaar),
-- not a Hyprland mouse bind. mouse:276 is thumb-forward, not sniper.


-- G815 G1–G5 often appear as F13–F17 once onboard profiles are off.
local function cas_fn(fn)
  return function()
    local ok = pcall(function()
      hl.dispatch(hl.dsp.send_key_state({ mods = "CTRL ALT SHIFT", key = fn, state = "down", window = "activewindow" }))
      hl.dispatch(hl.dsp.send_key_state({ mods = "CTRL ALT SHIFT", key = fn, state = "up", window = "activewindow" }))
    end)
    if not ok then
      hl.dispatch(hl.dsp.exec_cmd("wtype -M ctrl -M alt -M shift -k " .. fn .. " -m shift -m alt -m ctrl"))
    end
  end
end
o.bind("F13", "G1 → Ctrl+Alt+Shift+F1", cas_fn("F1"))
o.bind("F14", "G2 → Ctrl+Alt+Shift+F2", cas_fn("F2"))
o.bind("F15", "G3 → Ctrl+Alt+Shift+F3", cas_fn("F3"))
o.bind("F16", "G4 → Ctrl+Alt+Shift+F4", cas_fn("F4"))
o.bind("F17", "G5 → Ctrl+Alt+Shift+F5", cas_fn("F5"))
