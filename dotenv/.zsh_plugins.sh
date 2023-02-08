# TODO: remove, legacy antibody. antidote is the new  one
# source /Users/werlion/Library/Caches/antibody/https-COLON--SLASH--SLASH-github.com-SLASH-zsh-users-SLASH-zsh-autosuggestions/zsh-autosuggestions.plugin.zsh
# fpath+=( /Users/werlion/Library/Caches/antibody/https-COLON--SLASH--SLASH-github.com-SLASH-zsh-users-SLASH-zsh-autosuggestions )
# source /Users/werlion/Library/Caches/antibody/https-COLON--SLASH--SLASH-github.com-SLASH-zsh-users-SLASH-zsh-completions/zsh-completions.plugin.zsh
# fpath+=( /Users/werlion/Library/Caches/antibody/https-COLON--SLASH--SLASH-github.com-SLASH-zsh-users-SLASH-zsh-completions )
# source /Users/werlion/Library/Caches/antibody/https-COLON--SLASH--SLASH-github.com-SLASH-zsh-users-SLASH-zsh-history-substring-search/zsh-history-substring-search.plugin.zsh
# fpath+=( /Users/werlion/Library/Caches/antibody/https-COLON--SLASH--SLASH-github.com-SLASH-zsh-users-SLASH-zsh-history-substring-search )
# source /Users/werlion/Library/Caches/antibody/https-COLON--SLASH--SLASH-github.com-SLASH-zsh-users-SLASH-zsh-syntax-highlighting/zsh-syntax-highlighting.plugin.zsh
# fpath+=( /Users/werlion/Library/Caches/antibody/https-COLON--SLASH--SLASH-github.com-SLASH-zsh-users-SLASH-zsh-syntax-highlighting )

#######################################################
# This speeds up pasting w/ autosuggest
# https://github.com/zsh-users/zsh-autosuggestions/issues/238
pasteinit() {
  OLD_SELF_INSERT=${${(s.:.)widgets[self-insert]}[2,3]}
  zle -N self-insert url-quote-magic # I wonder if you'd need `.url-quote-magic`?
}

pastefinish() {
  zle -N self-insert $OLD_SELF_INSERT
}
zstyle :bracketed-paste-magic paste-init pasteinit
zstyle :bracketed-paste-magic paste-finish pastefinish
########################################################
