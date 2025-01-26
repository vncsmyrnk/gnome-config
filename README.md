# My gnome config

This is my local config for [gnome](https://www.gnome.org/).

## Install

This project uses [just](https://github.com/casey/just) for the installation.

```bash
just install
```

Considering `gnome-shell-extension-manager` is already installed, you can just run:

```bash
just config
```

For applying the configuration files only without cloning the repo:

```bash
curl -sSL https://raw.githubusercontent.com/vncsmyrnk/gnome-config/refs/heads/main/keybindings.conf | dconf load /
```

```bash
curl -sSL https://raw.githubusercontent.com/vncsmyrnk/gnome-config/refs/heads/main/interface.conf | dconf load /
```

> [!WARNING]
> Make sure to read the configuration files before applying them, be sure to know what you're doing.
