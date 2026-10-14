#!/usr/bin/env bash

killall -q polybar

# Find the primary monitor.
MONITOR="$(xrandr --query | awk '$2 == "connected" && $3 == "primary" {print $1; exit}')"

# Fall back to the first connected monitor if none is marked primary.
if [[ -z "$MONITOR" ]]; then
    MONITOR="$(xrandr --query | awk '$2 == "connected" {print $1; exit}')"
fi

MONITOR="$MONITOR" polybar -c "$HOME/.config/polybar/config.ini" main &

echo "Polybar launched on $MONITOR"
