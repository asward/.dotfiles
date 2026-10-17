#!/bin/sh

# Thresholds
CPU_YELLOW=70
CPU_RED=90
RAM_YELLOW=80
RAM_RED=95
TEMP_YELLOW=70
TEMP_RED=85
DISK_YELLOW=80
DISK_RED=95

# Get system stats
CPU=$(top -bn1 | grep "Cpu(s)" | awk '{print int($2)}' | sed 's/%us,//')
RAM=$(free | grep Mem | awk '{printf "%.0f", ($3/$2) * 100.0}')
TEMP=$(sensors 2>/dev/null | grep -E "Core 0|Tctl" | head -1 | awk '{print int($3)}' | sed 's/+//;s/°C//' || echo "0")
DISK=$(df / | tail -1 | awk '{print int($5)}' | sed 's/%//')

# Determine color
COLOR="white"
if [[ $CPU -ge $CPU_RED || $RAM -ge $RAM_RED || $TEMP -ge $TEMP_RED || $DISK -ge $DISK_RED ]]; then
    COLOR="red"
elif [[ $CPU -ge $CPU_YELLOW || $RAM -ge $RAM_YELLOW || $TEMP -ge $TEMP_YELLOW || $DISK -ge $DISK_YELLOW ]]; then
    COLOR="yellow"
fi

# Output for Waybar
echo "{\"text\": \"\uf4bc\", \"class\": \"$COLOR\", \"tooltip\": \"CPU: ${CPU}% | RAM: ${RAM}% | TEMP: ${TEMP}°C | DISK: ${DISK}%\"}"
