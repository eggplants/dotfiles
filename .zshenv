#!/bin/bash

export COWPATH="$HOME/usr/share/cows"
export MANPATH="$MANPATH:$HOME/.linuxbrew/share/man"
export INFOPATH="$INFOPATH:$HOME/.linuxbrew/share/info"
export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:$HOME/.linuxbrew/lib"

export PATH="$PATH:$HOME/go/bin"
export PATH="$PATH:/usr/local/go/bin"
export PATH="$PATH:$GOPATH/bin"
export PATH="$PATH:$HOME/local/bin"
export PATH="$PATH:$HOME/usr/bin"
export PATH="$PATH:$HOME/usr/pip/bin"
export PATH="$PATH:/home/linuxbrew/.linuxbrew/bin"
export PATH="$PATH:$HOME/.local/bin"
export PATH="$PATH:$HOME/.rbenv/bin"

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PATH:$HOME/.pyenv/shims"
export PATH="$PATH:$PYENV_ROOT/bin"

export JAVA_HOME="/usr/lib/jvm/default-java"
export PATH="$PATH:$JAVA_HOME/bin"
export PATH="$PATH:$HOME/.nimble/bin"
export CLASSPATH=".:$JAVA_HOME/jre/lib:$JAVA_HOME/lib:$JAVA_HOME/lib/tools.jar"
export M2_HOME="/opt/maven"
export MAVEN_HOME="/opt/maven"
export PATH="$PATH:M2_HOME/bin"

export DENO_INSTALL="$HOME/.deno"
export PATH="$PATH:$DENO_INSTALL/bin"

export nano_highlight_path="$HOME/.nano"

export VTE_CJK_WIDTH=1
export LSCOLORS=gxfxcxdxbxegedabagacag
export LS_COLORS='di=36;40:ln=35;40:so=32;40:pi=33;40:ex=31;40:bd=34;46:cd=34;43:su=30;41:sg=30;46:tw=30;42:ow=30;46'
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

export GPG_TTY="$(tty)"

export WINIT_UNIX_BACKEND=x11

# eval "$(plenv init -)"
eval "$(pyenv init --path)"
eval "$(rbenv init -)"

. "$HOME/.cargo/env"

_byobu_sourced=1 . /usr/bin/byobu-launch 2>/dev/null || true
