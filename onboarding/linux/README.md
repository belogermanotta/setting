# Linux onboarding playbook

What to do when setting up a Linux box. Run top to bottom. Reusable — no
company names, no job specifics. Arch/pacman is first-class (your home
stack); apt/dnf get the core CLI + flatpak notes.

```
onboarding/linux/
├── README.md                  ← you are here
├── install.sh                 ← [3] installs everything (distro-aware)
├── copy-config.sh             ← [4] backs up + applies dotfiles & Obsidian settings
├── sync.sh                    ← daily note sync (script + git commit/push)
├── local.daily-note-calendar-sync.service/.timer  ← systemd user timer (00:00)
└── config/                    ← settings copy-config.sh applies
    ├── .zshrc                 (p10k, zoxide, eza, fzf-tab, plugins)
    ├── gitconfig
    ├── editorconfig
    ├── wezterm.lua
    └── nvim-init.lua
```

Shared with all platforms: `../../obsidian/` (sanitized Obsidian settings) and
`Resources/scripts/` in the vault (the calendar sync script).

---

## 0. Before you start (from another machine)

1. **GitHub access** — SSH public key added (`github.com/settings/ssh/new`).
2. **The two secret files** — `token.json` + `client_secret.json` from
   `Resources/scripts/` (gitignored; USB / private cloud, never email).
3. **Vault clone URL** — `git@github.com:<you>/notes.git`.

## 1. Base system

- Install a desktop environment if the distro didn't ship one (Arch+Hyprland
  if it's your daily driver).
- Enable the firewall, disk encryption (LUKS at install time) if not already.

## 2. Install everything — `install.sh`

```bash
cd <vault>/onboarding/linux
bash install.sh git@github.com:<you>/notes.git
```

Detects pacman/apt/dnf:

- **Arch**: git, go, node, python, neovim, ripgrep, fzf, jq, bat, eza, zoxide,
  lazygit, yq, tldr, glow, wget, zsh, **wezterm, obsidian, vivaldi, code**,
  **ttf-jetbrains-mono-nerd**, p10k + zsh plugins, python calendar libs,
  vault clone.
- **apt/dnf**: the core CLI set + zsh + p10k + plugins + python libs. GUI
  apps come via flatpak (see README below). Vault clone included.

Then add your user to groups as needed (docker, etc.).

## 3. Apply your configs — `copy-config.sh`

```bash
cd ~/notes/onboarding/linux
bash copy-config.sh          # --force to overwrite existing
```

- **Backs up** existing `~/.zshrc`, `~/.gitconfig`, `~/.editorconfig`,
  `~/.config/wezterm/wezterm.lua`, `~/.config/nvim/init.lua`, and the vault's
  `.obsidian/` into `~/.config-backup-<ts>/`
- **Applies** the kit's settings (missing files only; `--force` overwrites),
  including the sanitized Obsidian snapshot from `../../obsidian/` (configs +
  themes only — plugin binaries come from the vault clone).
- Then set your identity:
  ```bash
  git config --global user.name "Your Name"
  git config --global user.email "you@example.com"
  ```

First zsh shell auto-launches the **p10k configure wizard** — pick Rainbow /
Unicode / 1-line.

## 4. Notes vault + calendar sync

```bash
# 4a. Drop the two secret files in (from step 0):
cp <transferred>/token.json ~/notes/Resources/scripts/
cp <transferred>/client_secret.json ~/notes/Resources/scripts/

# 4b. Test — no browser prompt, the saved token just works:
cd ~/notes/Resources/scripts
python3 calendar_to_daily.py --dry-run
python3 calendar_to_daily.py
```

### 4c. Schedule it — systemd user timer (daily 00:00)

```bash
cp ~/notes/onboarding/linux/local.daily-note-calendar-sync.{service,timer} ~/.config/systemd/user/
systemctl --user daemon-reload
systemctl --user enable --now local.daily-note-calendar-sync.timer
systemctl --user list-timers | grep daily-note
```

Each run: writes today's note (creating it from the template if missing),
then commits + pushes so other devices never see a stale repo. Logs:
`journalctl --user -u local.daily-note-calendar-sync`.

To stop later: `systemctl --user disable --now local.daily-note-calendar-sync.timer`

## 5. AI agent (optional)

Same as the macOS kit — see `../macos/AI-AGENT.md`.

## 6. Daily workflow

1. Open Obsidian → today's note already exists with calendar events + tasks
   under `# Todo Day Planner`
2. Tick tasks off — they sync via the vault repo
3. Add events/tasks anywhere → the 00:00 run (or `python3 calendar_to_daily.py`)
   folds them in

## Corporate caveats

- **Work calendar / work data** → keep in company systems, not the personal
  vault. Free/busy-only sync is the safe middle ground if ever needed.

## Troubleshooting

| Symptom | Fix |
|---|---|
| p10k prompt is a plain `%` / no icons | `p10k configure`; if icons show as `?`, pick the Nerd Font in WezTerm (`CMD+Shift+R` to reload) |
| Script says `Missing Google libraries` | `python3 -m pip install --user google-api-python-client google-auth-oauthlib` |
| `Added 0 task(s)` | Normal — nothing new today |
| Timer not firing | `systemctl --user status local.daily-note-calendar-sync.timer` + `journalctl --user -u local.daily-note-calendar-sync` |
| Git push rejected | `git pull --rebase --autostash` then push (phone may have pushed) |
