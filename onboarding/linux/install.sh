#!/bin/bash
# Linux dependency installer — run once after setup.
# Usage: bash install.sh [git-clone-url-of-your-notes-vault]
#   e.g. bash install.sh git@github.com:you/notes.git
# Set VAULT_DIR to change where the vault is cloned (default: ~/notes).
set -euo pipefail

VAULT_URL="${1:-}"
VAULT_DIR="${VAULT_DIR:-$HOME/notes}"

echo "==> [1/5] Package manager + core tools"

if command -v pacman >/dev/null 2>&1; then
  echo "    distro: Arch (pacman)"
  sudo pacman -S --noconfirm --needed \
    git go nodejs python python-pip neovim ripgrep fzf jq bat eza zoxide lazygit \
    yq tldr glow wget zsh wezterm obsidian vivaldi code ttf-jetbrains-mono-nerd \
    >/dev/null
elif command -v apt >/dev/null 2>&1; then
  echo "    distro: Debian/Ubuntu (apt) — core CLI only; GUI apps via flatpak"
  sudo apt-get update -qq
  sudo apt-get install -y -qq git curl wget zsh neovim ripgrep fzf jq bat \
    eza zoxide lazygit yq tldr glow python3 python3-pip >/dev/null
  echo "    flatpak: flatpak install -y flathub org.wezfurlong.wezterm md.obsidian.Obsidian org.vivaldi.Vivaldi com.visualstudio.code"
  echo "    font: install a Nerd Font (e.g. fonts-jetbrains-mono-nerd) for p10k icons"
elif command -v dnf >/dev/null 2>&1; then
  echo "    distro: Fedora (dnf) — core CLI only; GUI apps via flatpak"
  sudo dnf install -y git curl wget zsh neovim ripgrep fzf jq bat eza zoxide \
    lazygit yq tldr glow python3 python3-pip >/dev/null
  echo "    flatpak: flatpak install -y flathub org.wezfurlong.wezterm md.obsidian.Obsidian org.vivaldi.Vivaldi com.visualstudio.code"
  echo "    font: install a Nerd Font (e.g. jetbrains-mono-nerd-fonts) for p10k icons"
else
  echo "    unsupported package manager — install the listed tools manually"
fi

echo "==> [2/5] zsh: Powerlevel10k + plugins (autosuggestions, syntax-highlighting, fzf-tab)"
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

echo "==> [3/5] Python packages for the daily-note calendar sync"
if ! python3 -c "import googleapiclient, google_auth_oauthlib" 2>/dev/null; then
  python3 -m pip install --user --break-system-packages \
    google-api-python-client google-auth-oauthlib \
  || python3 -m pip install --user \
    google-api-python-client google-auth-oauthlib \
  || sudo python3 -m pip install \
    google-api-python-client google-auth-oauthlib
fi

echo "==> [4/5] Default shell -> zsh"
if [ "$(basename "$SHELL")" != "zsh" ]; then
  chsh -s "$(command -v zsh)" || echo "    (manual) chsh -s $(command -v zsh)"
fi

echo "==> [5/5] Notes vault"
if [ -d "$VAULT_DIR/.git" ]; then
  echo "    already cloned at $VAULT_DIR"
elif [ -n "$VAULT_URL" ]; then
  git clone "$VAULT_URL" "$VAULT_DIR"
else
  echo "    no URL given — clone manually: git clone git@github.com:<you>/notes.git $VAULT_DIR"
fi

echo ""
echo "Done. Next: bash $(dirname "$0")/copy-config.sh"
echo "First zsh will launch the p10k configure wizard — pick Rainbow / Unicode / 1-line."
