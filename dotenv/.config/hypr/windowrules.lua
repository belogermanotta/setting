-- Route specific apps to their assigned workspace/monitor.
-- Verify real window classes with `hyprctl clients` and adjust the match
-- patterns below if an app doesn't land on the expected workspace.

o.window("vivaldi-stable", { workspace = "1" })
o.window("Hermes", { workspace = "4" })
o.window("com.anthropic.Claude", { workspace = "4" })
o.window("md.obsidian.Obsidian", { workspace = "2" })
o.window("org.wezfurlong.wezterm", { workspace = "3" })
o.window("discord", { workspace = "5" })
o.window(".*whatsapp.com__.*", { workspace = "5" })
o.window(".*youtube.com__.*", { workspace = "5" })
