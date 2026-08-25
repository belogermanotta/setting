# --- History ---
HISTSIZE=10000
SAVEHIST=10000
setopt HIST_IGNORE_ALL_DUPS SHARE_HISTORY

# --- Go ---
export GOPATH="$HOME/go"
export PATH="$GOPATH/bin:$PATH"

# --- zoxide (smart cd: z proj, zi = interactive) ---
eval "$(zoxide init zsh)"

# --- Completions + fzf-tab (must be before syntax-highlighting) ---
autoload -Uz compinit && compinit
[ -d "$HOME/.zsh-custom/fzf-tab" ] && source "$HOME/.zsh-custom/fzf-tab/fzf-tab.plugin.zsh"

# --- fzf ---
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND='rg --files --hidden --glob "!.git"'

# --- zsh plugins (autosuggestions, then syntax-highlighting LAST) ---
[ -d "$HOME/.zsh-custom/zsh-autosuggestions" ] && \
  source "$HOME/.zsh-custom/zsh-autosuggestions/zsh-autosuggestions.zsh"
[ -d "$HOME/.zsh-custom/zsh-syntax-highlighting" ] && \
  source "$HOME/.zsh-custom/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

# --- Powerlevel10k ---
if [[ -r "$HOME/powerlevel10k/powerlevel10k.zsh-theme" ]]; then
  source "$HOME/powerlevel10k/powerlevel10k.zsh-theme"
  [[ -f "$HOME/.p10k.zsh" ]] && source "$HOME/.p10k.zsh"
fi

# --- Aliases ---
alias ll='eza -la --icons'
alias ls='eza --icons'
alias tree='eza --tree --icons'
alias gs='git status -sb'
alias gp='git pull --rebase --autostash'
alias gcm='git commit -m'
alias v='nvim'
alias lg='lazygit'
alias ..='cd ..'
