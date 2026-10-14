export PYENV_SHELL=zsh
source "${PYENV_HOME}/completions/pyenv.zsh"
if [[ ! -o interactive ]]; then
    compctl -K _pyenv pyenv
fi
command pyenv rehash
