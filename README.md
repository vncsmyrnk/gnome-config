[![GitHub main branch check runs](https://img.shields.io/github/check-runs/vncsmyrnk/gnome-config/main?style=plastic&logo=github&label=CI%20workflow)](https://github.com/vncsmyrnk/gnome-config/actions/workflows/ci.yaml)

This is my local config for [GNOME](https://www.gnome.org/).

## Install

```bash
autoreconf -fi
./configure --prefix=$HOME/.local # optionals available
make install
./dconf-load.sh
```

> [!WARNING]
> Make sure to read the configuration files before applying them, be sure to know what you're doing.
