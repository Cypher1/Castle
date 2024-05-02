#!/usr/bin/zsh
export HOME="$(cd;pwd)"
ZPLUG_HOME="${HOME}/.zplug"
ZPLUG_REPOS="${ZPLUG_HOME}/repos"
ZPLUG_URL="https://raw.githubusercontent.com/zplug/installer/master/installer.zsh"
if [ ! -d "${ZPLUG_HOME}" ]; then
  curl -sL --proto-redir -all,https "${ZPLUG_URL}" | zsh
fi

if [ ! -d "${HOME}/.zplug/" ]; then
  echo "Error loading zplug"
fi

source "${HOME}/.zplug/init.zsh"

# PLUGINS

zplug cypher1/Castle
zplug cypher1/nvim_config
zplug cypher1/mdbook-graphviz
zplug cypher1/greasy
zplug zsh-users/zsh-autosuggestions
zplug zsh-users/zsh-completions
zplug lukechilds/zsh-nvm
zplug lukechilds/zsh-better-npm-completion
zplug romkatv/powerlevel10k, as:theme, depth:1
zplug cypher1/tako
zplug skfltech/skfl
zplug plugins/z, from:oh-my-zsh
zplug plugins/git, from:oh-my-zsh
zplug plugins/command-not-found, from:oh-my-zsh
zplug plugins/last-working-dir, from:oh-my-zsh
zplug plugins/rust, from:oh-my-zsh
zplug plugins/sudo, from:oh-my-zsh
zplug plugins/zsh-autosuggestions, from:oh-my-zsh
zplug plugins/zsh-completions, from:oh-my-zsh

# SETUP ZPLUG
zplug load # --verbose

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

function link() {
  if [ -d "$2" ]; then
    return
  fi
  ln -sf "$1" "$2"
}

link "${ZPLUG_REPOS}/cypher1/Castle" "${HOME}/.config"
link "${ZPLUG_REPOS}/cypher1/nvim_config" "${ZPLUG_REPOS}/cypher1/Castle/nvim"
link "${ZPLUG_REPOS}/cypher1/greasy" "${ZPLUG_REPOS}/cypher1/Castle/greasy"
link "${ZPLUG_REPOS}/cypher1/tako" "${HOME}/Code/tako"
link "${ZPLUG_REPOS}/skfltech/skfl" "${HOME}/Code/skfl"
link "${ZPLUG_REPOS}/cypher1/mdbook-graphviz" "${HOME}/Code/mdbook-graphviz"

# CUSTOM CONFIG

export LLVM_SYS_150_PREFIX="${HOME}/llvm-project/build"
export WORDCHARS=' *?_-.[]~=/&;!#$%^(){}<>'

source "${HOME}/.config/colors.sh"
source "${HOME}/.config/arrive.zsh"
export NVM_LAZY_LOAD=true

path "/usr/lib/ccache" # Ensure that ccache versions are used over other compilers
path "/usr/local/bin"
path "/opt/local/bin"
path "/opt/fx_cast/"
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
bindkey -s "^L" "exec zsh\n"

function _ggrepconflict {
  LINE="<<<<<<<"
  zle push-input
  BUFFER="vim \"+:GGrep $LINE\""
  zle accept-line
}
zle -N _ggrepconflict
bindkey '^G' _ggrepconflict

function _ggrep {
  LINE="$BUFFER"
  zle push-input
  BUFFER="vim \"+:GGrep $LINE\""
  zle accept-line
}
zle -N _ggrep
bindkey '^F' _ggrep

zstyle ':autocomplete:*' default-context history-incremental-search-backward
zstyle ':completion:*:*' ignored-patterns '*ORIG_HEAD'
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
export HISTSIZE=1000000 # set history size
export SAVEHIST=1000000 # save history after logout
export HISTFILE=${HOME}/.config/zsh_history  # history file
export HISTIGNORE="^(fg|bg|ls|s|p|q)$"
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=yellow"

# EXPORTS
export TERM="xterm-256color"
export EDITOR="$(which nvim || which vim)"
export VISUAL="$EDITOR"
SCCACHE="$(which sccache)"
[[ -e $SCCACHE ]] && export RUSTC_WRAPPER="$SCCACHE"

# ALIASES
bluetooth_fix() {
  #ps -ef | grep blu
  #echo 'Killing bluetoothd'
  #sudo pkill bluetoothd
  sudo modprobe -r btusb btintel
}
alias battery_level='python -c "print(str(round(100*$(cat /sys/class/power_supply/BAT0/energy_now) / $(cat /sys/class/power_supply/BAT0/energy_full))))"'
alias matches="grep -o"
alias .="clear;ls"
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
alias got="git"
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
alias reauthor="git commit --amend --no-edit --author='Jay Pratt <jp10010101010000@gmail.com>'"
alias td="RUST_LOG=\"debug\" cargo test"
alias ti="RUST_LOG=\"info\" cargo test"
alias tt="RUST_LOG=\"trace\" cargo test"
alias open="xdg-open"
alias v="$EDITOR "
alias vi="$EDITOR "
alias vim="$EDITOR "
alias :e="$EDITOR "
alias zrc="$EDITOR ${HOME}/.config/zshrc"
alias vrc="$EDITOR ${HOME}/.config/nvim/lua/cypher1/init.lua"
alias icat="kitty +kitten icat"
alias bob="/data/data/com.termux/files/home/skfltech/skfl/bob.ts"

export CARGO_TARGET_DIR="${HOME}/.cargo/target"
