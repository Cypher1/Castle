# auto-update.sh - check for updates (to anything) regularly
#
# Can be used for things like checking if dotfiles repos have new changes, if
# package managers have updates, renewing credentials, etc.
#
# Author
#   Jake Zimmerman <jake@zimmerman.io>
#
# Usage
#   - Requires my colors.sh to have been sourced already for colorized output
#   - source this file to check if the "system is out of date" (i.e., hasn't
#     been updated in AUTO_UPDATE_UPDATE_THRESHOLD seconds)
#   - call `update` to run general update checks and checks defined by the
#     system
#     - define a function `update-host` and bind it to the environment before
#       calling update!
#
# Notes
#   This file will only check for updates every time it's sourced. It's meant
#   to be sourced in a bashrc or zshrc so that every time you open a new tab or
#   pane it reminds you if you haven't updated in a while. It neither checks
#   continuously for updates, nor fetches the updates themselves.
#
# TODOs
#   Maybe some day I'll turn this into a fully-configurable file, but for now
#   most things are hard coded.

case "$SOLARIZED" in
  dark)
    cemph="$cwhiteb"
    ;;
  light)
    cemph="$cgray"
    ;;
  *)
    cemph="$cwhiteb"
    ;;
esac

# Number of seconds to wait before printing a reminder
AUTO_UPDATE_UPDATE_THRESHOLD="86400"
AUTO_UPDATE_UPDATE_FILE="$HOME/.last_update"
AUTO_UPDATE_REPO="$HOME/.config"
AUTO_UPDATE_REMOTE="origin"
AUTO_UPDATE_BRANCH="main"

warn_update() {
    echo "$cred==>$cemph Your system is out of date!$cnone"
    echo 'Run `update` to bring it up to date.'
}

check_for_updates() {
  if [ ! -e $AUTO_UPDATE_UPDATE_FILE ]; then
    touch $AUTO_UPDATE_UPDATE_FILE
    warn_update
  fi
  # Initialize for when we have no GNU date available
  last_check=0
  time_now=0

  # Darwin uses BSD, check for gdate, else use date
  if [[ $(uname) = "Darwin" && -n $(which gdate) ]]; then
    last_login=$(gdate -r $AUTO_UPDATE_UPDATE_FILE +%s)
    time_now=$(gdate +%s)
  else
    # Ensure this is GNU grep
    if [ -n "$(date --version 2> /dev/null | grep GNU)" ]; then
      last_login=$(date -r $AUTO_UPDATE_UPDATE_FILE +%s)
      time_now=$(date +%s)
    fi
  fi

  time_since_check=$((time_now - last_login))

  if [ "$time_since_check" -ge "$AUTO_UPDATE_UPDATE_THRESHOLD" ]; then
    warn_update
  fi
}

check_for_updates

# update - fetch updates
# usage:
#   update
#
# You will likely also want to define a function `update-host` for each host
# that you will run `update` from. Ensure that this function is sourced before
# calling `update`.
update() {
  # Record that we've update
  touch $AUTO_UPDATE_UPDATE_FILE

  # --- Host-independent updates ---

  # Update dotfiles repo
  cd "$AUTO_UPDATE_REPO"
  echo "$cblueb==>$cemph Updating...$cnone"
  git fetch --quiet "$AUTO_UPDATE_REMOTE"
  if [ "$(git rev-parse HEAD)" != "$(git rev-parse $AUTO_UPDATE_REMOTE/$AUTO_UPDATE_BRANCH)" ]; then echo "$credb  --> outdated.$cnone"; fi

  # Update each submodule in the repo
  echo "$cblueb==>$cemph Checking for outdated submodules...$cnone"
  git submodule foreach --quiet 'git fetch --quiet && if [ "$(git rev-parse HEAD)" != "$(git rev-parse $AUTO_UPDATE_REMOTE/$AUTO_UPDATE_BRANCH)" ]; then echo $path; fi'
  cd - &> /dev/null

  # --- Host-dependent updates ---

  update-host
}
