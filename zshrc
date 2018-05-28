DEFAULT_USER="cypher"
HOME="`cd;pwd`"
export ZSH="$HOME/.oh-my-zsh"
export TERM="xterm-256color"

ZSH_THEME="bullet-train"
BULLETTRAIN_DIR_FG=white
BULLETTRAIN_GIT_DIRTY_BG=yellow
BULLETTRAIN_GIT_BG=black
BULLETTRAIN_GIT_DIRTY_FG=white
BULLETTRAIN_GIT_FG=white

BULLETTRAIN_PROMPT_ADD_NEWLINE=false
BULLETTRAIN_DIR_EXTENDED=1
BULLETTRAIN_GIT_FETCH=true
BULLETTRAIN_PROMPT_CHAR=""
BULLETTRAIN_PROMPT_ORDER=(
    cmd_exec_time
    status
    git
    dir
  )
plugins=(
    last-working-dir
    sudo
    z
    fancy-ctrl-z
    copybuffer # bound to <c-o>
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
export HISTIGNORE="(fg|bg)"
# append into history file
setopt INC_APPEND_HISTORY
# save only one command if 2 common are same and consistent
setopt HIST_IGNORE_DUPS
# turn off history expansion using !
setopt no_bang_hist
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=orange"
export GIT_DISCOVERY_ACROSS_FILESYSTEM=1
export KEYTIMEOUT=1
# OVERRIDES
export PATH="$PATH:/usr/local/bin:$HOME/Library/Haskell/bin:$HOME/.local/bin/:/usr/local/go/bin:$HOME/.config/bin"

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
alias nrc="sudo $EDITOR /etc/nixos/configuration.nix"
alias vrc="$EDITOR ~/.config/nvim/init.vim"
alias 3rc="$EDITOR ~/.config/i3/config"
alias 3src="$EDITOR ~/.config/i3/i3status.conf"
alias .="r && cd . && ls"
alias ..="r && cd .. && ls"
alias r="clear"
alias t="time"
alias q="exit"
alias u="du -hs *"

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

function lamb () {
    if command -v "hoogle" > /dev/null 2>&1; then
    else
        confirm "Install Hoogle?" && stack install hoogle
    fi
    cacher 3600 hoogle generate > /dev/null
    hoogle "$@" | ccat;
}

# GIT COMMANDS
function root {
  cd $(git rev-parse --show-toplevel)
}
function rexe {
  root && $1 ${@:2}
  cd -
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
alias g="git log --graph"
alias ga="git ls-files | while read f; do git blame --line-porcelain \$f | grep '^author ' | sort -f | uniq -ic | sort -n"

alias ho="heroku open"
alias hl="heroku logs -t"
alias hb="heroku run bash"

#alias open="xdg-open"

alias nix-zsh="nix-shell --command zsh"
alias nix-env-search="cacher 36000 'nix-env -qaP' |grep -i"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
