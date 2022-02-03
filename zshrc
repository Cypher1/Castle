HOME="`cd;pwd`"

bindkey -v
bindkey "^R" history-incremental-search-backward

POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(root_indicator dir) # vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status command_execution_time background_jobs)
POWERLEVEL9K_PROMPT_ON_NEWLINE=true
POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX=""
POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX=""

source "${HOME}/.powerlevel10k/powerlevel10k.zsh-theme" || (git clone https://github.com/romkatv/powerlevel10k.git ${HOME}/.powerlevel10k && source "${HOME}/.powerlevel10k/powerlevel10k.zsh-theme")

export ZSH="$HOME/.oh-my-zsh"
export TERM="xterm-256color"

plugins=(
    z
    last-working-dir
    zsh-autosuggestions
    zsh-completions
    sudo
  )

# HISTORY
export HISTSIZE=1000000                # set history size
export SAVEHIST=1000000                # save history after logout
export HISTFILE=${HOME}/.config/zsh_history  # history file
export HISTIGNORE="^(fg|bg|ls|s|p|q)$"
# append into history file
setopt INC_APPEND_HISTORY
# save only one command if 2 common are same and consistent
setopt HIST_IGNORE_DUPS
# turn off history expansion using !
setopt no_bang_hist
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=yellow"
export GIT_DISCOVERY_ACROSS_FILESYSTEM=1
export KEYTIMEOUT=1
# OVERRIDES
export PATH="${PATH}:/usr/local/bin"
export PATH="${PATH}:/opt/local/bin"
export PATH="${PATH}:/usr/local/opt/llvm/bin"
export PATH="${PATH}:${HOME}/.gem/ruby/2.6.0/bin"
export PATH="${PATH}:/usr/local/go/bin"
export PATH="${PATH}:${HOME}/Library/Haskell/bin"
export PATH="${PATH}:${HOME}/opt/gcc-arm-none-eabi-8-2018-q4-major/bin/"
export PATH="${PATH}:${HOME}/.cabal/bin"
export PATH="${PATH}:${HOME}/.cargo/bin"
export PATH="${PATH}:${HOME}/.local/bin/"
export PATH="${PATH}:${HOME}/.config/bin"

SCCACHE="$(which sccache)"
if [[ -x "$SCCACHE" ]]
then
export RUSTC_WRAPPER="$SCCACHE" 
else
export RUSTC_WRAPPER=""
fi

source $ZSH/oh-my-zsh.sh
autoload -U +X bashcompinit && bashcompinit

# CHANGING DEFAULTS
alias cp="cp -r"
alias grep="egrep"
export EDITOR="$(which nvim || which vim)"
export MANPAGER="/bin/sh -c \"col -b | $EDITOR -c 'set ft=man ts=8 nomod nolist nonu noma' -\""
VISUAL="$EDITOR"
alias vi="$EDITOR -O"
alias vim="$EDITOR "
alias zrc="$EDITOR ${HOME}/.config/zshrc"
alias vrc="$EDITOR ${HOME}/.config/nvim/init.vim"
alias 3rc="$EDITOR ${HOME}/.config/i3/config"
alias 3src="$EDITOR ${HOME}/.config/i3/i3status.conf"

alias ghct="ghc -Wall -O2 -threaded -rtsopts -with-rtsopts='-N4'"
alias ghc="ghc -Wall"
alias g++="g++ -std=c++14 -Wall -Werror"
alias q="exit"

# GIT COMMANDS
alias ma0="map"
alias got='git'

alias sigh="${HOME}/Projects/arcs/tools/sigh"

[ -f ${HOME}/.config/greasy/greasy.zsh ] && source ${HOME}/.config/greasy/greasy.zsh || echo 'greasy is missing'
[ -f ${HOME}/.config/fzf-tab-completion/zsh/fzf-zsh-completion.sh ] && source ${HOME}/.config/fzf-tab-completion/zsh/fzf-zsh-completion.sh || echo 'fzf-tab-completion is missing'
bindkey '^I' fzf_completion

alias reauthor="git commit --amend --no-edit --author='J Pratt <jp10010101010000@gmail.com>'"

export DISPLAY=:0
export RUST_SRC_PATH=${HOME}/.rustup/toolchains/beta-x86_64-unknown-linux-gnu/lib/rustlib/src/rust/src

export PATH=/usr/lib/ccache:$PATH
alias t="TAKO_LOG=\"debug\" cargo test"
alias c="cargo check --all-targets"
function st() {
    cargo test "$@" | grep -v "test .*\.\.\."
}
alias tr="r --release"
alias bq="r build --color=always 2>&1 | less -"
alias pi='ssh pi@192.168.0.251 -p 5000'
