#!/bin/bash
set -e

# Path to package list
PKG_FILE="$HOME/packages.txt"

# Find packages that are not yet installed
missing=()
while read -r pkg; do
    [[ -z "$pkg" || "$pkg" =~ ^# ]] && continue  # skip empty lines and comments
    if ! pacman -Q "$pkg" &>/dev/null; then
        missing+=("$pkg")
    fi
done < "$PKG_FILE"

# Only call sudo if something is actually missing
if (( ${#missing[@]} > 0 )); then
    echo "Installing missing packages: ${missing[*]}"
    sudo pacman -S --needed --noconfirm "${missing[@]}"
else
    echo "All packages already installed."
fi
