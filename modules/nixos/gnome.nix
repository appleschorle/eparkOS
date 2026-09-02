{ ... }:
{
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;

  programs.dconf = {
    enable = true;
    profiles = {
      user.databases = [
        {
          settings = {
            "org/gnome/desktop/input-sources" = {
              show-all-sources = true;
              sources = "[('xkb', 'us'), ('xkb', 'se'), ('xkb', 'de')]";
              xkb-options = [ "grp:win_space_toggle" ];
            };
          };
        }
      ];
    };
  };

  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };
  networking.networkmanager.enable = true;
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };
}
