# My GNOME config

This is my local config for [GNOME](https://www.gnome.org/).

## Extensions

Due to GNOME not having a standard way of scripting the installation of extensions, Nix and its great community built a way to make the extension installation process reproducible. The _flake_ at [extensions](extensions) handles this.

## Install

This project uses [just](https://github.com/casey/just) and [Nix](https://nixos.org) for the installation.

```bash
just install
```

Considering the dependencies are already installed, you can just run:

```bash
just config
```

For applying the configuration files only without cloning the repo:

```bash
curl -sSL https://raw.githubusercontent.com/vncsmyrnk/gnome-config/refs/heads/main/dconf/keybindings.conf | dconf load /
```

```bash
curl -sSL https://raw.githubusercontent.com/vncsmyrnk/gnome-config/refs/heads/main/dconf/interface.conf | dconf load /
```

> [!WARNING]
> Make sure to read the configuration files before applying them, be sure to know what you're doing.
