options="Shutdown\nReboot\nLock"

# Use placeholders for Nix-provided paths
chosen=$(echo -e "$options" | @rofi@/bin/rofi -dmenu -i -p "Power")

case $chosen in
    Shutdown) systemctl poweroff ;;
    Reboot) systemctl reboot ;;
    Lock) hyprlock ;;
esac
