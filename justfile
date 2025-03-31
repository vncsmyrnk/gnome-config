os := `cat /etc/os-release | grep "^NAME=" | cut -d "=" -f2 | tr -d '"'`

default:
  just --list

dconf-show:
  dconf dump / > /tmp/user.conf
  cat /tmp/user.conf

dconf-apply:
  dconf load / < keybindings.conf
  dconf load / < interface.conf

dconf-apply-ubuntu:
  dconf load / < ubuntu-general.conf

dconf-reset-keybindings:
  dconf reset /org/gnome/desktop/wm/keybindings/ /org/gnome/desktop/wm/keybindings/ \
    /org/gnome/mutter/keybindings/ /org/gnome/settings-daemon/plugins/media-keys/

dconf-reset-all:
  dconf reset /org/gnome/desktop/interface/ /org/gnome/desktop/wm/keybindings/ \
    /org/gnome/desktop/wm/keybindings/ /org/gnome/mutter/keybindings/ /org/gnome/settings-daemon/plugins/media-keys/

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

install: install-extensions-manager

config: dconf-apply

unset-config: dconf-reset-keybindings
