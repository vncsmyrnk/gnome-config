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
  dconf reset -f /org/gnome/mutter/keybindings/
  dconf reset -f /org/gnome/settings-daemon/plugins/media-keys/

dconf-reset-all:
  dconf reset -f /org/gnome/desktop/interface/
  dconf reset -f /org/gnome/desktop/wm/keybindings/
  dconf reset -f /org/gnome/mutter/keybindings/
  dconf reset -f /org/gnome/settings-daemon/plugins/media-keys/
  dconf reset -f /org/gnome/shell/

install-window-calls-extension:
  @./extensions/window-calls/install.sh

install-argos-extension:
  @./extensions/argos/install.sh

install-extensions-manager:
  #!/bin/bash
  if [ "{{os}}" = "Debian GNU/Linux" ] || [ "{{os}}" = "Ubuntu" ]; then
    sudo apt-get install gnome-shell-extension-manager
  elif [ "{{os}}" = "Arch Linux" ]; then
    sudo pacman -S extension-manager
  fi

install-adwaita-font:
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

install: install-extensions-manager install-window-calls-extension install-argos-extension install-adwaita-font config

config: dconf-apply
  stow -t "$HOME/.local/bin" bin --no-folding
  rm -rf "{{on_update_scripts_path}}/update-argos.sh"
  ln -s extensions/argos/update.sh "{{on_update_scripts_path}}/update-argos.sh"

unset-config: dconf-reset-all
  stow -D -t "$HOME/.local/bin" bin --no-folding
  rm -rf "{{on_update_scripts_path}}/update-argos.sh"
