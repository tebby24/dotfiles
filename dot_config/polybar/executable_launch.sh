#!/usr/bin/env bash
killall -q polybar
MONITOR="$(xrandr --query | awk '$2 == "connected" {print $1; exit}')"
MONITOR="$MONITOR" polybar main &
echo "Polybar launched..."
