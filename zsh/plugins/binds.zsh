bindkey -v

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

zle -N _nvim_mode
bindkey '^e' _nvim_mode

zle -N _sudobuf
bindkey '^[^[' _sudobuf

zle -N _ggrepconflict
bindkey '^G' _ggrepconflict

zle -N _ggrep
bindkey '^F' _ggrep

zle -N _restart_zsh
bindkey '^L' _restart_zsh
