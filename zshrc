HOME="`cd;pwd`"

bindkey -v
bindkey "^R" history-incremental-search-backward

POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(root_indicator dir) # vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status command_execution_time background_jobs)
POWERLEVEL9K_PROMPT_ON_NEWLINE=true
POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX=""
POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX=""

source "${HOME}/.powerlevel10k/powerlevel10k.zsh-theme" || (git clone https://github.com/romkatv/powerlevel10k.git ~/.powerlevel10k && source "${HOME}/.powerlevel10k/powerlevel10k.zsh-theme")

export ZSH="$HOME/.oh-my-zsh"
export TERM="xterm-256color"

plugins=(
    z
    last-working-dir
    zsh-autosuggestions
    zsh-completions
    sudo
    zsh-interactive-cd
  )

# HISTORY
export HISTSIZE=1000000                # set history size
export SAVEHIST=1000000                # save history after logout
export HISTFILE=~/.config/zsh_history  # history file
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
alias zrc="$EDITOR ~/.config/zshrc"
alias vrc="$EDITOR ~/.config/nvim/init.vim"
alias 3rc="$EDITOR ~/.config/i3/config"
alias 3src="$EDITOR ~/.config/i3/i3status.conf"

alias ghct="ghc -Wall -O2 -threaded -rtsopts -with-rtsopts='-N4'"
alias ghc="ghc -Wall"
alias g++="g++ -std=c++14 -Wall -Werror"
alias q="exit"

# GIT COMMANDS
alias -s git='git clone'
alias s="git status -sb 2> /dev/null && echo '-------'; ls"
alias a="git add"
alias m="git commit -m "
alias p="git push"
alias P="git pull --rebase"
alias continue="git rebase --continue || git merge --continue"
alias d="git diff"
alias D="git diff --staged"
alias gl="grep -v 'files changed,' | sed 's/[ :|].*$//' | sort | uniq"
alias ge="grep -v 'files changed,' | sed 's/[ :|].*$//' | sort | uniq | xargs nvim"
alias ga="git ls-files | while read f; do git blame --line-porcelain \$f; done | grep '^author ' | sort -f | uniq -ic | sort -n"
alias gg="git grep -i"
alias log="git log"
alias branch="git branch --color=never | grep '*' | cut -f2 -d' ' | head -n 1"
alias map="git --no-pager branch -vv --color=always || ls"
alias mtmp="git commit -m 'TMP - unverified' --no-verify"

alias ma0="map"
alias got='git'

alias sigh="~/Projects/arcs/tools/sigh"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
[ -f ~/.nvm/nvm.sh ] && source ~/.nvm/nvm.sh

export DISPLAY=:0
export RUST_SRC_PATH=${HOME}/.rustup/toolchains/beta-x86_64-unknown-linux-gnu/lib/rustlib/src/rust/src

export PATH=/usr/lib/ccache:$PATH
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

alias t="TAKO_LOG=\"debug\" cargo test"
alias c="cargo check --all-targets"
function st() {
    cargo test "$@" | grep -v "test .*\.\.\."
}
alias tr="cargo test --release"
alias r="cargo run"
alias b="cargo build --color=always 2>&1 | less -"
alias reauthor="git commit --amend --no-edit --author='J Pratt <jp10010101010000@gmail.com>'"
