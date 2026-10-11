-- Route specific apps to their assigned workspace/monitor.
-- Verify real window classes with `hyprctl clients` and adjust the match
-- patterns below if an app doesn't land on the expected workspace.

o.window("vivaldi-stable", { workspace = "1" })
-- Lafal is Tk with an empty title (see main_window.py). Match both so other
-- Tk apps aren't pulled onto workspace 1.
o.window({ class = "^Tk$", title = "^$" }, { workspace = "1" })
o.window("Hermes", { workspace = "4" })
o.window("com.anthropic.Claude", { workspace = "4" })
o.window("codex-desktop", { workspace = "4" })
o.window("md.obsidian.Obsidian", { workspace = "2" })
o.window("org.wezfurlong.wezterm", { workspace = "3" })
o.window("discord", { workspace = "5 silent" })
o.window(".*whatsapp.com__.*", { workspace = "5" })
o.window(".*youtube.com__.*", { workspace = "5" })
-- Override Omarchy's default Steam float; main window tiles on workspace 5.
o.window({ class = "^steam$", title = "^Steam$" }, { tile = true, workspace = "5" })
