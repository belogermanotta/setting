#!/bin/bash
# Solaar G1–G5 → compositor Ctrl+Alt+Shift+F1–F5
key="${1:?F1-F5}"
log=/tmp/gkey-cas-f.log
echo "$(date +%H:%M:%S) $key HYPR=${HYPRLAND_INSTANCE_SIGNATURE:-unset} WAYLAND=${WAYLAND_DISPLAY:-unset}" >>"$log"
notify-send -u low "G-key" "Ctrl+Alt+Shift+$key" 2>>"$log" || true
down="hl.dsp.send_key_state({ mods = \"CTRL ALT SHIFT\", key = \"$key\", state = \"down\", window = \"activewindow\" })"
up="hl.dsp.send_key_state({ mods = \"CTRL ALT SHIFT\", key = \"$key\", state = \"up\", window = \"activewindow\" })"
if ! hyprctl dispatch "$down" >>"$log" 2>&1 || ! hyprctl dispatch "$up" >>"$log" 2>&1; then
  wtype -M ctrl -M alt -M shift -k "$key" -m shift -m alt -m ctrl >>"$log" 2>&1
fi
