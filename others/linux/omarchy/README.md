# Omarchy config backup

Taken 2026-10-10 on Omarchy 4.0.4-1.

- `config/`: plain copy of the desktop folders from `~/.config` (`*.bak` files left out)
- `omarchy-config-*.tar.gz`: full archive with `.bak` files (local only, not committed)
- `pkglist-explicit.txt`: explicitly installed packages (`pacman -Qqe`)

To restore: `rsync -a config/ ~/.config/`
