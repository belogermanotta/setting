-- Extra autostart processes.
o.launch_on_start("vivaldi-stable")
o.launch_on_start("/home/kobe/.hermes/hermes-agent/venv/bin/hermes desktop")
o.launch_on_start("sh -c 'sleep 2; claude-desktop'")
o.launch_on_start("obsidian")
o.launch_on_start("wezterm")
o.launch_on_start("sh -c 'sleep 3; /home/kobe/.config/hypr/scripts/vivaldi-second-window.sh'")

-- Workspace 5 (scrolling): launch order sets left-to-right column order.
o.launch_on_start("sh -c 'sleep 2; discord'")
o.launch_on_start("sh -c 'sleep 5; omarchy-launch-webapp https://web.whatsapp.com/'")
o.launch_on_start("sh -c 'sleep 8; omarchy-launch-webapp https://music.youtube.com'")
