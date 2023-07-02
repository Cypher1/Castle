#!/usr/bin/zsh
export HOME="$(cd;pwd)"
export ZSH="${HOME}/.ohmyzsh"
export LLVM_SYS_150_PREFIX="${HOME}/llvm-project/build"

# Run the auto-update checker (with colors):
function update-host() {
}
source "${HOME}/.config/colors.sh"
source "${HOME}/.config/auto-update.sh"
source "${HOME}/.config/arrive.zsh"
export NVM_LAZY_LOAD=true

plugins=(
  command-not-found
  last-working-dir
  rust
  sudo
  z
  zsh-autosuggestions
  zsh-completions
  zsh-nvm
)

# LOAD EXTERNALS
program zsh
program fzf
program nvim neovim
program git
program python3
program cargo
# program kitty
dotfile gitconfig
dotfile pylintrc
dotfile zshrc
dotfile fzf.zsh
github Cypher1 greasy "${HOME}/.config/greasy"
github romkatv powerlevel10k "${HOME}/.powerlevel10k"
github ohmyzsh ohmyzsh "${HOME}/.ohmyzsh"
github zsh-users zsh-autosuggestions "${ZSH}/custom/plugins/zsh-autosuggestions"
github zsh-users zsh-completions "${ZSH}/custom/plugins/zsh-completions"
github lukechilds zsh-nvm "${HOME}/.ohmyzsh/custom/plugins/zsh-nvm"
github lukechilds zsh-better-npm-completion "${ZSH}/custom/plugins/zsh-better-npm-completion"
github Cypher1 notes "${HOME}/notes"
github Cypher1 tako "${HOME}/tako"
github Cypher1 no_debug "${HOME}/no_debug"
github Cypher1 cypher1.github.io "${HOME}/cypher1.github.io"
github Cypher1 qmk_firmware "${HOME}/qmk_firmware"
github skfltech skfl "${HOME}/skfltech/skfl"

# Install plug
PLUG="${HOME}/.local/share/nvim/site/autoload/plug.vim"
PLUG_SRC="https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
PLUG_CMD="curl -fLo $PLUG --create-dirs $PLUG_SRC && \
    python3 -m pip install neovim && \
    nvim +PlugInstall"
setup plug $PLUG $PLUG_CMD
load p10k_config "${HOME}/.config/p10k.zsh" "p10k configure && mkdir -p ${HOME}/.config && mv ${HOME}/.p10k.zsh ${HOME}/.config/"

load p10k_cache "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"

load powerlevel10k "${HOME}/.powerlevel10k/powerlevel10k.zsh-theme"
load ohmyzsh "${ZSH}/oh-my-zsh.sh"
load greasy "${HOME}/.config/greasy/greasy.zsh"
load fzf "${HOME}/.config/fzf.zsh"
load zsh-better-npm-completion "${ZSH}/custom/plugins/zsh-better-npm-completion/zsh-better-npm-completion.plugin.zsh"

path "/usr/lib/ccache" # Ensure that ccache versions are used over other compilers
path "/usr/local/bin"
path "/opt/local/bin"
path "${HOME}/depot_tools"
path "${HOME}/.cargo/bin"
path "${HOME}/.local/bin/"
path "${HOME}/.config/bin"
path "${HOME}/.npm-global/bin"
path "${HOME}/zig"

unique() {
  cat -n | sort --key=2.1 -b -u | sort -n | cut -c8-
}
alias matches="grep -o"
join() {
  tr '\n' $1 | sed "s/$1$//"
}

PATH="$(echo $PATH | matches '[^:]*' | unique | join ':')"
autoload -U +X bashcompinit && bashcompinit

compdef _P P

# SET OPTIONS
setopt INC_APPEND_HISTORY
setopt HIST_IGNORE_DUPS
setopt no_bang_hist # turn off history expansion using !
# bindkey -v
bindkey "^R" history-incremental-search-backward
bindkey -s "^L" "exec zsh\n"
function _ggrep {
  LINE="$BUFFER"
  zle push-input
  BUFFER="vim +:GGrep $LINE"
  zle accept-line
}
zle -N _ggrep
bindkey '^F' _ggrep
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
#alias -s {csv,sh,zsh,log,cc,cpp,h,c,kt,tk,vim,rs}="$EDITOR"
alias cl="less -r -f +G +g .c.log"
function c() {
  cargo check --all-targets --color always $@ 2>&1 | tee .c.log | less -r +G +g
}
alias tl="less -r -f +G +g .t.log"
function t() {
  cargo test --color always $@ 2>&1 | tee .t.log | less -r +G +g
}

alias "a."="a ."
alias cp="cp -r"
alias g++="g++ -std=c++14 -Wall -Werror"
alias ghc="ghc -Wall"
alias ghct="ghc -Wall -O2 -threaded -rtsopts -with-rtsopts='-N4'"
alias got='git'
alias grep="grep -E"
alias ma0="map"
alias nt="cargo nextest run"
alias q="exit"
alias reauthor="git commit --amend --no-edit --author='J Pratt <jp10010101010000@gmail.com>'"
alias td="TAKO_LOG=\"debug\" cargo test"
alias ti="TAKO_LOG=\"info\" cargo test"
alias tt="TAKO_LOG=\"trace\" cargo test"
alias open="xdg-open"
alias v="$EDITOR "
alias vi="$EDITOR "
alias vim="$EDITOR "
alias vi="vim"
alias v="vim"
alias zrc="$EDITOR ${HOME}/.config/zshrc"
alias vrc="$EDITOR ${HOME}/.config/nvim/init.vim"
alias icat="kitty +kitten icat"
w() { cargo watch -x "test $@" }
function mk() {
  mkdir -p $1
  cd $1
}

export CARGO_TARGET_DIR="${HOME}/.cargo/target"
export CARGO_INCREMENTAL=0
