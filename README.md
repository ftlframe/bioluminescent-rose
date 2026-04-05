# Bioluminescent Rose

A pastel pink Sway rice built for readability on pure black. Portable dotfiles bundle for Ubuntu (apt) and Fedora (dnf).

## Screenshots

TODO

## What's included

| Component | Config path | Description |
|-----------|------------|-------------|
| Sway | `config/sway/` | Tiling WM — vim keybinds, autotiling, gaps, thin borders (stock sway, no swayfx) |
| Waybar | `config/waybar/` | Dual bar — top (clock, network, bluetooth, audio, battery, power menu) + bottom (workspaces, media, tray) |
| Rofi | `config/rofi/` | App launcher (drun mode, 3-column grid) |
| swaync | `config/swaync/` | Notification center |
| Clipse | `config/clipse/` | TUI clipboard manager |
| Fish | `config/fish/` | Shell config with auto-tmux |
| Starship | `config/starship.toml` | Minimal prompt |
| Ghostty | `config/ghostty/` | Terminal emulator |
| tmux | `config/tmux/` | Terminal multiplexer — Ctrl+Space prefix, vim keybinds |
| Neovim | `config/nvim/` | Theme overlay only — palette, highlights, colorscheme plugin (bring your own LazyVim) |
| Fonts | `fonts/` | JetBrainsMono Nerd Font + Material Symbols (bundled) |

## Color palette (Bioluminescent Rose)

Tri-tone pink scale designed to maximize readability on `#000000`:

| Role | Hex | Usage |
|------|-----|-------|
| Background | `#000000` | Pure black — OLED friendly |
| Vivid Pink | `#ff8fb1` | Keywords, functions, borders, accents |
| Pastel Rose | `#ffcfdf` | Strings, numbers, data literals |
| Lavender White | `#e0def4` | Body text, variables |
| Iris | `#c4a7e7` | Types, classes |
| Gold | `#f6c177` | Warnings |
| Love | `#eb6f92` | Errors, urgent |
| Foam | `#9ccfd8` | Links, redirections |
| Pine | `#31748f` | Search highlights |
| Muted | `#6e6a86` | Comments, dim text |
| Surface | `#191724` | UI overlays, gutter |

## Install

```bash
git clone <this-repo>
cd bioluminescent-rose
./dotfiles.sh
```

The installer will:
1. Detect your package manager (apt or dnf)
2. Install all dependencies
3. Back up existing configs to `~/.config/backup-pre-biorose-<date>/`
4. Copy all configs to `~/.config/`
5. Install fonts and starship if missing
6. Overlay the nvim theme (non-destructive — only writes theme files)
7. Optionally set fish as your default shell

## Post-install

1. **Monitors** — create `~/.config/sway/displays.conf` for your setup:
   ```
   output eDP-1 pos 0 0 res 1920x1080
   workspace 1 output eDP-1
   ```

2. **Wallpaper** — place an image at `~/Pictures/wallpapers/flower.jpg`

3. **Neovim** — the installer only drops the theme files. You need LazyVim installed separately. The colorscheme plugin expects `rose-pine` as the base with custom highlight overrides from `lua/theme/`.

4. **Log out** and select **Sway** from your display manager.

## Dependencies

Installed automatically by `dotfiles.sh`:

**Core:**
- `sway` — Wayland compositor (stock, no swayfx required)
- `waybar` — status bar
- `rofi` — app launcher
- `wlogout` — power menu
- `swaync` — notification center
- `swaylock` — lock screen
- `swayidle` — idle manager

**Terminal/Shell:**
- `ghostty` — terminal emulator (manual install, not in repos)
- `fish` — shell
- `starship` — prompt (bundled binary as fallback)
- `tmux` — terminal multiplexer

**Utilities:**
- `clipse` — clipboard manager (manual install, not in repos)
- `playerctl` — media control
- `pavucontrol` — audio GUI
- `grim` + `slurp` — screenshots
- `flameshot` — screenshot annotation
- `wl-clipboard` — Wayland clipboard
- `eza` — modern ls
- `autotiling` — automatic tiling direction

**Fonts:**
- JetBrainsMono Nerd Font — bundled in `fonts/`
- Material Symbols Outlined — bundled in `fonts/`

## Keybinds

Press `Super+/` for the full searchable cheatsheet in rofi.

| Bind | Action |
|------|--------|
| `Super+Enter` | Terminal (ghostty) |
| `Super+d` | App launcher (rofi) |
| `Super+q` | Kill window |
| `Super+p` | Power menu (wlogout) |
| `Super+e` | File explorer (ranger) |
| `Super+c` | Clipboard (clipse) |
| `Super+n` | Notification center |
| `Super+Shift+n` | Close all notifications |
| `Super+/` | Keybind cheatsheet |
| `Super+f` | Fullscreen |
| `Super+hjkl` | Focus left/down/up/right |
| `Super+Shift+hjkl` | Move window |
| `Super+Ctrl+hjkl` | Resize (30px) |
| `Super+Ctrl+Shift+hjkl` | Resize fast (100px) |
| `Super+r` | Enter resize mode |
| `Super+1-0` | Switch workspace |
| `Super+Shift+1-0` | Move to workspace |
| `Super+[` / `]` | Prev/next workspace |
| `Super+x` | Toggle last workspace |
| `Super+Shift+Space` | Toggle floating |
| `Super+Space` | Toggle focus (tile/float) |
| `Super+b` / `v` | Split horizontal/vertical |
| `Super+s` / `w` / `t` | Stacking/tabbed/toggle split |
| `Super+Shift+c` | Reload config |
| `Super+Shift+e` | Exit sway |
| `Print` | Screenshot (flameshot) |
| Mouse side buttons | Prev/next workspace |
| `Super+scroll` | Prev/next workspace |

## Notes

- Ghostty and clipse must be installed manually — they're not in Ubuntu or Fedora repos
- `autotiling` is a Python package: `pip install autotiling`
- The sway config uses `include ~/.config/sway/displays.conf` — create this file for your monitor layout
- The nvim theme is an overlay, not a full config — it expects LazyVim with rose-pine installed
- No swayfx or swayr dependencies — works on stock sway
