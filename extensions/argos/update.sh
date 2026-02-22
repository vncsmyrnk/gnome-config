#!/usr/bin/env bash

ARGOS_STOW_PATH=/usr/local/stow/argos

main() {
  [ -d $ARGOS_STOW_PATH ] || {
    echo "argos not manually installed"
    exit 0
  }

  cd "$ARGOS_STOW_PATH" || exit
  current_commit=$(git rev-parse HEAD)
  last_commit=$(
    git ls-remote |
      grep 'refs/heads/master' |
      head -n 1 |
      awk '{ print $1 }'
  )

  [ -z "$last_commit" ] && {
    echo "failed to fetch for updates using git ls-remote"
    exit 1
  }

  [ "$last_commit" = "$current_commit" ] && {
    echo "argos already has the newest updates"
    exit 0
  }

  echo "New updates found. Updating argos..."
  sudo git checkout master
  sudo git pull
}

main
