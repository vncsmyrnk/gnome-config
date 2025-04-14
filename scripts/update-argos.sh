#!/bin/sh

ARGOS_STOW_PATH=/usr/local/stow/argos

[ -d $ARGOS_STOW_PATH ] || {
  echo "argos not manually installed"
  exit 1
}

cd $ARGOS_STOW_PATH
sudo git pull
