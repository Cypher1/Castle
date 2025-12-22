#!/usr/bin/zsh
zmodload zsh/zprof
export HOME="$(cd;pwd)"
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

path() {
  # Add the path to the front & remove duplicates occuring elsewhere.
  addition="$1"
  PATH="$(echo "$PATH" | sed "s|$addition:||g")"
  export PATH="$addition:${PATH}"
}

# Set up path!
# Later is higher precedence
path "/usr/bin"
path "/var/lib/snapd/snap/bin"
path "/usr/local/bin"
path "/opt/local/bin"
path "/usr/sbin"
path "/usr/local/sbin"
path "${HOME}/.npm-global/bin"
path "${HOME}/.cargo/bin"
path "${HOME}/.dotnet/tools"
path "${HOME}/.local/bin"
path "${HOME}/.zplug/bin"
path "${HOME}/.config/bin"
path "/usr/local/cuda-12.5/bin"


ZPLUG_HOME="${HOME}/.zplug"
function install_zplug() {
  ZPLUG_URL="https://raw.githubusercontent.com/zplug/installer/master/installer.zsh"
  curl -sL --proto-redir -all,https "${ZPLUG_URL}" | zsh
}
function zrepo() {
  # Use zplug for non-plugins :O
  zplug "$@", ignore:"*"
}

function zREPO() {
  if [[ "$OSTYPE" != "linux-android" ]]; then
    zrepo "$@"
  fi
}

source "${HOME}/.zplug/init.zsh" || echo "'zplug' missing run 'install_zplug'"

# PLUGINS
zplug cypher1/Castle, dir:"${HOME}/.config", at:main
zplug cypher1/greasy, dir:"${HOME}/src/greasy"
zplug zsh-users/zsh-autosuggestions
zplug zsh-users/zsh-completions
zplug romkatv/powerlevel10k, as:theme, depth:1
zplug agkozak/zsh-z, depth:1
zplug sorin-ionescu/prezto, depth:1
zplug modules/history, from:prezto
zplug modules/node, from:prezto

zREPO HCAIRESteam/hcaires, dir:"${HOME}/src/hcaires", frozen:1
zREPO PolymerLabs/arcs, dir:"${HOME}/src/arcs", frozen:1
zREPO cypher1/greasy, dir:"${HOME}/src/greasy"
zREPO cypher1/llvm-project, dir:"${HOME}/src/llvm-project", frozen:1
zREPO cypher1/mdbook-graphviz, dir:"${HOME}/src/mdbook-graphviz"
zREPO cypher1/no_debug, dir:"${HOME}/src/no_debug", frozen:1
zREPO cypher1/nvim_config, dir:"${HOME}/src/nvim"
zREPO cypher1/poetry, dir:"${HOME}/src/poetry"
zREPO cypher1/poetry-core, dir:"${HOME}/src/poetry-core"
zREPO cypher1/qmk_firmware, dir:"${HOME}/src/qmk_firmware"
zREPO neovim/neovim, dir:"${HOME}/src/neovim", frozen:1
# zREPO pop-os/cosmic-epoch, dir:"${HOME}/src/cosmic-epoch", frozen:1
zREPO tcdi/plrust, dir:"${HOME}/src/plrust"
zrepo cypher1/notes, dir:"${HOME}/src/notes"
zrepo cypher1/nvim_config, dir:"${HOME}/src/nvim"
zrepo cypher1/tako, dir:"${HOME}/src/tako", frozen:1
zrepo skfltech/skfl, dir:"${HOME}/src/skfl", frozen:1

# Settings for plugins
autoload -U select-word-style
select-word-style bash
export WORDCHARS=' *?_-.[]~=\\/&;!#$%^(){}<>'
zstyle ':prezto:module:directory:alias' skip 'yes'
zstyle ':autocomplete:*' default-context history-incremental-search-backward
zstyle ':completion:*:*' ignored-patterns '*ORIG_HEAD'

# SETUP ZPLUG
zplug load #--verbose

# CUSTOM CONFIG

# Configure arrive (run after arrive.zsh is loaded)
function arrive() {
  install_zplug
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
}

function do_arrive() {
  # Install plugins if there are plugins that have not been installed
  if ! zplug check --verbose; then
      printf "Install? [y/N]: "
      if read -q; then
          echo; zplug install
      fi
  fi

  link "${HOME}/src/nvim" "${HOME}/.config/nvim"
  link "${HOME}/.config/zshrc" "${HOME}/.zshrc"
  link "${HOME}/.config/gitconfig" "${HOME}/.gitconfig"
  link "${HOME}/.config/pylintrc" "${HOME}/.pylintrc"

  echo "${HOME}/.config/crontab" > crontab

  # LOAD EXTERNALS
  program zsh
  program fzf
  program nvim neovim
  program git
  program python3
  if [[ "$OSTYPE" != "linux-android" ]]; then
    program kitty
    program rustup
  fi
  dotfile gitconfig
  dotfile pylintrc
  dotfile zshrc
  dotfile fzf.zsh
}

function unique() {
  cat -n | sort --key=2.1 -b -u | sort -n | cut -c8-
}
function join() {
  tr '\n' $1 | sed "s/$1$//"
}

autoload -U +X bashcompinit && bashcompinit

GIT_BIN="$(which git)"

function git() {
  declare -a git_opts=()
  declare -a cmd=()
  declare -a cmd_opts=()
  declare -a tail=()

  git_opts_regex="^(--no-pager)"
  args_later_regex="^(stash)"
  opts_regex="^-"
  needs_arg=false
  accepting_args=false
  ## Loop through the args and reorder them as necessary
  for i in "${@}"
  do
    if [[ "$i" =~ "$git_opts_regex" ]]; then
      git_opts+=( "$i" )
      continue
    fi
    if [[ $accepting_args = "true" ]]; then
      if [[ $needs_arg = "true" ]]; then
        cmd_opts+=( "$i" )
        needs_arg=false
        continue
      fi
      if [[ "$i" =~ "$opts_regex" ]]; then
        cmd_opts+=( "$i" )
        needs_arg=true
        continue
      fi
    fi
    if [ ${#cmd[@]} -eq 0 ]; then
      cmd+=( "$i" )
      if [[ "$i" =~ "$args_later_regex" ]]; then
        accepting_args=false
      fi
      continue
    fi
    tail+=( "$i" )
  done
  declare -a shell=()
  shell+=( "${cmd[@]}" )
  shell+=( "${cmd_opts[@]}" )
  shell+=( "${tail[@]}" )
  # echo "$GIT_BIN ${shell[@]}" > /dev/stderr
  $GIT_BIN ${shell[@]}
}

compdef _p p pP pPF bd bD bdF bDF
compdef _up up

# SET OPTIONS
setopt INC_APPEND_HISTORY
setopt HIST_IGNORE_DUPS
setopt no_bang_hist # turn off history expansion using !

# Home and end
bindkey  "^[[H"   beginning-of-line
bindkey  "^[[F"   end-of-line
# Alt => Lines
bindkey '^[[1;3D' beginning-of-line
bindkey '^[[1;3C' end-of-line

# Chars
bindkey  "^[[3~"  delete-char # Delete

# Ctrl => Words
bindkey  "^w"   backward-kill-word
bindkey  "^H"  backward-kill-word # Ctrl+Backspace
bindkey  "^[[1;5D"   backward-word
bindkey  "^[[1;5C"   forward-word

# Debug
bindkey '^[v' .describe-key-briefly

function _nvim_mode {
  TMP="$(mktemp)"
  echo "$BUFFER" >> $TMP
  ${EDITOR:-vim} $TMP && BUFFER="$(cat $TMP)" && CURSOR="$#BUFFER"
}
zle -N _nvim_mode
bindkey '^e' _nvim_mode

function _sudobuf {
  OFFSET_CURSOR="$(($#BUFFER-CURSOR))"
  if [ -z "$BUFFER" ]; then
    BUFFER="$history[$((HISTCMD-1))]"
  fi
  BUFFER="$(echo "sudo $BUFFER" | sed "s/sudo sudo //")"
  CURSOR="$(($#BUFFER-OFFSET_CURSOR))"
}
zle -N _sudobuf
bindkey '^[^[' _sudobuf

function _ggrepconflict {
  LINE="<<<<<<<"
  zle push-input
  root && BUFFER="gg '$LINE' | ge '+/$LINE'"
  zle accept-line
}
zle -N _ggrepconflict
bindkey '^G' _ggrepconflict

function _ggrep {
  if [ -z "$BUFFER" ]; then
    root && $EDITOR "+:GGrep"
    return
  fi
  LINE="$BUFFER"
  zle push-input
  root && BUFFER="gg '$LINE' | ge '+/$LINE' '+:GGrep \"$LINE\"' || vim '+:GGrep \"$LINE\"'"
  zle accept-line
}
zle -N _ggrep
bindkey '^F' _ggrep

export GIT_DISCOVERY_ACROSS_FILESYSTEM=1
export KEYTIMEOUT=0.1

function _restart_zsh {
  BUFFER="exec zsh"
  zle accept-line
}
zle -N _restart_zsh
bindkey '^L' _restart_zsh

# HISTORY
export HISTSIZE=1000000 # set history size
export SAVEHIST=1000000 # save history after logout
export HISTFILE=${HOME}/.config/zsh_history  # history file
export HISTIGNORE="^(fg|bg|ls|s|p|q)$"
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=yellow"

# EXPORTS
export LLVM_SYS_150_PREFIX="${HOME}/llvm-project/build"
export TERM="xterm-256color"
export EDITOR="$(which zed || which nvim || which vim)"
export VISUAL="$EDITOR"
export CARGO_TARGET_DIR="${HOME}/.cargo/target"
export CARGO_INCREMENTAL=0

SCCACHE="$(which sccache)"
[[ -e $SCCACHE ]] && export RUSTC_WRAPPER="$SCCACHE"

# ALIASES
function bluetooth_fix() {
  #ps -ef | grep blu
  #echo 'Killing bluetoothd'
  #sudo pkill bluetoothd
  sudo modprobe -r btusb btintel
}
alias battery_level='python -c "print(str(round(100*$(cat /sys/class/power_supply/BAT0/energy_now) / $(cat /sys/class/power_supply/BAT0/energy_full))))"'
alias matches="grep -o"
alias -g withFire="-9"

alias .="clear;s"
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ......="cd ../../../../.."

alias cl="less -r -f +G +g .c.log"

function c() {
  cargo check --all-targets --color always $@ 2>&1 | tee .c.log | less -r +G +g
}
alias tl="less -r -f +G +g .t.log"
function t() {
  cargo test --color always $@ 2>&1 | tee .t.log | less -r +G +g
}

alias sync='((a . && m "Backup $(date)") || true) && pP'
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
alias zrc="zed ${HOME}/.config/zshrc"
alias grc="zed ${HOME}/.config/gitconfig"
alias vrc="$EDITOR ${HOME}/.config/nvim/**/*.lua"
alias icat="kitty +kitten icat"
alias bob="${HOME}/skfltech/skfl/bob.ts"

# To customize prompt, run `p10k configure` or edit ~/.config/p10k.zsh.
[[ ! -f ~/.config/p10k.zsh ]] || source ~/.config/p10k.zsh

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" 2> /dev/null  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" 2> /dev/null  # This loads nvm bash_completion
nvm use v18.20.4 > /dev/null 2>&1

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
