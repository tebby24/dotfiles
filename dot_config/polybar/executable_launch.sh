#!/usr/bin/env bash

# Terminate already running bar instances
# NOTE: The command 'killall -q polybar' is the "nuclear" option.
# If you have IPC enabled, 'polybar-msg cmd quit' is cleaner.
killall -q polybar

# Wait until the processes have been shut down
while pgrep -x polybar >/dev/null; do sleep 1; done

# Launch the bar(s)
# Replace 'example' with the name of the bar defined in your config.ini (e.g., [bar/top])
# If you have multiple bars/monitors, you may need a loop here (see ArchWiki for multi-monitor setup).
polybar main &

echo "Polybar launched..."
