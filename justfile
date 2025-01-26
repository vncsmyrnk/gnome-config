default:
  just --list

dconf-show:
 dconf dump / > /tmp/dconf/user.conf
 cat /tmp/dconf/user.conf

dconf-apply:
  dconf load / < keybindings.conf
  dconf load / < general.conf

dconf-reset-keybindings:
  dconf reset /org/gnome/desktop/wm/keybindings/
