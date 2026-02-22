#!/usr/bin/env bash

STOW_PATH=/usr/local/stow
ARGOS_INSTALL_PATH="$STOW_PATH/argos"
GNOME_EXTENSIONS_PATH="$HOME/.local/share/gnome-shell/extensions"

main() {
  rm -rf /tmp/argos
  git clone https://github.com/p-e-w/argos /tmp/argos
  sudo mkdir -p "$ARGOS_INSTALL_PATH"
  sudo cp -r /tmp/argos/* "$ARGOS_INSTALL_PATH"

  mkdir -p "$GNOME_EXTENSIONS_PATH"
  stow -t "$GNOME_EXTENSIONS_PATH" -d "$STOW_PATH" argos --ignore=README
  gnome-extensions enable window-calls@domandoman.xyz

  echo "Restart the session and enable the extension manually if needed."
}

main
