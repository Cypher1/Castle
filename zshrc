setup() {
    NAME=$1; ENTRY=$2; CMD=$3
    [[ -e "$ENTRY" ]] && return
    echo "$NAME is missing"
    [[ -z "$CMD" ]] && return
    sh -c "$CMD" # TODO ask for confirmation or exit
}

dotfile() {
    NAME=$1; ENTRY="${HOME}/.${NAME}"
    setup "${NAME}" "${ENTRY}" "ln -s ${HOME}/.config/${NAME} ${ENTRY}"
}

load() {
    NAME=$1; ENTRY=$2; CMD=$3
    setup "$NAME" "$ENTRY" "$CMD"
    [[ -e "${ENTRY}" ]] && source "$ENTRY"
}

github() {
    USER=$1; REPO=$2; DIR="${3:-$HOME/$REPO}"
    setup ${REPO} ${DIR} "git clone git@github.com:${USER}/${REPO}.git $DIR"
    # TODO: if existing warn if there are updates
}

path() {
  echo "$PATH" | grep -q "$1" || export PATH="${PATH}:$1"
}

pkg_man() {
  [[ -x $(which pkg) ]] && echo "pkg install -y" && return
  [[ -x $(which apt) ]] && echo "sudo apt install -y -f" && return
  [[ -x $(which pacman) ]] && echo "sudo pacman -Syyu" && return
  echo "No package manager found" > /dev/stderr && exit 1
}

program() {
  PROG=$1; PKG=${2:-$1}
  setup $PKG "$(which $PROG)" "$PKG_MAN $PKG"
}

plugins=(
    last-working-dir
    rust
    sudo
    z
    zsh-autosuggestions
    zsh-completions
  )

# LOAD EXTERNALS
export HOME="$(cd;pwd)"
export ZSH="$HOME/.ohmyzsh"
PKG_MAN=$(pkg_man)
program zsh
program nvim neovim
program git
program python3
dotfile gitconfig
dotfile pylintrc
dotfile zshrc
github google greasy "${HOME}/.config/greasy"
github romkatv powerlevel10k "${HOME}/.powerlevel10k"
github ohmyzsh ohmyzsh "${HOME}/.ohmyzsh"
github zsh-users zsh-autosuggestions "${ZSH}/custom/plugins/zsh-autosuggestions"
github zsh-users zsh-completions "${ZSH}/custom/plugins/zsh-completions"
github Cypher1 notes
github Cypher1 tako
github Cypher1 no_debug
github Cypher1 cypher1.github.io
github Cypher1 qmk_firmware
github project-oak arcsjs-provable

# Install plug
PLUG="${HOME}/.local/share/nvim/site/autoload/plug.vim"
PLUG_SRC="https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
PLUG_CMD="curl -fLo $PLUG --create-dirs $PLUG_SRC && \
    python3 -m pip install neovim && \
    nvim +PlugInstall"
setup plug $PLUG $PLUG_CMD
load p10k "${HOME}/.config/p10k.zsh" "p10k configure && mkdir -p ${HOME}/.config && mv ${HOME}/.p10k.zsh ${HOME}/.config/"

load p10k_cache "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"

load powerlevel10k "${HOME}/.powerlevel10k/powerlevel10k.zsh-theme"
load ohmyzsh "${ZSH}/oh-my-zsh.sh"
load greasy "${HOME}/.config/greasy/greasy.zsh"

path "/usr/local/bin"
path "/opt/local/bin"
path "${HOME}/.cargo/bin"
path "${HOME}/.local/bin/"
path "${HOME}/.config/bin"

unique() {
  cat -n | sort --key=2.1 -b -u | sort -n | cut -c8-
}
alias matches="grep -o"
join() {
  tr '\n' $1 | sed "s/$1$//"
}

PATH="$(echo $PATH | matches '[^:]*' | unique | join ':')"
autoload -U +X bashcompinit && bashcompinit

# SET OPTIONS
setopt INC_APPEND_HISTORY
setopt HIST_IGNORE_DUPS
setopt no_bang_hist # turn off history expansion using !
bindkey -v
bindkey "^R" history-incremental-search-backward
export GIT_DISCOVERY_ACROSS_FILESYSTEM=1
export KEYTIMEOUT=1

# HISTORY
export HISTSIZE=1000000                # set history size
export SAVEHIST=1000000                # save history after logout
export HISTFILE=${HOME}/.config/zsh_history  # history file
export HISTIGNORE="^(fg|bg|ls|s|p|q)$"
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=yellow"

# EXPORTS
export TERM="xterm-256color"
export EDITOR="$(which nvim || which vim)"
export MANPAGER="/bin/sh -c \"col -b | $EDITOR -c 'set ft=man ts=8 nomod nolist nonu noma' -\""
export VISUAL="$EDITOR"
SCCACHE="$(which sccache)"
[[ -e $SCCACHE ]] && export RUSTC_WRAPPER="$SCCACHE"

# ALIASES
alias .="clear;ls"
alias cp="cp -r"
alias grep="egrep"
alias vim="$EDITOR "
alias g++="g++ -std=c++14 -Wall -Werror"
alias ghc="ghc -Wall"
alias zrc="$EDITOR ${HOME}/.config/zshrc"
alias ghct="ghc -Wall -O2 -threaded -rtsopts -with-rtsopts='-N4'"
alias q="exit"
alias ma0="map"
alias got='git'
alias reauthor="git commit --amend --no-edit --author='J Pratt <jp10010101010000@gmail.com>'"
w() { cargo watch -x "test $@" }
alias nt="cargo nextest run"
alias ti="TAKO_LOG=\"info\" cargo test"
alias td="TAKO_LOG=\"debug\" cargo test"
alias tt="TAKO_LOG=\"trace\" cargo test"
alias c="cargo check --all-targets"
