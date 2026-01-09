{pkgs, ...}: let
  rofi-powermenu =
    pkgs.writeShellScriptBin "rofi-powermenu"
    # bash
    ''
      options="Shutdown\nReboot\nLock"

      # Use the absolute path for rofi to ensure it works regardless of your environment
      chosen=$(echo -e "$options" | ${pkgs.rofi}/bin/rofi -dmenu -i -p "Power")

      case $chosen in
          Shutdown) systemctl poweroff ;;
          Reboot) systemctl reboot ;;
          Lock) hyprlock ;;
      esac
    '';
in {
  # Add the script to your installed packages
  home.packages = [
    rofi-powermenu
  ];
}
