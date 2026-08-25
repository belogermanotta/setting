#!/bin/bash
# Backs up existing dotfiles, then applies the onboarding configs.
# Idempotent: existing files are backed up once and never overwritten unless
# you pass --force.
# Usage: bash copy-config.sh [--force]
set -euo pipefail

FORCE="${1:-}"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_SRC="$SCRIPT_DIR/config"
VAULT_DIR="${VAULT_DIR:-$HOME/notes}"
BACKUP_DIR="$HOME/.config-backup-$(date +%Y%m%d-%H%M%S)"

[ -d "$CONFIG_SRC" ] || { echo "config/ not found next to this script"; exit 1; }
mkdir -p "$BACKUP_DIR"

apply() {
  local src="$CONFIG_SRC/$1" dst="$HOME/$2"
  if [ ! -f "$src" ]; then echo "  (skip) $2 — no source in config/"; return; fi
  if [ -f "$dst" ]; then
    cp "$dst" "$BACKUP_DIR/$2" 2>/dev/null || true
    echo "  backup: $2 -> $BACKUP_DIR/$2"
    if [ "$FORCE" != "--force" ]; then
      echo "  (keep)  $2 already exists — use --force to overwrite"
      return
    fi
  fi
  mkdir -p "$(dirname "$dst")"
  cp "$src" "$dst"
  echo "  apply:  $2"
}

echo "==> Backing up existing configs to $BACKUP_DIR"
apply .zshrc .zshrc
apply gitconfig .gitconfig
apply editorconfig .editorconfig
apply wezterm.lua .config/wezterm/wezterm.lua
apply nvim-init.lua .config/nvim/init.lua

echo "==> Obsidian settings -> $VAULT_DIR/.obsidian"
if [ -d "$SCRIPT_DIR/../../obsidian" ]; then
  if [ -d "$VAULT_DIR/.obsidian" ]; then
    cp -r "$VAULT_DIR/.obsidian" "$BACKUP_DIR/obsidian" 2>/dev/null || true
    echo "  backup: .obsidian -> $BACKUP_DIR/obsidian"
  fi
  mkdir -p "$VAULT_DIR/.obsidian"
  if [ "$FORCE" = "--force" ]; then
    cp -r "$SCRIPT_DIR/../../obsidian/." "$VAULT_DIR/.obsidian/"
    echo "  apply:  .obsidian (overwrite)"
  else
    rsync -a --ignore-existing "$SCRIPT_DIR/../../obsidian/" "$VAULT_DIR/.obsidian/"
    echo "  apply:  .obsidian (missing files only)"
  fi
else
  echo "  (skip) obsidian/ not found next to this script"
fi

echo "==> Done. Backups (if any) are in $BACKUP_DIR"
echo "Next: set your git identity ->  git config --global user.name / user.email"
