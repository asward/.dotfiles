#!/bin/sh

# Get volume and mute status
volume=$(pactl get-sink-volume @DEFAULT_SINK@ | grep -oP '\d+%' | head -1 | tr -d '%')
muted=$(pactl get-sink-mute @DEFAULT_SINK@ | grep -o 'yes\|no')

# Get sink info for device type
sink_info=$(pactl info | grep "Default Sink" | cut -d' ' -f3)
device_name=$(pactl list sinks | grep -A 20 "$sink_info" | grep "device.description" | cut -d'"' -f2)

# Determine icon based on volume and device
if [ "$muted" = "yes" ]; then
    icon="󰝟"
    class="muted"
    text="󰝟"
else
    # Choose volume icon
    if [ "$volume" -le 33 ]; then
        icon="󰕿"
    elif [ "$volume" -le 66 ]; then
        icon="󰖀"
    else
        icon="󰕾"
    fi
    
    # Check for specific device types
    if echo "$device_name" | grep -qi "headphone\|headset"; then
        icon="󰋋"
    elif echo "$device_name" | grep -qi "bluetooth"; then
        icon="󰋋 󰂯"
        class="bluetooth"
    fi
    
    text="${icon}"
    class="normal"
fi

# Output JSON
echo "{\"text\":\"$text\",\"tooltip\":\"Device: $device_name\\nVolume: $volume%\",\"class\":\"$class\"}"
