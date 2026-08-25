# AI agent on the new Mac

Setup guide for installing an AI coding/assistant agent and pointing it at
your notes vault. Pick ONE agent — everything else is the same.

> ⚠️ Corporate policy first: many companies restrict external AI tools on
> work machines. Check IT policy before installing anything. If AI tools are
> banned, stop here — the rest of the playbook doesn't need an agent.

## 1. Pick your agent

| Agent | What it is | Install |
|---|---|---|
| **Claude Code** | Terminal coding agent (Anthropic) | `npm install -g @anthropic-ai/claude-code` |
| **Codex** | Terminal coding agent (OpenAI) | `npm install -g @openai/codex` |
| **Hermes** | Full personal assistant (what runs at home) | see https://hermes-agent.nousresearch.com/docs |

Node is already installed by `install.sh`, so the npm commands just work.

## 2. Keys

- Claude Code → `export ANTHROPIC_API_KEY=...`
- Codex → `export OPENAI_API_KEY=...`
- Hermes → provider keys via its own setup

Put the export in `~/.zshrc` (or the agent's own config file). **Never** in
the vault repo — the repo syncs to other devices and may be shared.

## 3. Give the agent context

The vault IS the agent's workspace. Two files matter:

- **`~/notes/AGENTS.md`** — the hook every agent reads on startup. It points
  to the memory file and states the conventions.
- **`~/notes/AI-notes/MEMORY.md`** — the actual agent memory: who you are,
  communication rules, project rules, environment notes. Read this FIRST.
  ⚠️ It is **gitignored / local-only** — the agent may read it but must never
  commit it or copy secrets from it into a note.

First thing after installing the agent: open it in `~/notes` and ask it to
read `AI-notes/MEMORY.md` and confirm it understands the conventions.

## 4. Conventions the agent must follow

These are enforced by `AGENTS.md` + `MEMORY.md`, but worth knowing:

- **Git**: commit with `hermes: ` prefix; always `git pull --rebase --autostash`
  before push; never commit `.obsidian/` UI-state files (workspace.json,
  recent-files data.json, ...); commit content only.
- **Scope**: only touch the project the user names — never wander.
- **No clarifying questions**: the user prefers execute → figure it out → ask
  only when truly stuck.
- **Secrets**: never write passwords/keys into any note.
- **The calendar sync** lives at `Resources/scripts/calendar_to_daily.py` —
  idempotent, safe to run anytime:
  `python3 Resources/scripts/calendar_to_daily.py`

## 5. Policy guardrails

- **No work data into the personal vault.** Work calendar, work docs, code
  from the job — keep them in company systems. The vault is personal.
- If you want the agent to look at work code, do it in a work-scoped folder
  with company-sanctioned tooling — not in this vault.
- Free/busy-only calendar sync is the safe middle ground if you ever want
  the day-shape in notes without content.

## 6. Smoke test

```bash
cd ~/notes
# start your agent (e.g. `claude`, `codex`, `hermes`)
# then ask: "Read AI-notes/MEMORY.md and summarize what I need to know."
# then: "Run the calendar sync script for today."
```

Both should work without you repeating context — that's the whole point.
