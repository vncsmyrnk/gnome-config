#!/usr/bin/env bash

curl -L https://extensions.gnome.org/extension-data/window-callsdomandoman.xyz.v20.shell-extension.zip -o /tmp/window-call-extension.zip
gnome-extensions install /tmp/window-call-extension.zip
gnome-extensions enable window-calls@domandoman.xyz
echo "Restart the session and enable the extension manually if needed."
