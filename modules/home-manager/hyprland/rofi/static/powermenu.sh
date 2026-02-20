#!/bin/bash

theme_file="@themeFile@"

options=" \n󰜉 \n "

# Use placeholders for Nix-provided paths
chosen=$(echo -e "$options" | @rofi@/bin/rofi -dmenu -i -p " $USER@" -theme $theme_file)

case $chosen in
" ") systemctl poweroff ;;
"󰜉 ") systemctl reboot ;;
" ") hyprlock ;;
esac
