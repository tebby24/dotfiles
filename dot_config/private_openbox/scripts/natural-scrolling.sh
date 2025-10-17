#!/bin/bash

# enable natural scrolling for all relevant devices
for dev in $(xinput list --name-only | grep -Ei 'mouse|touchpad'); do
    prop=$(xinput list-props "$dev" | grep -i "Natural Scrolling Enabled (" | sed -E 's/.*\((.*)\).*/\1/')
    if [ -n "$prop" ]; then
        xinput set-prop "$dev" "$prop" 1
    fi
done

