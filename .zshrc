#!/bin/bash

# echo-sd
which echo-sd > /dev/null || {
  wget -nv https://raw.githubusercontent.com/fumiyas/home-commands/master/echo-sd
  sudo install -m 0755 echo-sd /usr/local/bin/echo-sd
  rm echo-sd
}

# プロンプトでないなら終了！ｗ
case $- in
  *i*)   ;;
  *)     return ;;
esac

# case $TERM in
#     linux) LANG=C ;;
#     *)     LANG=ja_JP.UTF-8;;
# esac

#Alias定義ファイルのロード
[ -f "$HOME/.zsh_aliases" ]&&source "$HOME/.zsh_aliases"

#プロンプトの変更
#PS1="%n@%m %1~ %# "
autoload colors;colors
PS1="[[[%{${fg[red]}%}%n%{${reset_color}%}@%{${fg[blue]}%}%m%{${reset_color}%}:%{${fg[white]}%}(%*%)%{${reset_color}%}:%{${fg[cyan]}%}%c%{${reset_color}%}]]]
->>> "

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
# setopt cshjunkiequotes
setopt sharehistory
setopt extendedglob
setopt incappendhistory
setopt interactivecomments
setopt prompt_subst


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

# git ブランチ名を色付きで表示させるメソッド
rprompt-git-current-branch() {
  local branch_name st branch_status
  if [ ! -e  ".git" ]; then
    return
  fi
  branch_name="$(git rev-parse --abbrev-ref HEAD 2> /dev/null)"
  st="$(git status 2> /dev/null)"
  if [[ -n "$(echo \"${st}\" | grep '^nothing to')" ]]; then
    branch_status="%F{green}"
  elif [[ -n "$(echo \"${st}\" | grep '^Untracked files')" ]]; then
    branch_status="%F{red}?"
  elif [[ -n "$(echo \"${st}\" | grep '^Changes not staged for commit')" ]]; then
    branch_status="%F{red}+"
  elif [[ -n "$(echo \"${st}\" | grep '^Changes to be committed')" ]]; then
    branch_status="%F{yellow}!"
  elif [[ -n "$(echo \"${st}\" | grep '^rebase in progress')" ]]; then
    echo "%F{red}!(no branch)"
    return
  else
    branch_status="%F{blue}"
  fi
  echo "${branch_status}[$branch_name]%f"
}
RPROMPT='$(rprompt-git-current-branch)'


#引数をlsライクに着色
zstyle ':completion:*:default' list-colors "${(s.:.)LS_COLORS}"
echo-sd "zshrc_finished."

# 天気表示
. ~/.weatherCast.sh
