{pkgs, ...}: {
  imports = [
    ./hardware-configuration.nix
    ../../modules/nixos
  ];

  epark.media.enable = true;
  epark.gnome.enable = true;
  epark.vpn.enable = true;

  nixpkgs.config.allowUnfree = true;

  nix.settings.experimental-features = ["nix-command" "flakes"];

  environment.systemPackages = with pkgs; [
    wget
    brightnessctl
  ];

  nix.gc = {
    automatic = true;
    options = "--delete-older-than 30d";
    dates = "weekly";
    randomizedDelaySec = "45min";
  };

  time.timeZone = "Europe/Stockholm";

  networking = {
    hostName = "eugene-laptop";
    networkmanager.enable = true;
  };

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  virtualisation.docker.enable = true;
  services.nginx.enable = true;

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

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };

  programs.zsh.enable = true;
  environment.pathsToLink = ["/share/applications" "/share/xdg-desktop-portal" "/share/zsh"];

  fonts.packages = with pkgs; [
    nerd-fonts.fira-code
  ];

  systemd.tmpfiles.rules = [
    "d /home/epark/Media 0700 epark users -"
    "d /home/epark/Media/Screenshots 0700 epark users -"
  ];

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };

  system.stateVersion = "25.05";
}
