#!/bin/bash

theme_file_path="@themeFile@"

power=""
reboot="󰜉"
lock=""
options=("$power" "$reboot" "$lock")
last_login="$(last "$USER" | head -n1 | tr -s ' ' | awk '{printf "%s %02d, %s", $4,$5,$6}')"
uptime="$(uptime | awk '{print $3}' | sed 's/.$//')"
# -p " $USER"
chosen=$(printf "%s\n" "${options[@]}" | @rofi@/bin/rofi -dmenu -p " $USER" -mesg " Last Login: $last_login |  Uptime: $uptime" -theme $theme_file_path)

case $chosen in
"$power") systemctl poweroff ;;
"$reboot") systemctl reboot ;;
"$lock") hyprlock ;;
esac
