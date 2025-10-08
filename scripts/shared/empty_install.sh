#!/usr/bin/env bash
set -e

echo "Starting system setup..."

sudo pacman -Syu --needed --noconfirm base-devel zsh alacritty tmux neovim

if ! command -v yay >/dev/null 2>&1; then
  mkdir -p ~/aur-builds && cd ~/aur-builds
  git clone https://aur.archlinux.org/yay.git
  cd yay
  makepkg -si --noconfirm
fi

if [[ "$SHELL" != "/bin/zsh" ]]; then
  chsh -s /bin/zsh
fi

chezmoi apply -v
echo "✅ Setup complete"

