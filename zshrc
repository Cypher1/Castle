export HOME="$(cd;pwd)"
# Enable Powerlevel10k instant prompt. Should stay close to the top of ${HOME}/.zshrc.
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
    [[ -d "$ENTRY" ]] && return
    [[ -f "$ENTRY" ]] && return
    echo "$NAME is missing"
    # TODO ask for confirmation or exit
    [[ -z "$CMD" ]] && return
    sh -c "$CMD"
}

function dotfile() {
    NAME=$1
    ENTRY="${HOME}/.${NAME}"
    setup "${NAME}" "${ENTRY}" "ln -s ${HOME}/.config/${NAME} ${ENTRY}"
}

function load() {
    NAME=$1
    ENTRY=$2
    CMD=$3
    setup "$NAME" "$ENTRY" "$CMD" || echo "could not setup $NAME"
    source "$ENTRY" || echo "$NAME failed to load"
}

function github() {
    USER=$1
    REPO=$2
    DIR="${3:-$HOME/$REPO}"
    setup ${REPO} ${DIR} "git clone git@github.com:${USER}/${REPO}.git $DIR"
    # TODO: if existing warn if there are updates
}

function pkg_man() {
  if [[ -x $(which pkg) ]]; then
    echo "pkg install -y"
    return
  fi
  if [[ -x $(which apt) ]]; then
    echo "sudo apt install -y -f"
    return
  fi
  if [[ -x $(which pacman) ]]; then
    echo "sudo pacman -Syyu"
    return
  fi
  echo "No package manager found" > /dev/stderr
  exit 1
}

function program() {
  PROG=$1
  PKG=${2:-$1}
  setup $PKG "$(which $PROG)" "$PKG_MAN $PKG"
}

function arrive() {
    PKG_MAN=$(pkg_man)
    program zsh
    program nvim neovim
    program git
    program python3
    dotfile gitconfig
    dotfile pylintrc
    github google greasy "${HOME}/.config/greasy"
    github romkatv powerlevel10k "${HOME}/.powerlevel10k"
    github ohmyzsh ohmyzsh "${HOME}/.ohmyzsh"
    github zsh-users zsh-autosuggestions "${ZSH}/custom/plugins/zsh-autosuggestions"
    github zsh-users zsh-completions "${ZSH}/custom/plugins/zsh-completions"
    github Cypher1 notes
    github Cypher1 tako
    github Cypher1 no_debug
    github Cypher1 cypher1.github.io
    github project-oak arcsjs-provable

    # Install plug
    PLUG="${HOME}/.local/share/nvim/site/autoload/plug.vim"
    PLUG_SRC="https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
    PLUG_CMD="curl -fLo $PLUG --create-dirs $PLUG_SRC && \
        python3 -m pip install neovim && \
        nvim +PlugInstall"
    setup plug $PLUG $PLUG_CMD
}

load powerlevel10k "${HOME}/.powerlevel10k/powerlevel10k.zsh-theme"
load ohmyzsh "${ZSH}/oh-my-zsh.sh"
load greasy "${HOME}/.config/greasy/greasy.zsh"
load p10k "${HOME}/.config/p10k.zsh" "p10k configure && mkdir -p ${HOME}/.config && mv ${HOME}/.p10k.zsh ${HOME}/.config/"

autoload -U +X bashcompinit && bashcompinit
