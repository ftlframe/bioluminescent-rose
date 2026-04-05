#!/usr/bin/env bash
set -euo pipefail

# Bioluminescent Rose — Sway rice installer
# Usage: ./dotfiles.sh
# Skips packages and configs that already exist.

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BACKUP_DIR="$HOME/.config/backup-pre-biorose-$(date +%Y-%m-%d)"

echo "=== Bioluminescent Rose — Sway Rice Installer ==="
echo ""

# --- Detect distro ---
if command -v apt &>/dev/null; then
    PKG_MGR="apt"
elif command -v dnf &>/dev/null; then
    PKG_MGR="dnf"
else
    echo "Unsupported package manager. Only apt (Ubuntu/Debian) and dnf (Fedora) are supported."
    exit 1
fi

echo "Detected package manager: $PKG_MGR"

# --- Helper: check if a package is installed ---
pkg_installed() {
    if [ "$PKG_MGR" = "apt" ]; then
        dpkg -s "$1" &>/dev/null
    elif [ "$PKG_MGR" = "dnf" ]; then
        rpm -q "$1" &>/dev/null
    fi
}

# --- Install packages ---
echo ""
echo "=== Installing packages ==="

if [ "$PKG_MGR" = "apt" ]; then
    PKGS=(
        sway sway-notification-center swaylock swayidle
        waybar rofi wlogout fish tmux
        playerctl pavucontrol
        grim slurp wl-clipboard
        eza jq blueman network-manager-gnome flameshot
    )

    MISSING=()
    for pkg in "${PKGS[@]}"; do
        if ! pkg_installed "$pkg"; then
            MISSING+=("$pkg")
        fi
    done

    if [ ${#MISSING[@]} -gt 0 ]; then
        echo "  Installing: ${MISSING[*]}"
        sudo apt update
        sudo apt install -y "${MISSING[@]}"
    else
        echo "  All packages already installed, skipping"
    fi

    # autotiling — Python package, not in apt
    if ! command -v autotiling &>/dev/null; then
        if command -v pip3 &>/dev/null; then
            pip3 install --user autotiling
        else
            echo "NOTE: Install autotiling manually: pip3 install autotiling"
        fi
    fi

    # clipse — not in Ubuntu repos
    if ! command -v clipse &>/dev/null; then
        echo "NOTE: clipse is not in Ubuntu repos."
        echo "Install from: https://github.com/savedra1/clipse/releases"
    fi

    # Ghostty
    if ! command -v ghostty &>/dev/null; then
        echo "NOTE: Ghostty is not in Ubuntu repos."
        echo "Install from: https://ghostty.org/download"
    fi

elif [ "$PKG_MGR" = "dnf" ]; then
    PKGS=(
        sway swaync swaylock swayidle
        waybar rofi wlogout fish tmux
        playerctl pavucontrol
        grim slurp wl-clipboard
        eza jq blueman NetworkManager-tui flameshot
    )

    MISSING=()
    for pkg in "${PKGS[@]}"; do
        if ! pkg_installed "$pkg"; then
            MISSING+=("$pkg")
        fi
    done

    if [ ${#MISSING[@]} -gt 0 ]; then
        echo "  Installing: ${MISSING[*]}"
        sudo dnf install -y "${MISSING[@]}"
    else
        echo "  All packages already installed, skipping"
    fi

    if ! command -v autotiling &>/dev/null; then
        echo "NOTE: Install autotiling via pip: pip install autotiling"
    fi

    if ! command -v clipse &>/dev/null; then
        echo "NOTE: Install clipse from: https://github.com/savedra1/clipse/releases"
    fi

    if ! command -v ghostty &>/dev/null; then
        echo "NOTE: Install ghostty separately (COPR or from source)."
    fi
fi

# --- Fonts ---
if fc-list | grep -qi "JetBrainsMono Nerd"; then
    echo "  Fonts already installed, skipping"
else
    echo ""
    echo "=== Installing JetBrains Mono Nerd Font ==="
    mkdir -p ~/.local/share/fonts
    cp "$SCRIPT_DIR/fonts/"*.ttf ~/.local/share/fonts/
    fc-cache -f
    echo "  Font installed"
fi

# --- Starship ---
if command -v starship &>/dev/null; then
    echo "  Starship already installed, skipping"
else
    echo ""
    echo "=== Installing starship ==="
    sudo install -m 755 "$SCRIPT_DIR/bin/starship" /usr/local/bin/starship
    echo "  Starship installed"
fi

# --- Backup existing configs ---
echo ""
echo "=== Backing up existing configs to $BACKUP_DIR ==="

BACKED_UP=0
for dir in sway waybar rofi swaync fish ghostty tmux clipse; do
    if [ -d "$HOME/.config/$dir" ]; then
        mkdir -p "$BACKUP_DIR"
        cp -r "$HOME/.config/$dir" "$BACKUP_DIR/"
        echo "  Backed up $dir"
        BACKED_UP=1
    fi
done
if [ -f "$HOME/.config/starship.toml" ]; then
    mkdir -p "$BACKUP_DIR"
    cp "$HOME/.config/starship.toml" "$BACKUP_DIR/"
    BACKED_UP=1
fi
if [ "$BACKED_UP" -eq 0 ]; then
    echo "  Nothing to back up"
fi

# --- Copy configs ---
echo ""
echo "=== Installing configs ==="

for dir in sway waybar rofi swaync fish ghostty tmux clipse; do
    if [ -d "$SCRIPT_DIR/config/$dir" ]; then
        mkdir -p "$HOME/.config/$dir"
        cp -r "$SCRIPT_DIR/config/$dir/." "$HOME/.config/$dir/"
        echo "  Installed $dir"
    fi
done

# Starship config
if [ -f "$SCRIPT_DIR/config/starship.toml" ]; then
    cp "$SCRIPT_DIR/config/starship.toml" "$HOME/.config/starship.toml"
    echo "  Installed starship.toml"
fi

# Nvim theme overlay (non-destructive — only writes theme files)
if [ -d "$SCRIPT_DIR/config/nvim" ]; then
    mkdir -p "$HOME/.config/nvim/lua/theme"
    mkdir -p "$HOME/.config/nvim/lua/plugins"
    cp "$SCRIPT_DIR/config/nvim/lua/theme/palette.lua" "$HOME/.config/nvim/lua/theme/"
    cp "$SCRIPT_DIR/config/nvim/lua/theme/highlights.lua" "$HOME/.config/nvim/lua/theme/"
    cp "$SCRIPT_DIR/config/nvim/lua/plugins/colorscheme.lua" "$HOME/.config/nvim/lua/plugins/"
    echo "  Installed nvim theme (palette + highlights + colorscheme plugin)"
fi

# Ensure scripts are executable
chmod +x "$HOME/.config/sway/keybinds.sh" "$HOME/.config/sway/volume-up.sh" "$HOME/.config/waybar/mediaplayer.sh" 2>/dev/null

# --- Wallpaper ---
if [ -f "$HOME/Pictures/wallpapers/flower.jpg" ]; then
    echo "  Wallpaper already exists, skipping"
elif [ -f "$SCRIPT_DIR/wallpaper.jpg" ]; then
    echo ""
    echo "=== Installing wallpaper ==="
    mkdir -p "$HOME/Pictures/wallpapers"
    cp "$SCRIPT_DIR/wallpaper.jpg" "$HOME/Pictures/wallpapers/flower.jpg"
    echo "  Installed wallpaper"
fi

# --- Set fish as default shell ---
if command -v fish &>/dev/null; then
    FISH_PATH="$(command -v fish)"
    if [ "$SHELL" != "$FISH_PATH" ]; then
        echo ""
        read -p "Set fish as default shell? [y/N] " -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            if ! grep -q "$FISH_PATH" /etc/shells; then
                echo "$FISH_PATH" | sudo tee -a /etc/shells
            fi
            chsh -s "$FISH_PATH"
            echo "  Default shell set to fish"
        fi
    fi
fi

echo ""
echo "=== Done! ==="
echo ""
echo "Next steps:"
echo "  1. Edit ~/.config/sway/displays.conf for your monitor setup"
echo "  2. Log out and select 'Sway' from your display manager"
echo ""
echo "Keybinds: Super+Enter (terminal), Super+d (launcher), Super+/ (cheatsheet)"
