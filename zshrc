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

path "/usr/lib/ccache" # Ensure that ccache versions are used over other compilers
path "/usr/local/bin"
path "/opt/local/bin"
path "/opt/fx_cast/"
path "${HOME}/depot_tools"
path "${HOME}/.cargo/bin"
path "${HOME}/.local/bin/"
path "${HOME}/.config/bin"
path "${HOME}/.npm-global/bin"
path "${HOME}/zig"

# LOAD EXTERNALS
program zsh
program fzf
program nvim neovim
program git
program python3
program rustup
# program kitty
# rustup cargo # get from rustup
# rustup rustc # get from rustup
dotfile gitconfig
dotfile pylintrc
dotfile zshrc
dotfile fzf.zsh
github wbthomason packer.nvim "${HOME}/.local/share/nvim/site/pack/packer/start/packer.nvim"
github Cypher1 nvim_config "${HOME}/.config/nvim"
github Cypher1 greasy "${HOME}/.config/greasy"
github romkatv powerlevel10k "${HOME}/.powerlevel10k"
github ohmyzsh ohmyzsh "${HOME}/.ohmyzsh"
github zsh-users zsh-autosuggestions "${ZSH}/custom/plugins/zsh-autosuggestions"
github zsh-users zsh-completions "${ZSH}/custom/plugins/zsh-completions"
github lukechilds zsh-nvm "${HOME}/.ohmyzsh/custom/plugins/zsh-nvm"
github lukechilds zsh-better-npm-completion "${ZSH}/custom/plugins/zsh-better-npm-completion"
github Cypher1 tako "${HOME}/tako"
github skfltech skfl "${HOME}/skfl"

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
load mdbook "${HOME}/.config/mdbook.zsh"
load zsh-better-npm-completion "${ZSH}/custom/plugins/zsh-better-npm-completion/zsh-better-npm-completion.plugin.zsh"
load ghcup "${HOME}/.ghcup/env"

# Add ninja completions
fpath=("${HOME}/.config/ninja.zsh" $fpath)

unique() {
  cat -n | sort --key=2.1 -b -u | sort -n | cut -c8-
}
join() {
  tr '\n' $1 | sed "s/$1$//"
}

PATH="$(echo $PATH | grep -o '[^:]*' | unique | join ':')"
export PATH="/usr/lib/ccache/bin:$PATH"
autoload -U +X bashcompinit && bashcompinit

compdef _P P

# SET OPTIONS
setopt INC_APPEND_HISTORY
setopt HIST_IGNORE_DUPS
setopt no_bang_hist # turn off history expansion using !
# bindkey -v
# bindkey "^R" history-incremental-search-backward
bindkey -s "^L" "exec zsh\n"
function _ggrep {
  LINE="$BUFFER"
  zle push-input
  BUFFER="vim +:GGrep $LINE"
  zle accept-line
}
zle -N _ggrep
zstyle ':autocomplete:*' default-context history-incremental-search-backward
zstyle ':completion:*:*' ignored-patterns '*ORIG_HEAD'
bindkey '^F' _ggrep
export GIT_DISCOVERY_ACROSS_FILESYSTEM=1
export KEYTIMEOUT=1

# from i8ramin - http://getintothis.com/blog/2012/04/02/git-grep-and-blame-bash-function/
# runs git grep on a pattern, and then uses git blame to who did it
ggb() {
    git grep -n $1 | while IFS=: read i j k; do git blame -L $j,$j $i | cat; done
}

# small modification for git egrep bash
geb() {
    git grep -E -n $1 | while IFS=: read i j k; do git blame -L $j,$j $i | cat; done
}

# HISTORY
export HISTSIZE=1000000                # set history size
export SAVEHIST=1000000                # save history after logout
export HISTFILE=${HOME}/.config/zsh_history  # history file
export HISTIGNORE="^(fg|bg|ls|s|p|q)$"
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=yellow"

# EXPORTS
export TERM="xterm-256color"
export EDITOR="$(which nvim || which vim)"
#export MANPAGER="/bin/sh -c \"col -b | $EDITOR -c 'set ft=man ts=8 nomod nolist nonu noma' -\""
export VISUAL="$EDITOR"
SCCACHE="$(which sccache)"
[[ -e $SCCACHE ]] && export RUSTC_WRAPPER="$SCCACHE"

# ALIASES
bluetooth_fix() {
  #ps -ef | grep blu
  #echo 'Killing bluetoothd'
  #sudo pkill bluetoothd
  sudo modprobe -r btintel btusb
}
alias battery_level='python -c "print(str(round(100*$(cat /sys/class/power_supply/BAT0/energy_now) / $(cat /sys/class/power_supply/BAT0/energy_full))))"'
alias matches="grep -o"
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
alias ci="r"
alias g++="g++ -std=c++14 -Wall -Werror"
alias ghc="ghc -Wall"
alias ghct="ghc -Wall -O2 -threaded -rtsopts -with-rtsopts='-N4'"
alias got='git'
alias grep="grep -E"
alias ma0="map"
alias mapo="map"
alias amp="map"
alias mao="map"
alias npmm="npm"
alias turbo="npm exec turbo --"
alias tsc="npm exec tsc --"
alias vite="npm exec vite --"
alias vitest="npm exec vitest --"
# alias swa="npm exec swa --"
alias func="npm exec func --"
alias nt="cargo nextest run"
alias q="exit"
alias reauthor="git commit --amend --no-edit --author='J Pratt <jp10010101010000@gmail.com>'"
alias td="RUST_LOG=\"debug\" cargo test"
alias ti="RUST_LOG=\"info\" cargo test"
alias tt="RUST_LOG=\"trace\" cargo test"
alias open="xdg-open"
alias v="$EDITOR "
alias vi="$EDITOR "
alias vim="$EDITOR "
alias vi="vim"
alias v="vim"
alias :e="vim"
alias zrc="$EDITOR ${HOME}/.config/zshrc"
alias vrc="$EDITOR ${HOME}/.config/nvim/lua/cypher1/init.lua"
alias icat="kitty +kitten icat"
alias bob="/data/data/com.termux/files/home/skfltech/skfl/bob.ts"
w() { cargo watch -x "test $@" }
function mk() {
  mkdir -p $1
  cd $1
}

export CARGO_TARGET_DIR="${HOME}/.cargo/target"
export CARGO_INCREMENTAL=0
