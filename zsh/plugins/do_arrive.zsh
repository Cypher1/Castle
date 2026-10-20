#!/usr/bin/zsh

function is-laptop() {
  [[ $OSTYPE != linux-android ]]
}

function do_arrive_packages() {
  local PKG_MAN=$(pkg_man)

  program git-lfs
  program zsh
  program nvim neovim
  program python3
  program pyenv
  program luarocks
  program hyperfine
  program mosh
  program autojump
  if is-laptop; then
    program kitty
    program rustup
  fi
  program sccache
  crate bat
  crate bacon
  crate cargo-nextest
  crate cog cocogitto
  crate "${_ZSH_PATINA_PATH:-zsh-patina}" zsh-patina
  crontab "${HOME}/.config/crontab" 1> /dev/null
}

function do_arrive_configs() {
  if [[ ! -n $ZDOTDIR ]]; then
    echo "Setting ZDOTDIR" 2> /dev/stderr
    if [[ -e "${PREFIX}/etc/zshrc" ]]; then
      cat "${HOME}/.config/zsh/bootstrap" | sudo tee -a "${PREFIX}/etc/zshrc"
    fi
    if [[ -e "${PREFIX}/etc/zsh/zshrc" ]]; then
      cat "${HOME}/.config/zsh/bootstrap" | sudo tee -a "${PREFIX}/etc/zsh/zshrc"
    fi
  fi

  link "${HOME}/.cache/antidote/github.com" "${HOME}/src"

  link "${HOME}/src/compilersEllie/nvim_config" "${HOME}/.config/nvim"
  link "${HOME}/.config/cargo/config.toml" "${HOME}/.cache/cargo/config.toml"
  link "${ANTIDOTE_HOME}" "${HOME}/src/mattmc3/antidote"
  pyenv init > "${PYENV_HOME}/completions/pyenv.zsh"
  dotfile termux
}

function do_arrive_antidote() {
  # Remove the plugin file so antidote installs
  rm -f ${HOME}/.config/zsh/plugins.zsh

  repo "antidote" "https://github.com/mattmc3/antidote" "${ANTIDOTE_HOME}"
  source "${ANTIDOTE_HOME}/antidote.zsh"
}

function do_arrive() {
  # Setup our config & repos
  do_arrive_antidote
  do_arrive_configs
  do_arrive_packages
}
