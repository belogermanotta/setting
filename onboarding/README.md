# Onboarding

What to do when you get a new laptop — reusable across jobs, no company names.

## Platforms

- [**macOS**](macos/README.md) — corporate enrollment → system settings → dev toolchain → notes + calendar sync → daily workflow
- [**Windows**](windows/README.md) — winget one-shot install → PowerShell 7 + oh-my-posh (p10k theme) → notes + calendar sync → Task Scheduler
- [**Linux**](linux/README.md) — distro-aware install (pacman/apt/dnf) → zsh + p10k → notes + calendar sync → systemd timer

## Shared across platforms

- `obsidian/` — sanitized `.obsidian` snapshot (plugins, themes, settings; no credentials, no UI state) applied by each platform's copy-config script
- The vault's `Resources/scripts/calendar_to_daily.py` — the calendar+tasks → daily note sync
- `macos/AI-AGENT.md` — AI agent setup + conventions (platform-agnostic)

## How to use

Follow the playbook top to bottom the day you unbox the laptop. Anything marked
`⚠️` is a decision point or a corporate-policy check — read before acting.
