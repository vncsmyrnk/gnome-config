os := `cat /etc/os-release | grep "^NAME=" | cut -d "=" -f2 | tr -d '"'`

default:
  just --list

dconf-show:
 dconf dump / > /tmp/dconf/user.conf
 cat /tmp/dconf/user.conf

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
  i

install: install-extensions-manager

config: dconf-apply

unset-config: dconf-reset-keybindings
