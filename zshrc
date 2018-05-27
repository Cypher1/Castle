DEFAULT_USER="cypher"
HOME="`cd;pwd`"
export ZSH="$HOME/.oh-my-zsh"
export TERM="vt100"

ZSH_THEME="bullet-train"
BULLETTRAIN_VIRTUALENV_FG=black
BULLETTRAIN_DIR_FG=black
BULLETTRAIN_GIT_DIRTY_BG=yellow
BULLETTRAIN_GIT_BG=green
BULLETTRAIN_GIT_DIRTY_FG=black
BULLETTRAIN_GIT_FG=black

BULLETTRAIN_PROMPT_ADD_NEWLINE=false
BULLETTRAIN_DIR_EXTENDED=1
BULLETTRAIN_GIT_FETCH=true
BULLETTRAIN_PROMPT_CHAR=""
BULLETTRAIN_PROMPT_ORDER=(
    dir
    virtualenv
    go
    git
    hg
    status
    cmd_exec_time
  )

plugins=(
    last-working-dir
    sudo
    z
    fancy-ctrl-z
    copybuffer # bound to <c-o>
    copyfile
    extract
    gitfast
    web-search
    mosh
    # stack # should PR with completions for exec etc.
    python
    jsontools
    pip
    systemadmin
    zsh-autosuggestions
    zsh-completions
    # less used
    npm
    maven
    golang #need to install gopath
    heroku
    bgnotify # not working
    gem
    command-not-found
    ant
    catimg
    postgres
    cabal
    bower
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
export GIT_DISCOVERY_ACROSS_FILESYSTEM=1

source $ZSH/oh-my-zsh.sh
export KEYTIMEOUT=1

# PLUGIN SETTINGS
bgnotify_threshold=10
function notify_formatted {
  ## $1=exit_status, $2=command, $3=elapsed_time
  [ $1 -eq 0 ] && title="Holy Smokes Batman!" || title="Holy Graf Zeppelin!"
  bgnotify "$title -- after $3 s" "$2";
}

# OVERRIDES
export PATH="$PATH:/usr/local/bin:$HOME/Library/Haskell/bin:$HOME/.local/bin/"
export PATH="$PATH:/usr/local/go/bin"
export PATH="$PATH:$HOME/.config/bin"
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=yellow"

eval "$(direnv hook zsh)"

# CHANGING DEFAULTS
alias reboot="sudo reboot"
alias shutdown="sudo shutdown -h now"
alias cp="cp -r"
alias rm="rm -r"
alias grep="egrep"
alias crap="egrep --color=always"
EDITOR="/home/cypher/.nix-profile/bin/nvim"
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

autoload -U +X compinit && compinit
autoload -U +X bashcompinit && bashcompinit
eval "$(stack --bash-completion-script stack)"

function lamb () {
    if command -v "hoogle" > /dev/null 2>&1; then
    else
        confirm "Install Hoogle?" && stack install hoogle
    fi
    hoogle generate;
    hoogle "$@" | ccat;
}

# GIT COMMANDS
function gitignore {
  top="$(git rev-parse --show-toplevel)"
  ignore="$top/.gitignore"
  tmp="/tmp/gitignore"
  echo $ignore
  strip="$(echo "$top" | sed -e 's/[]\/$*.^|[]/\\&/g')"
  for file in "$@"
  do
    file="$(realpath "$file")"
    rfile="$(echo "$file" | sed "s/$strip\///")"
    echo "Ignoring $rfile"
    echo "$rfile" >> "$ignore"
  done
}
function gitdedup {
  echo "Deduplication .gitignore"
  cat "$ignore" | sort | uniq > "$tmp"
  mv "$tmp" "$ignore"
}
function root {
  cd $(git rev-parse --show-toplevel)
}
function rexe {
  root && $1 ${@:2}
  cd -
}

function swap {
  tmp="/tmp/swapper"
  mv $1 $tmp
  mv $2 $1
  mv $tmp $2
}
alias -s git='git clone'
alias s="clear; git status -sb 2> /dev/null && echo '-------'; ls"
alias a="git add"
alias m="git commit -m "
alias p="git push"
alias P="git pull --ff-only"
alias gc="git rebase --continue"
alias d="git diff"
alias D="git diff --staged"
alias g="git log --graph"
alias gi="gitignore"
alias gidd="gitdedup"
alias ga="git ls-files | while read f; do git blame --line-porcelain \$f | grep '^author ' | sort -f | uniq -ic | sort -n"

alias ho="heroku open"
alias hl="heroku logs -t"
alias hb="heroku run bash"

alias open="xdg-open"

alias nix-zsh="nix-shell --command zsh"
alias nix-env-search="cacher 36000 'nix-env -qaP' |grep -i"
