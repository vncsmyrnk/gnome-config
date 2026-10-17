# Disabling nautilus localsearch

The package `localsearch` itself cannot be removed as it is a GNOME dependency, but it can be disabled:

```sh
systemctl --user stop localsearch-3.service localsearch-control-3.service localsearch-writeback-3.service
systemctl --user mask localsearch-3.service localsearch-control-3.service localsearch-writeback-3.service
```

## References

- [discourse.gnome.org/t/disable-tracker-localsearch-extract-in-silverblue/34652](https://discourse.gnome.org/t/disable-tracker-localsearch-extract-in-silverblue/34652)
- [bbs.archlinux.org/viewtopic.php?id=299586](https://bbs.archlinux.org/viewtopic.php?id=299586)
