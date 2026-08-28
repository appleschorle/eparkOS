{pkgs, ...}: {
  imports = [
    ../../modules/home-manager
    ../../modules/home-manager/desktop/linux/wayland/gnome

    ./browser/firefox.nix
  ];

  config = {
    home = {
      username = "epark";
      homeDirectory = "/home/epark";
      stateVersion = "25.05";
    };

    home.packages = with pkgs; [
      discord
      evolution
      karere
      libreoffice-fresh
      python314
      ruby
      vlc
    ];

    programs.mullvad-vpn = {
      enable = true;
    };

    epark = {
      desktop.app.firefox.enable = true;
      desktop.linux.wayland.gnome.enable = true;
    };
  };
}
