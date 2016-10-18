DEFAULT_USER="cypher"
export ZSH=/Users/Cypher/.oh-my-zsh

ZSH_THEME="bullet-train"
BULLETTRAIN_STATUS_EXIT_SHOW=true
BULLETTRAIN_PROMPT_ADD_NEWLINE=false
BULLETTRAIN_DIR_EXTENDED=1
BULLETTRAIN_VIRTUALENV_SHOW=true
BULLETTRAIN_TIME_SHOW=false
BULLETTRAIN_EXEC_TIME_SHOW=true
BULLETTRAIN_GIT_DIRTY_BG=yellow
BULLETTRAIN_GIT_BG=green
BULLETTRAIN_DIR_FG=black
BULLETTRAIN_GIT_DIRTY_FG=black
BULLETTRAIN_GIT_FG=black
BULLETTRAIN_PROMPT_CHAR=""
BULLETTRAIN_GIT_FETCH=true

plugins=(brew cabal catimg extract gem gitfast jsontools last-working-dir npm pip python sudo z zsh-autosuggestions zsh-completions)
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
alias -s py='nvim'
alias -s cpp='nvim'
alias -s h='nvim'
alias -s tem='nvim'
alias -s md='nvim'
alias -s html='nvim'
alias -s js='nvim'
alias server="python -m SimpleHTTPServer"
alias jp='processing-java --sketch=`pwd` --present'

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

# HISTORY
export HISTSIZE=1000000                # set history size
export SAVEHIST=1000000                # save history after logout
export HISTFILE=~/.config/zsh_history  # history file
setopt INC_APPEND_HISTORY              # append into history file
setopt HIST_IGNORE_DUPS                # save only one command if 2 common are same and consistent

# GIT COMMANDS
alias -s git='git clone'
alias s="git status -sb 2> /dev/null && echo '-------'; ls"
alias a="git add"
alias m="git commit -m "
alias p="git push"
alias g="git log --graph"
alias d="git diff"
alias D="git diff --staged"
alias P="git pull"
alias P='git fetch && git diff origin/master && confirm "Pull?" && git pull'
export GIT_DISCOVERY_ACROSS_FILESYSTEM=1

# SSH via zshrc
alias cse="ssh z5017666@cse.unsw.edu.au"
alias cse_cp="scp * z5017666@cse.unsw.edu.au:./"
alias mimir="ssh app@mimir.systems"

# OVERRIDES
export PATH="$PATH:/usr/local/bin:/Users/Cypher/Library/Haskell/bin"
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=yellow"
