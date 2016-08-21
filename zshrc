DEFAULT_USER="cypher"
export ZSH=/Users/Cypher/.oh-my-zsh

ZSH_THEME="bullet-train"
BULLETTRAIN_STATUS_EXIT_SHOW=true
BULLETTRAIN_PROMPT_ADD_NEWLINE=false
BULLETTRAIN_VIRTUALENV_SHOW=true
BULLETTRAIN_TIME_SHOW=false
BULLETTRAIN_EXEC_TIME=true
BULLETTRAIN_GIT_DIRTY_BG=yellow
BULLETTRAIN_GIT_BG=green
BULLETTRAIN_DIR_FG=black
BULLETTRAIN_GIT_DIRTY_FG=black
BULLETTRAIN_GIT_FG=black
BULLETTRAIN_PROMPT_CHAR=""

plugins=(sudo z gitfast last-working-dir pip cabal gem jsontools zsh-completions django)
source $ZSH/oh-my-zsh.sh
export KEYTIMEOUT=1

# CHANGING DEFAULTS
alias reboot="sudo reboot"
alias shutdown="sudo shutdown -h now"
alias cp="cp -r"
alias rm="rm -r"
alias grep="egrep --color=always"
VISUAL="nvim"
alias vi="nvim -O"
alias vim="nvim -O"
alias ghct="ghc -Wall -O2 -threaded -rtsopts -with-rtsopts='-N4'"
alias ghc="ghc -Wall"
alias g++="g++ -std=c++14 -Wall -Werror -O2"

# ADDITIONS
alias zsh_upgrade="zsh ~/.oh-my-zsh/tools/upgrade.sh"
alias zrc="vim ~/.zshrc"
alias vrc="vim ~/.config/nvim/init.vim"
alias .="clear && cd ."
alias ..="clear && cd .."
alias q="exit"
alias u="du -hs *"
alias -s py='python'
alias server="python -m SimpleHTTPServer"

function mk { mkdir $1; cd $1; }
function clean {
    rm *.pyc;
    rm *.o;
    rm *.class;
    rm *.hi;
    rm nohup.out;
    clear;
}

# GIT COMMANDS
alias -s git='git clone'
alias s="git status -sb || ls"
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

source /usr/local/opt/autoenv/activate.sh
function cd {
    autoenv_cd "$@"
    chpwd_last_working_dir "$@"
    ls -FG | grep -v '\.o$' | grep -v '\.hi$' | grep -v '\.pyc$'
}
