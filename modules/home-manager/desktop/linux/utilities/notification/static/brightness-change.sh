#!/usr/bin/env bash

# 1. Apply the hardware brightness change passed from the keybind (e.g., +5% or 5%-)
brightnessctl set "$1" >/dev/null

# 2. Fetch the newly calibrated volume percentage directly from the device driver
# Cuts away everything but the pure whole integer string (e.g., "45")
BRIGHTNESS=$(brightnessctl -m | awk -F, '{print substr($4, 1, length($4)-1)}')

# 3. Choose a descriptive display icon based on current brightness strength
if [ "$BRIGHTNESS" -lt 35 ]; then
	ICON="display-brightness-low"
elif [ "$BRIGHTNESS" -lt 70 ]; then
	ICON="display-brightness-medium"
else
	ICON="display-brightness-high"
fi

# 4. Dispatch the updated values to your Dunst tracking card
notify-send \
	-h string:x-dunst-stack-tag:backlight_status \
	-h int:value:"$BRIGHTNESS" \
	-t 1500 \
	-i "$ICON" \
	"Brightness" "$BRIGHTNESS%"
