#!/bin/bash

# プロンプトでないなら終了！ｗ
case $- in
  *i*)   ;;
  *)     return ;;
esac

#Alias定義ファイルのロード
[ -f "$HOME/.zsh_aliases" ]&&source "$HOME/.zsh_aliases"

#プロンプトの変更
#PS1="%n@%m %1~ %# "
autoload colors;colors
PS1="[[[%{${fg[red]}%}%n%{${reset_color}%}@%{${fg[blue]}%}%m%{${reset_color}%}:%{${fg[white]}%}(%*%)%{${reset_color}%}:%{${fg[cyan]}%}%c%{${reset_color}%}]]]->>> "

#補完の有効化
autoload -U compinit
compinit -u
zstyle ':completion:*' menu select

#オプション有効化
setopt correct
setopt autocd
setopt nolistbeep
setopt aliasfuncdef
setopt appendhistory
setopt histignoredups
setopt cshjunkiequotes
setopt sharehistory
setopt extendedglob
setopt incappendhistory

# bash実行コマンドの履歴保存上限
HISTFILE=$HOME/.zsh_history
HISTSIZE=1000
SAVEHIST=100000
HISTFILESIZE=2000
HISTCONTROL=ignoreboth
bindkey '^[[A' up-line-or-search
bindkey '^[[B' down-line-or-search

# lessへのバイナリファイル入力有効化
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# 現在のchroot識別変数debian_chrootの設定(プロンプトでのみ)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
  debian_chroot=$(  cat /etc/debian_chroot)
fi

# prompt着色を有効化
case "$TERM" in
  xterm-color | *-256color) color_prompt=yes ;;
esac

#force_color_prompt=yes # コマンドの設定によらずいつも色を表示
if [ -n "${force_color_prompt}" ]; then
  if   [ -x /usr/bin/tput ]; then
    tput     setaf 1 >&/dev/null
    # 色のサポート (ISO/IEC-6429, Ecma-48準拠)
    # (殆どのプロンプトは対応済みで、
    # そうでなければsetafではなくsetf使用しがち.)
    color_prompt=yes
  fi
fi


#引数をlsライクに着色
zstyle ':completion:*:default' list-colors "${(s.:.)LS_COLORS}"
echo-sd "zshrc_finished."

# 天気表示
. ~/.weatherCast.sh
