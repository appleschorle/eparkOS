{pkgs, ...}: {
  imports = [
    ./hardware-configuration.nix
    ../../modules/nixos
  ];

  time.timeZone = "Europe/Stockholm";
  networking.hostName = "eugene-laptop";

  programs.zsh.enable = true;
  users.mutableUsers = true;
  users.users.epark = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "networkmanager"
      "storage"
      "audio"
      "video"
      "camera"
      "lp"
      "scanner"
      "docker"
    ];
    packages = [];
    shell = pkgs.zsh;
  };

  systemd.tmpfiles.rules = [
    "d /home/epark/Media 0700 epark users -"
    "d /home/epark/Media/Screenshots 0700 epark users -"
  ];

  fonts.packages = with pkgs; [
    nerd-fonts.fira-code
  ];

  virtualisation.docker.enable = true;

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };

  services.mullvad-vpn.enable = true;

  system.stateVersion = "25.05";
}
