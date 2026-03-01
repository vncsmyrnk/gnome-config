os := `cat /etc/os-release | grep "^NAME=" | cut -d "=" -f2 | tr -d '"'`

default:
  just --list

dconf-show:
  dconf dump / | tee /tmp/user.conf

dconf-apply:
  find dconf | xargs -I{} sh -c 'dconf load / < {}'

dconf-apply-ubuntu:
  dconf load / < dconf/ubuntu-general.conf

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

install-extensions-manager:
  #!/bin/bash
  if [ "{{os}}" = "Debian GNU/Linux" ] || [ "{{os}}" = "Ubuntu" ]; then
    sudo apt-get install gnome-shell-extension-manager
  elif [ "{{os}}" = "Arch Linux" ]; then
    sudo pacman -S extension-manager
  fi

install-extensions:
  cd extensions && nix run .#

update-extensions:
  cd extensions && nix flake update && nix run .#

clear-extensions:
  rm -rf ~/.local/share/gnome-shell/extensions

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

install: install-extensions install-extensions-manager install-adwaita-font config

config: dconf-apply
  stow -t "$HOME/.local/bin" bin --no-folding

unset-config: dconf-reset-all
