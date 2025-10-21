#!/bin/bash

cat "$HOME/packages.txt" | xargs sudo pacman -S --needed --noconfirm
