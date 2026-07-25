#!/usr/bin/env bash

# 1. Apply the volume change passed from the keybind (e.g., 5%+ or 5%-)
# Configured with a strict safety ceiling of 100% (-l 1.0)
wpctl set-volume -l 1.0 @DEFAULT_AUDIO_SINK@ "$1"

# 2. Extract current audio properties from WirePlumber
VOLUME_DATA=$(wpctl get-volume @DEFAULT_AUDIO_SINK@)

# 3. Process mute state vs numerical volume percentage
if echo "$VOLUME_DATA" | grep -q "MUTED"; then
	# Send an instant muted card with an integer progress bar value of 0
	notify-send \
		-h string:x-dunst-stack-tag:audio_status \
		-h int:value:0 \
		-i audio-volume-muted \
		"Volume" "Muted"
else
	# Parse the raw volume decimal into a whole number string (e.g., 0.45 becomes 45)
	VOLUME=$(echo "$VOLUME_DATA" | awk '{print int($2 * 100)}')

	# Choose the correct dynamic icon based on loudness thresholds
	if [ "$VOLUME" -eq 0 ]; then
		ICON="audio-volume-low"
	elif [ "$VOLUME" -lt 35 ]; then
		ICON="audio-volume-low"
	elif [ "$VOLUME" -lt 70 ]; then
		ICON="audio-volume-medium"
	else
		ICON="audio-volume-high"
	fi

	# Dispatch to Dunst over D-Bus
	# 'int:value' automatically renders Dunst's built-in progress bar graphic
	notify-send \
		-h string:x-dunst-stack-tag:audio_status \
		-h int:value:"$VOLUME" \
		-t 1500 \
		-i "$ICON" \
		"Volume" "$VOLUME%"
fi
