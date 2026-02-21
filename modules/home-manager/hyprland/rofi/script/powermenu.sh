#!/bin/bash

theme_file_path="@themeFile@"

options=" \n󰜉 \n "
last_login="$(last "$USER" | head -n1 | tr -s ' ' | awk '{printf "%s %02d, %s", $4,$5,$6}')"
uptime="$(uptime | awk '{print $3}' | sed 's/.$//')"

chosen=$(echo -e "$options" | @rofi@/bin/rofi -dmenu -p " $USER" -mesg " Last Login: $last_login |  Uptime: $uptime" -theme $theme_file_path)

case $chosen in
" ") systemctl poweroff ;;
"󰜉 ") systemctl reboot ;;
" ") hyprlock ;;
esac
