export ZPLUG_HOME=/usr/local/opt/zplug
source $ZPLUG_HOME/init.zsh

export LANG=ja_JP.UTF-8
export EDITORP=vim
export XDG_CONFIG_HOME=$HOME/dotfiles
bindkey -e
# bindkey "jj" vi-cmd-mode

autoload -Uz compinit
compinit

zplug 'zsh-users/zsh-autosuggestions'

HISTFILE=~/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000
setopt hist_ignore_dups # 直前と同じコマンドをヒストリに追加しない
setopt hist_ignore_all_dups # 重複するコマンドは古い法を削除する
setopt share_history # 異なるウィンドウでコマンドヒストリを共有する
setopt hist_no_store # historyコマンドは履歴に登録しない
setopt hist_reduce_blanks # 余分な空白は詰めて記録

# '#' 以降をコメントとして扱う
setopt interactive_comments

# Ctrl+Dでzshを終了しない
setopt ignore_eof

# # ディレクトリ名だけでcdする
setopt auto_cd

autoload -Uz vcs_info
autoload -Uz add-zsh-hook

# prompt
autoload -Uz vcs_info
setopt prompt_subst
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr "%F{magenta}!"
zstyle ':vcs_info:git:*' unstagedstr "%F{yellow}+"
zstyle ':vcs_info:*' formats "%F{blue}%c%u[%b]%f"
zstyle ':vcs_info:*' actionformats '[%b|%a]'
precmd() { vcs_info }
PROMPT='%F{blue}%~%f %F{blue}>%f '
RPROMPT='${vcs_info_msg_0_}'

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
setopt print_eight_bit

# 補完候補を一覧で表示する
setopt auto_list

setopt auto_pushd
setopt pushd_ignore_dups
setopt hist_expand

alias vi='vim'
alias la='ls -la'
alias ll='exa -abghHliS'
alias lt='exa -lT'
alias rgf='rg --files -g'
alias co='checkout'
alias vim=nvim

function peco-select-history() {
    local tac
    if which tac > /dev/null; then
        tac="tac"
    else
        tac="tail -r"
    fi
    BUFFER=$(\history -n 1 | \
        eval $tac | \
        peco --query "$LBUFFER")
    CURSOR=$#BUFFER
    zle clear-screen
}
zle -N peco-select-history
bindkey '^r' peco-select-history

if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi


zplug load --verbose
