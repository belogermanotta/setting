export GOPATH=$HOME/go

#export GOROOT=$HOME/go
export GOBIN=$GOPATH/bin
export GOSRC=$GOPATH/src
export JAVA_HOME=/Library/Java/JavaVirtualMachines/adoptopenjdk-11.jdk/Contents/Home
export PKG_CONFIG_PATH=/opt/homebrew/lib/pkgconfig
export PATH="$HOME/.jenv/bin:$PATH"
eval "$(jenv init -)"
export PATH=$PATH:$GOPATH/bin
export PATH=/opt/homebrew/bin:$PATH
export PATH=$PATH:~/.composer/vendor/bin
export PATH=$PATH:/usr/local/bin/python3
export PATH=$PATH:~/envscript
export PATH=$PATH:~/.local/bin
export PATH=$PATH:~/apache-maven-3.6.3/bin
export PATH=$PATH:~/miniconda3/bin
export PATH="/usr/local/opt/gnu-sed/libexec/gnubin:$PATH"
export WORK=/Users/$USER/WORK

export PB_REL="https://github.com/protocolbuffers/protobuf/releases"

export CLOUDSDK_PYTHON_SITEPACKAGES=1


# Frontend
eval "$(direnv hook zsh)"
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm


# WORK alias
alias run-services-linter='(cd $WORK/services && ./build/build-backend.sh -noEnv -apps=none -quick -linters=all)'


alias idea='idea $(pwd)'

alias j8="export JAVA_HOME=`/usr/libexec/java_home -v 1.8`; java -version"
alias j11="export JAVA_HOME=`/usr/libexec/java_home -v 11`; java -version"
alias jc15="export JAVA_HOME=/Library/Java/JavaVirtualMachines/amazon-corretto-15.jdk/Contents/Home; java -version"
[ -z "$ZSH_NAME" ] && [ -f ~/.fzf.bash ] && source ~/.fzf.bash


# Create x86 conda environment
create_x86_conda_environment () {
# example usage: create_x86_conda_environment myenv_x86 python=3.9
 CONDA_SUBDIR=osx-64 conda create -n $@
 conda activate $1
}
# Create ARM conda environment
create_ARM_conda_environment () {
# example usage: create_ARM_conda_environment myenv_x86 python=3.9
 CONDA_SUBDIR=osx-arm64 conda create -n $@
 conda activate $1
}
