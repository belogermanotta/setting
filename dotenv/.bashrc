export GOPATH=$HOME/go

#export GOROOT=$HOME/go
export GOBIN=$GOPATH/bin
export GOSRC=$GOPATH/src
export GOEATIGO=$GOSRC/github.com/eatigo/go
export JAVA_HOME=/Library/Java/JavaVirtualMachines/adoptopenjdk-11.jdk/Contents/Home
export PATH="$HOME/.jenv/bin:$PATH"
eval "$(jenv init -)"
export PATH=$PATH:$GOPATH/bin
export PATH=$PATH:~/.composer/vendor/bin
export PATH="$PATH:/Users/werlion/code/development/flutter/bin"
export PATH=$PATH:/usr/local/bin/python3
export PATH=$PATH:~/envscript
export PATH=$PATH:~/apache-maven-3.6.3/bin
export PATH="/usr/local/opt/gnu-sed/libexec/gnubin:$PATH"
export WORK=/Users/werlion/code/WORK
export ANDROID_HOME=/Users/werlion/Library/Android/sdk
export ANDROID_SDK_ROOT=/Users/werlion/Library/Android/sdk
export ANDROID_AVD_HOME=/Users/werlion/.android/avd
source ~/.autoenv/activate.sh



alias idea='idea $(pwd)'

alias j8="export JAVA_HOME=`/usr/libexec/java_home -v 1.8`; java -version"
alias j11="export JAVA_HOME=`/usr/libexec/java_home -v 11`; java -version"
alias jc15="export JAVA_HOME=/Library/Java/JavaVirtualMachines/amazon-corretto-15.jdk/Contents/Home; java -version"
[ -z "$ZSH_NAME" ] && [ -f ~/.fzf.bash ] && source ~/.fzf.bash
