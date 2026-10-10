#!/bin/bash
set -e

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_DIR="$HOME/.config"

echo "Installing dependencies..."
sudo pacman -Syu --needed --noconfirm \
    hyprland hyprlock hypridle waybar neovim ly git base-devel \
    cmatrix kitty rofi pavucontrol grim slurp brightnessctl btop hyprpaper pipewire wireplumber \
    pipewire-audio pipewire-pulse ttf-jetbrains-mono-nerd polkit-kde-agent

echo "Installing user configs..."
mkdir -p "$CONFIG_DIR"
cp -r "$REPO_DIR/hypr" "$CONFIG_DIR/" 2>/dev/null || true
cp -r "$REPO_DIR/waybar" "$CONFIG_DIR/" 2>/dev/null || true
cp -r "$REPO_DIR/nvim" "$CONFIG_DIR/" 2>/dev/null || true

if [ -f "$REPO_DIR/ly/config.ini" ]; then
    echo "Installing Ly config..."
    sudo mkdir -p /etc/ly
    sudo cp "$REPO_DIR/ly/config.ini" /etc/ly/config.ini
    sudo systemctl enable ly.service --force
fi

echo "Done! Reboot to start Ly."
