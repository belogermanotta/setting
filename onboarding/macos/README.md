# macOS onboarding playbook

What to do the day a new Mac laptop arrives. Run top to bottom. Everything in
this folder is reusable — no company names, no job specifics.

```
onboarding/macos/
├── README.md                  ← you are here
├── install.sh                 ← [3] installs every dependency
├── copy-config.sh             ← [4] backs up + applies dotfiles
├── AI-AGENT.md                ← [6] install + wire up an AI agent
├── sync.sh                    ← daily note sync (script + git commit/push)
├── com.daily-note-calendar-sync.plist  ← LaunchAgent (runs sync.sh at 00:00)
└── config/                    ← settings copy-config.sh applies
    ├── .zshrc                 (p10k, zoxide, eza, fzf-tab, plugins)
    ├── gitconfig
    ├── editorconfig
    ├── wezterm.lua
    └── nvim-init.lua
```

---

## 0. Before you start (do this from your home machine)

1. **GitHub access** — your SSH public key must be added to GitHub so the
   vault clone works: `github.com/settings/ssh/new`
2. **The two secret files** — `token.json` and `client_secret.json` from your
   home machine's `Resources/scripts/` (they are gitignored, so they do NOT
   come with the repo). Transfer them over USB or private cloud — **never**
   through company email.
3. **The vault clone URL** — `git@github.com:<you>/notes.git` (or whatever
   your notes repo is).

---

## 1. Corporate enrollment (do FIRST, before anything personal)

The company image will prompt you for its own enrollment:

- Join the company **management profile** (MDM) — this is non-optional and
  happens before anything else
- Install the company **VPN** and **endpoint protection** if prompted
- Sign in to the **work email** in whatever mail client it configures
- Do NOT mix personal accounts into the work browser profile yet — keep work
  and personal separate from day one

> ⚠️ If IT says "we install everything for you", let them finish first, then
> do the rest of this playbook for personal tooling that's allowed.

## 2. System settings (10 min)

- **Apple ID**: sign in with your personal one (iCloud). FileVault ON
  (System Settings → Privacy & Security → FileVault).
- **Software Update** — let it finish before step 3.
- Keyboard → Key repeat fast / delay short; **Caps Lock → Esc** if you like.
- Trackpad: tap-to-click, natural scrolling (or not — your call).
- Timezone / region auto-detect on.
- Dock → minimize windows into application icon (or leave default).

## 3. Install everything — `install.sh`

```bash
cd <vault>/onboarding/macos
bash install.sh git@github.com:<you>/notes.git
```

This installs: Xcode CLT, Homebrew, git, gh, go, node, python 3.12, neovim,
ripgrep, fzf, jq, bat, fd, **eza, zoxide, lazygit, yq, tldr, glow**, wget,
**Vivaldi, Obsidian, WezTerm, VS Code**, the **JetBrains Mono Nerd Font**
(required by p10k/WezTerm), Powerlevel10k + zsh-autosuggestions +
zsh-syntax-highlighting + fzf-tab, the Python packages the calendar sync
needs, and clones the notes vault to `~/notes`.

> If you skipped the clone URL, or want it elsewhere:
> `git clone git@github.com:<you>/notes.git ~/notes`
> and `open ~/notes` with Obsidian → "Open folder as vault".

## 4. Apply your configs — `copy-config.sh`

```bash
cd ~/notes/onboarding/macos
bash copy-config.sh
```

- **Backs up** anything already at `~/.zshrc`, `~/.gitconfig`,
  `~/.editorconfig`, `~/.config/wezterm/wezterm.lua`,
  `~/.config/nvim/init.lua`, and the vault's `.obsidian/` into
  `~/.config-backup-<ts>/`
- **Copies** the kit's defaults into place (only if missing; `--force` to
  overwrite), including the **sanitized `.obsidian` snapshot** (shared at
  `../../obsidian/`) — your Obsidian **configs + themes** (plugin data.json,
  manifests, app settings), minus plugin binaries, credentials and machine
  state (workspace layout, recent files, remotely-save secrets). Plugin code
  comes from the vault clone. Point it at a different vault with
  `VAULT_DIR=/path/to/vault bash copy-config.sh`.
- Then set your identity:
  ```bash
  git config --global user.name "Your Name"
  git config --global user.email "you@example.com"
  ```

> These are minimal starter configs. If you have real dotfiles at home
> (nvim/zsh), bring them over and replace — the kit is the fallback, not the
> ceiling.

### 4b. Powerlevel10k wizard (2 min, one-time)

Your first zsh shell after `copy-config.sh` auto-launches the p10k configure
wizard — answer the prompts (recommended: *Rainbow* style, *Unicode* icons,
*1-line* layout). It writes `~/.p10k.zsh`. Re-run anytime with `p10k configure`.

## 5. Notes vault + calendar sync (the important bit)

The vault is already at `~/notes` and contains the sync script at
`~/notes/Resources/scripts/calendar_to_daily.py`.

```bash
# 5a. Drop the two secret files into place (from step 0):
cp <wherever-you-transferred-them>/token.json ~/notes/Resources/scripts/
cp <wherever-you-transferred-them>/client_secret.json ~/notes/Resources/scripts/

# 5b. Test — no browser prompt, the saved token just works:
cd ~/notes/Resources/scripts
python3 calendar_to_daily.py --dry-run
python3 calendar_to_daily.py
```

You should see something like `Added 2 task(s) to Daily Log/2026-08-25.md`.

### 5c. Schedule it — LaunchAgent (runs at 00:00 daily)

```bash
# point the plist at your vault (replace the placeholder):
sed -i '' 's|VAULT_DIR_PLACEHOLDER|/Users/'"$USER"'/notes|' \
  ~/notes/onboarding/macos/com.daily-note-calendar-sync.plist

cp ~/notes/onboarding/macos/com.daily-note-calendar-sync.plist \
   ~/Library/LaunchAgents/
launchctl bootstrap gui/$(id -u) ~/Library/LaunchAgents/local.daily-note-calendar-sync.plist
```

Each run: writes today's note (creating it from the template if missing, same
as the HOME.md button), then commits + pushes so the phone and other machines
never see a stale repo. Logs: `/tmp/daily-note-sync.log` / `.err`.

To uninstall later: `launchctl bootout gui/$(id -u)/local.daily-note-calendar-sync`

## 6. AI agent (optional but recommended)

The laptop can run your AI assistant/coding agent the same way your home
machine does. See **[AI-AGENT.md](AI-AGENT.md)** for: which agent to pick
(Claude Code / Codex / Hermes), keys, pointing it at the vault
(`AI-notes/MEMORY.md` as its memory), and the conventions it must follow.

> ⚠️ Corporate policy first — if IT bans external AI tools, skip this section;
> nothing else in the playbook needs an agent.

## 7. Daily workflow

1. Open Obsidian → today's note already exists with calendar events + tasks
   under `# Todo Day Planner`
2. Tick tasks off as you go (they sync to your phone via the vault repo)
3. Add events/tasks on any device → the 00:00 run (or a manual
   `python3 calendar_to_daily.py`) folds them in

## Corporate caveats

- **`pip install` blocked / proxy kills Google APIs** → stop, don't fight it;
  there's an iCal fallback variant of the sync that needs no Python packages.
- **Work calendar** (the company Google/Exchange account) → keep it in the
  company calendar app. Syncing work events into a personal notes repo is a
  data-handling risk under most employment agreements. If you ever need a
  day-shape view, a free/busy-only sync (no titles) is the safe middle
  ground — ask your assistant.

## Troubleshooting

| Symptom | Fix |
|---|---|
| `zsh: command not found: brew` after install | `eval "$(/opt/homebrew/bin/brew shellenv)"` or open a new terminal |
| p10k prompt is a plain `%` / no icons | run `p10k configure`; if icons show as `?`, the Nerd Font isn't selected in WezTerm (`config/wezterm.lua` → `CMD+Shift+R` to reload) |
| zsh suggestions/highlighting not working | re-run `bash install.sh` (clones into `~/.zsh-custom/`), or check the paths in `.zshrc` |
| Script says `Missing Google libraries` | `python3 -m pip install --user --break-system-packages google-api-python-client google-auth-oauthlib` |
| `Added 0 task(s)` | Normal — means nothing new today, or your calendars are empty |
| LaunchAgent not firing | `launchctl print gui/$(id -u)/local.daily-note-calendar-sync` and check `/tmp/daily-note-sync.err` |
| Git push rejected | `git pull --rebase --autostash` then push again (phone may have pushed) |
