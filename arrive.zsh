#!/usr/bin/zsh

setup() {
    NAME=$1; ENTRY=$2; CMD=$3
    [[ -e "$ENTRY" ]] && return
    echo "$NAME is missing"
    [[ -z "$CMD" ]] && return
    sh -c "$CMD" # TODO ask for confirmation or exit
}

dotfile() {
    NAME=$1; ENTRY="${HOME}/.${NAME}"
    setup "${NAME}" "${ENTRY}" "ln -s ${HOME}/.config/${NAME} ${ENTRY}"
}

load() {
    NAME=$1; ENTRY=$2; CMD=$3
    setup "$NAME" "$ENTRY" "$CMD"
    [[ -e "${ENTRY}" ]] && source "$ENTRY"
}

repos=()

git_repo() {
    NAME=$1; REPO=$2; DIR="${3:-$HOME/$NAME}"
    repos+=($DIR)
    setup ${NAME} ${DIR} "git clone $REPO $DIR"
    # TODO: if existing warn if there are updates
}

check_repos() {
  for dir in $repos; do
    echo $dir
    (
      cd $dir
      git fetch
      git pull --rebase --no-ff
    ) &
  done
  wait
}

github() {
    USER=$1; REPO=$2; DIR="${3:-$HOME/$REPO}"
    git_repo ${REPO} "git@github.com:${USER}/${REPO}.git" ${DIR}
}

path() {
  echo "$PATH" | grep -q "$1" || export PATH="${PATH}:$1"
}

pkg_man() {
  type pkg >/dev/null 2>&1 && echo "pkg install -y" && return
  type dnf >/dev/null 2>&1 && echo "sudo dnf install" && return
  type pt >/dev/null 2>&1 && echo "sudo apt update && sudo apt install -y -f" && return
  type pacman >/dev/null 2>&1 && echo "sudo pacman -Syyu" && return
  echo "No package manager found" > /dev/stderr && exit 1
}

PKG_MAN=$(pkg_man)
program() {
  PROG=$1; PKG=${2:-$1}
  setup $PKG "$(which $PROG)" "$PKG_MAN $PKG"
}
