#!/bin/bash

# bash実行がプロンプトによるものでなかったらrcファイルを実行しない
case $- in
  *i*)   ;;
  *)     return ;;
esac

# Aliasの定義ファイルとして.bash_aliasesが存在するならロード
[ -f "$HOME/.bash_aliases" ]&&source "$HOME/.bash_aliases"

# 重複した実行履歴の削除
HISTCONTROL=ignoreboth

# 履歴ファイルへの逐次追記(上書きの禁止)
shopt -s histappend

# bash実行コマンドの履歴保存上限
HISTSIZE=1000
HISTFILESIZE=2000

# ウインドウサイズで行列を動的に更新
shopt -s checkwinsize

# 全ファイルとゼロ以上のディレクトリとサブディレクトリにマッチする「**」の有効化
#shopt -s globstar

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

if [ -n "${force_color_prompt}" ]; then
  if   [ -x /usr/bin/tput ]; then
    tput setaf 1 >&/dev/null
    color_prompt=yes
  else
    color_prompt=
  fi
fi
unset color_prompt force_color_prompt

# xtermを使用しているならプロンプト名にuser@host:dirを指定
case "$TERM" in
  xterm* | rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
  *) ;;

esac

# lsの着色とユーザ定義のalias有効
if [ -x /usr/bin/dircolors ]; then
  if [[ -r ~/.dircolors ]]; then
    eval "$(dircolors -b ~/.dircolors)"
  else
    eval "$(dircolors -b)"
  fi
fi

# bash入力補完機能の設定読み込みの有効
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# enable ble
# [[ $- == *i* ]] && source $HOME/prog/ble-0.3.2/ble.sh --noattach
# ((_ble_bash)) && ble-attach
echo-sd "Bashrc loaded."


[ "$(ps -u|grep byobu|wc -l)" = 1 ] && byobu
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"
