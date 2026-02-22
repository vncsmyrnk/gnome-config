os := `cat /etc/os-release | grep "^NAME=" | cut -d "=" -f2 | tr -d '"'`

on_update_scripts_path := "${SU_SCRIPTS_ON_UPDATE_PATH:-$HOME/.config/util/scripts/on-update}"

default:
  just --list

dconf-show:
  dconf dump / > /tmp/user.conf
  cat /tmp/user.conf

dconf-apply:
  dconf load / < keybindings.conf
  dconf load / < interface.conf
  dconf load / < shell.conf
  dconf load / < power.conf
  dconf load / < defaults.conf

dconf-apply-ubuntu:
  dconf load / < ubuntu-general.conf

dconf-reset-keybindings:
  dconf reset -f /org/gnome/desktop/wm/keybindings/
  dconf reset -f /org/gnome/desktop/wm/keybindings/
  dconf reset -f /org/gnome/mutter/keybindings/
  dconf reset -f /org/gnome/settings-daemon/plugins/media-keys/

dconf-reset-all:
  dconf reset -f /org/gnome/desktop/interface/
  dconf reset -f /org/gnome/desktop/wm/keybindings/
  dconf reset -f /org/gnome/mutter/keybindings/
  dconf reset -f /org/gnome/settings-daemon/plugins/media-keys/
  dconf reset -f /org/gnome/shell/

install-window-calls-extension:
  curl -L https://extensions.gnome.org/extension-data/window-callsdomandoman.xyz.v20.shell-extension.zip -o /tmp/window-call-extension.zip
  gnome-extensions install /tmp/window-call-extension.zip
  gnome-extensions enable window-calls@domandoman.xyz

config-scripts:
  stow -t {{on_update_scripts_path}} scripts

unset-config-scripts:
  stow -D -t {{on_update_scripts_path}} scripts

config-bin:
  stow -t "$HOME/.local/bin" bin --no-folding

unset-config-bin:
  stow -D -t "$HOME/.local/bin" bin

install-argos:
  #!/bin/sh
  [ -d /usr/local/stow/argos ] || {
    rm -rf /tmp/argos
    git clone https://github.com/p-e-w/argos /tmp/argos
    mkdir -p /usr/local/stow/argos
    sudo cp -r /tmp/argos/* /usr/local/stow/argos
  }
  mkdir -p ~/.local/share/gnome-shell/extensions
  stow -t ~/.local/share/gnome-shell/extensions -d /usr/local/stow argos --ignore=README

install-extensions-manager:
  #!/bin/bash
  if [ "{{os}}" = "Debian GNU/Linux" ] || [ "{{os}}" = "Ubuntu" ]; then
    sudo apt-get install gnome-shell-extension-manager
  elif [ "{{os}}" = "Arch Linux" ]; then
    sudo pacman -S extension-manager
  fi

install-font:
  #!/bin/bash
  FONT_PATH=/usr/local/share/fonts/adwaita
  if [ -d  $FONT_PATH ]; then
    echo "Already installed at $FONT_PATH"
    exit 0
  fi
  mkdir -p /tmp/adwaita
  sudo mkdir -p $FONT_PATH
  curl -L --output-dir /tmp https://download.gnome.org/sources/adwaita-fonts/48/adwaita-fonts-48.2.tar.xz -o adwaita.tar.xz
  tar -xvf /tmp/adwaita.tar.xz --one-top-level=/tmp/adwaita
  find /tmp/adwaita \
    -iname "*.ttf" \
    -exec sudo cp {} $FONT_PATH \;

install: install-extensions-manager install-window-calls-extension install-argos

config: dconf-apply config-scripts config-bin

unset-config: dconf-reset-all unset-config-scripts
