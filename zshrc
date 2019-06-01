DEFAULT_USER="cypher"
HOME="`cd;pwd`"

POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(root_indicator dir_writable dir) # vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status command_execution_time background_jobs time)
POWERLEVEL9K_PROMPT_ON_NEWLINE=true
POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX=""
POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX=""

source "${HOME}/.powerlevel10k/powerlevel10k.zsh-theme" || (git clone https://github.com/romkatv/powerlevel10k.git ~/.powerlevel10k && source "${HOME}/.powerlevel10k/powerlevel10k.zsh-theme")

export ZSH="$HOME/.oh-my-zsh"
export TERM="xterm-256color"

plugins=(
    last-working-dir
    sudo
    z
    fancy-ctrl-z
    copybuffer # bound to <Control-o>
    python
    pip
    systemadmin
    zsh-autosuggestions
    zsh-completions
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
export PATH="${PATH}:${HOME}/.local/bin/"
export PATH="${PATH}:${HOME}/.config/bin"

source $ZSH/oh-my-zsh.sh

autoload -U +X bashcompinit && bashcompinit

_stack() {
    # eval "$(stack --bash-completion-script stack)"
    local CMDLINE
    local IFS=$'\n'
    CMDLINE=(--bash-completion-index $COMP_CWORD)

    for arg in ${COMP_WORDS[@]}; do
        CMDLINE=(${CMDLINE[@]} --bash-completion-word $arg)
    done

    COMPREPLY=( $(stack "${CMDLINE[@]}") )
}
complete -o filenames -F _stack stack

# CHANGING DEFAULTS
alias reboot="sudo reboot"
alias shutdown="sudo shutdown -h now"
alias cp="cp -r"
alias rm="rm -r"
alias grep="egrep"
EDITOR="$(which nvim || which vim)"
VISUAL="$EDITOR"
alias v="$EDITOR"
alias vi="$EDITOR -O"
alias vim="$EDITOR "
alias ghct="ghc -Wall -O2 -threaded -rtsopts -with-rtsopts='-N4'"
alias ghc="ghc -Wall"
alias g++="g++ -std=c++14 -Wall -Werror"

# ADDITIONS
alias zsh_upgrade="zsh ~/.oh-my-zsh/tools/upgrade.sh"
alias zrc="$EDITOR ~/.config/zshrc"
alias vrc="$EDITOR ~/.config/nvim/init.vim"
alias 3rc="$EDITOR ~/.config/i3/config"
alias 3src="$EDITOR ~/.config/i3/i3status.conf"

alias r="clear"
alias .="r && cd . && ls"
alias ..="r && cd .. && ls"
alias t="time"
alias q="exit"
alias u="du -hs *"
alias :q="exit"
alias :qa="exit"
alias :wq="exit"
alias :wqa="exit"
alias :r="clear; ctest"

function mk { mkdir $1; cd $1; }

function watch {
    sleeptime="${2:-2}"
    while true; do
        clear
        echo -n `date`
        echo " Running \`$1\` every $sleeptime seconds"
        sh -c "$1"
        sleep $sleeptime
    done;
}

function confirm {
    # call with a prompt string or use a default
    echo -n "${1:-Are you sure?} [y/N] "
    read response
    if [[ $response =~ ^([yY][eE][sS]|[yY])$ ]] then;
        return 0;
    fi;
    return 1;
}

function h() {
    if command -v "hoogle" > /dev/null 2>&1; then
    else
        confirm "Install Hoogle?" && stack install hoogle
    fi
    cacher 36000000 hoogle generate > /dev/null
    hoogle "$@" --count=60 | ccat;
}

function new-module () {
  name="$1"
  echo "module $name where" > "$name.hs"
}

# GIT COMMANDS
function run-server {
  BUILDCOMMAND=$1
  RUNCOMMAND=$2
  RESTARTER=$3
  MSG='Server starting'

  COMMAND="$BUILDCOMMAND && ($RESTARTER; echo '$MSG'; date; $RUNCOMMAND &)"
  when-changed -s **/* -c "$COMMAND"
}

function run-servant {
  run-server 'stack build' "stack exec $1" "pkill $1"
}

function blog {
  SERVER="jekyll serve --livereload"
  FILES="$@"
  for f in ${FILES[@]}; do
    sed "s/\(published: *\)false/\1true/" ${f} > /tmp/edit_post
    mv /tmp/edit_post ${f}
  done
  ${EDITOR} ${FILES}
  for f in ${FILES[@]}; do
    sed "s/\(published: *\)true/\1false/" ${f} > /tmp/edit_post
    mv /tmp/edit_post ${f}
  done
}

alias -s git='git clone'
alias s="clear; git status -sb 2> /dev/null && echo '-------'; ls"
alias a="git add"
alias m="git commit -m "
alias p="git push"
alias P="git pull --ff-only"
alias continue="git rebase --continue || git merge --continue"
alias d="git diff"
alias D="git diff --staged"
alias gl="grep -v 'files changed,' | sed 's/[ :|].*$//' | sort | uniq"
alias ge="grep -v 'files changed,' | sed 's/[ :|].*$//' | sort | uniq | xargs nvim"
alias g="git log --graph"
alias ga="git ls-files | while read f; do git blame --line-porcelain \$f; done | grep '^author ' | sort -f | uniq -ic | sort -n"
alias gg="git grep -i"
alias log="git log"
alias gbn="git branch -m"
alias branch="git branch --color=never | grep '*' | cut -f2 -d' '"
alias map="$HOME/.depot/git_map_branches.py -vv | git branch -vv | cat"

function swap() {
  mv "$2" _swap_tmp_
  mv "$1" "$2"
  mv _swap_tmp_ "$1"
}

alias -s exe='wine'
alias sigh="~/Projects/arcs/tools/sigh"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
[ -f ~/.nvm/nvm.sh ] && source ~/.nvm/nvm.sh
[ -f ~/.ghcup/env ] && source ~/.ghcup/env
