#!/bin/bash
set -euo pipefail

PKG_FILE="$HOME/packages.txt"

# Build a fast lookup table of installed packages
declare -A installed
while read -r pkg; do
    installed["$pkg"]=1
done < <(pacman -Qq)

missing=()

while read -r pkg; do
    [[ -z "$pkg" || "$pkg" =~ ^# ]] && continue

    if [[ -z "${installed[$pkg]+x}" ]]; then
        missing+=("$pkg")
    fi
done < "$PKG_FILE"

if (( ${#missing[@]} > 0 )); then
    echo "Installing missing packages: ${missing[*]}"
    sudo pacman -S --needed --noconfirm "${missing[@]}"
else
    echo "All packages already installed."
fi
