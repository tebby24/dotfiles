#!/bin/bash
set -e

PKG_FILE="$HOME/packages.txt"

# Strip comments and empty lines, then pass to pacman -T
mapfile -t candidates < <(grep -vE '^\s*(#|$)' "$PKG_FILE")

# pacman -T returns the list of missing packages
missing=($(pacman -T "${candidates[@]}"))

if (( ${#missing[@]} > 0 )); then
    echo "Installing missing: ${missing[*]}"
    sudo pacman -S --needed --noconfirm "${missing[@]}"
else
    echo "All packages and groups are satisfied."
fi
