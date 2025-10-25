#!/usr/bin/env bash

pkill polybar
polybar main 2>/dev/null &

echo "Polybar launched..."
