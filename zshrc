export HOME="$(cd;pwd)"
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

plugins=(
    last-working-dir
    rust
    sudo
    z
    zsh-autosuggestions
    zsh-completions
  )

# SET OPTIONS

# append into history file
setopt INC_APPEND_HISTORY
# save only one command if 2 common are same and consistent
setopt HIST_IGNORE_DUPS
# turn off history expansion using !
setopt no_bang_hist

bindkey -v
bindkey "^R" history-incremental-search-backward

# EXPORTS

export ZSH="$HOME/.ohmyzsh"
export TERM="xterm-256color"
export EDITOR="$(which nvim || which vim)"
export MANPAGER="/bin/sh -c \"col -b | $EDITOR -c 'set ft=man ts=8 nomod nolist nonu noma' -\""
export VISUAL="$EDITOR"
export RUSTC_WRAPPER="$(which sccache)"

# HISTORY
export HISTSIZE=1000000                # set history size
export SAVEHIST=1000000                # save history after logout
export HISTFILE=${HOME}/.config/zsh_history  # history file
export HISTIGNORE="^(fg|bg|ls|s|p|q)$"
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=yellow"
export GIT_DISCOVERY_ACROSS_FILESYSTEM=1
export KEYTIMEOUT=1
# OVERRIDES
export PATH="${PATH}:/usr/local/bin"
export PATH="${PATH}:/opt/local/bin"
export PATH="${PATH}:${HOME}/.cargo/bin"
export PATH="${PATH}:${HOME}/.local/bin/"
export PATH="${PATH}:${HOME}/.config/bin"

# ALIASES
alias cp="cp -r"
alias grep="egrep"
alias vim="$EDITOR "
alias zrc="$EDITOR ${HOME}/.config/zshrc"
alias ghct="ghc -Wall -O2 -threaded -rtsopts -with-rtsopts='-N4'"
alias ghc="ghc -Wall"
alias g++="g++ -std=c++14 -Wall -Werror"
alias q="exit"

# GIT COMMANDS
alias ma0="map"
alias got='git'

alias reauthor="git commit --amend --no-edit --author='J Pratt <jp10010101010000@gmail.com>'"

function w() {
    cargo watch -x "test $@"
}
alias nt="cargo nextest run"
alias ti="TAKO_LOG=\"info\" cargo test"
alias td="TAKO_LOG=\"debug\" cargo test"
alias tt="TAKO_LOG=\"trace\" cargo test"
alias c="cargo check --all-targets"

# LOAD EXTERNALS
function setup() {
    NAME=$1
    ENTRY=$2
    CMD=$3
    if [[ ! -f "$ENTRY" ]]; then
        echo "$NAME is missing"
        # TODO ask for confirmation or exit
        if [[ ! -z "$CMD" ]]; then
            $(sh -c "$CMD")
        fi
    fi
}

function load() {
    NAME=$1
    ENTRY=$2
    CMD=$3
    setup "$NAME" "$ENTRY" "$CMD" || echo "could not setup $NAME"
    source "$ENTRY" || echo "$NAME is failed to load"
}

function github_pkg() {
    USER=$1
    REPO=$2
    DIR=$3
    echo "git clone git@github.com:${USER}/${REPO}.git $DIR"
}

function github() {
    USER=$1
    REPO=$2
    github_pkg $USER $REPO "${HOME}/.${REPO}"
}

function link() {
    NAME=$1
    echo "ln -s ${HOME}/.config/${NAME} ~/.${NAME}"
}

setup gitconfig ~/.gitconfig "$(link gitconfig)"
setup pylintrc ~/.pylintrc "$(link pylintrc)"
load powerlevel10k "${HOME}/.powerlevel10k/powerlevel10k.zsh-theme" "$(github romkatv powerlevel10k)"
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
load omz $ZSH/oh-my-zsh.sh "$(github ohmyzsh ohmyzsh)"
load greasy ${HOME}/.config/greasy/greasy.zsh "$(github google greasy)"
load p10k ~/.p10k.zsh "$(link p10k.zsh)"

autoload -U +X bashcompinit && bashcompinit
