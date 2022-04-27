# Setup fzf
# ---------
if [[ ! "$PATH" == */home/cypher/.fzf/bin* ]]; then
  export PATH="${PATH:+${PATH}:}/home/cypher/.fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/home/cypher/.fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "/home/cypher/.fzf/shell/key-bindings.zsh"
