# Add Visual Studio Code (code)
export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"
export PATH="$PATH:~/.composer/vendor/bin"
export PATH="/usr/local/opt/mysql-client/bin:$PATH"

alias composer="/usr/local/bin/composer.phar"

# export RBENV_ROOT=/usr/local/var/rbenv
# if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

source /opt/homebrew/opt/autoenv/activate.sh
# export PATH="/usr/local/opt/openssl/bin:$PATH"
export PATH=$(brew --prefix openssl)/bin:$PATH
