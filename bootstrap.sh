#!/usr/bin/env bash
#
# bootstrap.sh — get a fresh Linux box to "my machine" state in ~2 minutes.
#
#   git clone <this-repo-url> "$HOME/setting"
#   "$HOME/setting/bootstrap.sh" [--full] [--force]
#
# Steps:
#   1. install core CLI tools (distro-aware: pacman / apt / dnf)
#   2. symlink dotenv/* into $HOME (existing files are backed up with --force)
#   3. install oh-my-zsh + powerlevel10k + plugins (skips if present)
#   4. symlink nvim (linux flavor) and wezterm configs
#   5. apply obsidian/ snapshot to the notes vault (missing files only)
#   6. --full : restore the FULL machine image from others/linux/pkglist-arch.txt
#
set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
FULL=0
FORCE=0
while [[ $# -gt 0 ]]; do
  case "$1" in
    -f|--full)  FULL=1 ;;
    --force)    FORCE=1 ;;
    *) echo "usage: $0 [--full] [--force]" >&2; exit 1 ;;
  esac
  shift
done

info() { printf '\033[1;32m==>\033[0m %s\n' "$*"; }
warn() { printf '\033[1;33m==>\033[0m %s\n' "$*"; }
die()  { printf '\033[1;31m==>\033[0m %s\n' "$*" >&2; exit 1; }

link() { # link <src> <dst> — symlink src -> dst, backup existing with --force
  local src="$1" dst="$2"
  if [[ -e "$dst" || -L "$dst" ]]; then
    if [[ -L "$dst" && "$(readlink "$dst")" == "$src" ]]; then
      info "already linked: $dst"; return
    fi
    if [[ $FORCE -eq 1 ]]; then
      mv "$dst" "$dst.bak.$(date +%s)" && warn "backed up $dst -> $dst.bak.*"
    else
      warn "exists, skipping: $dst (re-run with --force to replace)"; return
    fi
  fi
  mkdir -p "$(dirname "$dst")"
  ln -s "$src" "$dst"
  info "linked $src -> $dst"
}

# --- 1. core tools -----------------------------------------------------------
if command -v pacman >/dev/null; then
  PM=pacman; INSTALL="sudo pacman -S --needed --noconfirm"
  PKG_FILE="$REPO_DIR/others/linux/core-tools-arch.txt"
elif command -v apt-get >/dev/null; then
  PM=apt; INSTALL="sudo apt-get install -y"
  PKG_FILE="$REPO_DIR/others/linux/core-tools-debian.txt"
elif command -v dnf >/dev/null; then
  PM=dnf; INSTALL="sudo dnf install -y"
  PKG_FILE="$REPO_DIR/others/linux/core-tools-fedora.txt"
else
  die "unsupported distro (only pacman/apt/dnf detected)"
fi
info "distro: $PM — installing core tools"
grep -v '^#' "$PKG_FILE" | xargs $INSTALL

# --- 2. zsh framework (BEFORE dotfiles: omz installer writes a stock .zshrc) ---
if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
  info "installing oh-my-zsh"
  RUNZSH=no CHSH=no sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
  rm -f "$HOME/.zshrc" # stock omz file — dotenv/.zshrc replaces it
fi
P10K="$HOME/.oh-my-zsh/custom/themes/powerlevel10k"
[[ -d "$P10K" ]] || git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$P10K"
for p in zsh-autosuggestions zsh-syntax-highlighting; do
  d="$HOME/.oh-my-zsh/custom/plugins/$p"
  [[ -d "$d" ]] || git clone --depth=1 "https://github.com/zsh-users/$p.git" "$d"
done

# --- 3. dotfiles -------------------------------------------------------------
info "linking dotfiles"
for f in .zshrc .p10k.zsh .bashrc .bash_profile .gitconfig .vimrc .ideavimrc; do
  [[ -f "$REPO_DIR/dotenv/$f" ]] && link "$REPO_DIR/dotenv/$f" "$HOME/$f"
done

# --- 4. nvim + wezterm ---------------------------------------------------------
link "$REPO_DIR/ide/nvimlinux/nvim" "$HOME/.config/nvim"
link "$REPO_DIR/ide/terminal/wezterm/weztermlinux.lua" "$HOME/.config/wezterm/wezterm.lua"
link "$REPO_DIR/dotenv/.config/hypr" "$HOME/.config/hypr"

# --- 5. Obsidian settings (sanitized snapshot -> vault) -------------------------
VAULT_DIR="${VAULT_DIR:-$HOME/notes}"
if [[ -d "$REPO_DIR/obsidian" ]]; then
  info "Obsidian settings -> $VAULT_DIR/.obsidian"
  if [[ -d "$VAULT_DIR/.obsidian" ]]; then
    if [[ $FORCE -eq 1 ]]; then
      mv "$VAULT_DIR/.obsidian" "$VAULT_DIR/.obsidian.bak.$(date +%s)" && warn "backed up .obsidian -> .obsidian.bak.*"
    fi
  fi
  mkdir -p "$VAULT_DIR/.obsidian"
  # missing files only (rsync /XC /XN /XO = skip existing)
  rsync -a --ignore-existing "$REPO_DIR/obsidian/" "$VAULT_DIR/.obsidian/"
  info "obsidian settings applied (missing files only; --force replaces all)"
else
  warn "no obsidian/ snapshot in repo — skipping"
fi

# --- default shell --------------------------------------------------------------
if [[ "${SHELL:-}" != *zsh ]]; then
  warn "changing default shell: chsh -s $(command -v zsh)"
  command -v chsh >/dev/null && chsh -s "$(command -v zsh)" || warn "chsh failed — run it manually"
fi

# --- 6. full image (optional) ----------------------------------------------------
if [[ $FULL -eq 1 ]]; then
  if [[ $PM == pacman ]]; then
    info "installing FULL package list (machine image restore)"
    grep -v '^#' "$REPO_DIR/others/linux/pkglist-arch.txt" | sudo pacman -S --needed --noconfirm -
  else
    warn "--full currently supports pacman only (pkglist-arch.txt)"
  fi
fi

info "done. Open a new terminal (zsh + p10k + nvim + wezterm are live)."
