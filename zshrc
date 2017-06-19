DEFAULT_USER="jopra"
HOME="`cd;pwd`"
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="bullet-train"
BULLETTRAIN_STATUS_EXIT_SHOW=true
BULLETTRAIN_PROMPT_ADD_NEWLINE=false
BULLETTRAIN_DIR_EXTENDED=1
BULLETTRAIN_VIRTUALENV_SHOW=true
BULLETTRAIN_VIRTUALENV_FG=black
BULLETTRAIN_TIME_SHOW=false
BULLETTRAIN_EXEC_TIME_SHOW=true
BULLETTRAIN_GIT_DIRTY_BG=yellow
BULLETTRAIN_GIT_BG=green
BULLETTRAIN_DIR_FG=black
BULLETTRAIN_GIT_DIRTY_FG=black
BULLETTRAIN_GIT_FG=black
BULLETTRAIN_PROMPT_CHAR=""
BULLETTRAIN_GIT_FETCH=true

plugins=(cabal catimg extract gem gitfast jsontools last-working-dir npm pip python sudo z safe-paste zsh-autosuggestions zsh-completions)
source $ZSH/oh-my-zsh.sh
export KEYTIMEOUT=1

# CHANGING DEFAULTS
alias reboot="sudo reboot"
alias shutdown="sudo shutdown -h now"
alias cp="cp -r"
alias rm="rm -r"
alias grep="egrep --color=always"
VISUAL="nvim"
alias vi="nvim "
alias vim="nvim -O"
alias ghct="ghc -Wall -O2 -threaded -rtsopts -with-rtsopts='-N4'"
alias ghc="ghc -Wall"
alias g++="g++ -std=c++14 -Wall -Werror"
alias cat="ccat"

# ADDITIONS
alias zsh_upgrade="zsh ~/.oh-my-zsh/tools/upgrade.sh"
alias zrc="nvim ~/.zshrc"
alias vrc="nvim ~/.config/nvim/init.vim"
alias .="clear && cd . && ls"
alias ..="clear && cd .. && ls"
alias r="clear"
alias v="nvim"
alias t="time"
alias q="exit"
alias u="du -hs *"
alias -s py='python3'
alias -s cpp='nvim'
alias -s h='nvim'
alias -s tem='nvim'
alias -s md='nvim'
alias -s html='nvim'
alias -s js='nvim'
alias server="python -m SimpleHTTPServer"
alias jp='processing-java --sketch=`pwd` --present'
alias prolog="swipl -s"

function mk { mkdir $1; cd $1; }
function clean {
    rm *.pyc;
    rm *.o;
    rm *.class;
    rm *.hi;
    rm *.gch;
    rm nohup.out;
    clear;
}

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
        confirm "Install Hoogle?" && cabal install hoogle
    fi
    hoogle generate;
    hoogle "$@" | ccat;
}

# HISTORY
export HISTSIZE=1000000                # set history size
export SAVEHIST=1000000                # save history after logout
export HISTFILE=~/.config/zsh_history  # history file
setopt INC_APPEND_HISTORY              # append into history file
setopt HIST_IGNORE_DUPS                # save only one command if 2 common are same and consistent

# GIT COMMANDS
function gitbranchcheck { # FUNCTION TO CHECKOUT OR CREATE A BRANCH
    git checkout $1 || (git branch $1; git checkout $1);
}
function _gitbranchcheck { # AUTO COMPLETE BRANCHES
    reply=($(git branch --no-color | grep -o '[^ ]*$'))
}
compctl -K _gitbranchcheck gitbranchcheck
function realpath {
  file="$1"
  dir="$(dirname "$file")"
  echo "$(cd "$dir"; pwd)/$(basename "$file")"
}
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
  echo "Deduplication .gitignore"
  cat "$ignore" | sort | uniq > "$tmp"
  mv "$tmp" "$ignore"
}
alias -s git='git clone'
alias s="git status -sb 2> /dev/null && echo '-------'; ls"
alias a="git add"
alias m="git commit -m "
alias p="git push"
alias d="git diff"
alias D="git diff --staged"
alias b="gitbranchcheck"
alias g="git log --graph"
alias gi="gitignore"
alias ga="git ls-files | while read f; do git blame --line-porcelain \$f | grep '^author ' | sed 's/author //' | sed 's/cypher/Joshua Pratt/' | sed 's/kat333/Katherine Perdikis/'; done | sort -f | uniq -ic | sort -n"
alias gitnuke="confirm 'CONFIRM NUKE' && git fetch origin && git reset --hard origin/master"
alias P='git fetch && git diff origin/master && confirm "Pull?" && git pull'
export GIT_DISCOVERY_ACROSS_FILESYSTEM=1

alias ho="heroku open"
alias hl="heroku logs -t"
alias hb="heroku run bash"

# SSH via zshrc
alias mosh="mosh -6"
alias cse="ssh z5017666@cse.unsw.edu.au"
alias cse_cp="scp * z5017666@cse.unsw.edu.au:./"

# OVERRIDES
export PATH="$PATH:/usr/local/bin:$HOME/Library/Haskell/bin:$HOME/.local/bin/"
export PATH="$PATH:/Applications/Postgres.app/Contents/Versions/latest/bin"
export PATH="$PATH:/usr/local/opt/go/libexec/bin"
export PATH=$PATH:$(go env GOPATH)/bin
export GOPATH=$(go env GOPATH)
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=yellow"
eval "$(direnv hook zsh)"
