#!/bin/bash
# macOS dependency installer — run once after unboxing.
# Usage: bash install.sh [git-clone-url-of-your-notes-vault]
#   e.g. bash install.sh git@github.com:you/notes.git
# Set VAULT_DIR to change where the vault is cloned (default: ~/notes).
set -euo pipefail

VAULT_URL="${1:-}"
VAULT_DIR="${VAULT_DIR:-$HOME/notes}"

echo "==> [1/6] Xcode Command Line Tools (a GUI prompt may appear — accept it)"
xcode-select -p >/dev/null 2>&1 || xcode-select --install

echo "==> [2/6] Homebrew"
if ! command -v brew >/dev/null 2>&1; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  eval "$(/opt/homebrew/bin/brew shellenv)"   # Apple Silicon
fi

echo "==> [3/6] Packages (git, go, node, python, neovim, shell tools)"
brew install git gh go node python@3.12 neovim ripgrep fzf jq bat fd eza zoxide lazygit yq tldr glow wget
brew install --cask vivaldi obsidian wezterm visual-studio-code font-jetbrains-mono-nerd-font

echo "==> [4/6] zsh: Powerlevel10k + plugins (autosuggestions, syntax-highlighting, fzf-tab)"
if [ ! -d "$HOME/powerlevel10k" ]; then
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$HOME/powerlevel10k"
fi
ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.zsh-custom}"
mkdir -p "$ZSH_CUSTOM"
for repo in \
  "zsh-users/zsh-autosuggestions" \
  "zsh-users/zsh-syntax-highlighting" \
  "Aloxaf/fzf-tab"; do
  name="$(basename "$repo")"
  if [ ! -d "$ZSH_CUSTOM/$name" ]; then
    git clone --depth=1 "https://github.com/$repo" "$ZSH_CUSTOM/$name"
  fi
done

echo "==> [5/6] Python packages for the daily-note calendar sync"
if ! /opt/homebrew/bin/python3 -c "import googleapiclient, google_auth_oauthlib" 2>/dev/null; then
  /opt/homebrew/bin/python3 -m pip install --user --break-system-packages \
    google-api-python-client google-auth-oauthlib \
  || /opt/homebrew/bin/python3 -m pip install --user \
    google-api-python-client google-auth-oauthlib
fi

echo "==> [6/7] Notes vault"
if [ -d "$VAULT_DIR/.git" ]; then
  echo "    already cloned at $VAULT_DIR"
elif [ -n "$VAULT_URL" ]; then
  git clone "$VAULT_URL" "$VAULT_DIR"
else
  echo "    no URL given — clone manually later (README step 5)"
fi

echo "==> [7/7] Done."
echo "Next: bash $(dirname "$0")/copy-config.sh"
