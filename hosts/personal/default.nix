{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ../../modules/nixos
  ];

  nixpkgs.overlays = [
    inputs.nur.overlays.default
  ];

  programs.dconf.enable = true;

  epark.tuigreet.enable = true;
  epark.media.enable = true;

  nixpkgs.config.allowUnfree = true;

  nix.settings.experimental-features = ["nix-command" "flakes"];

  environment.systemPackages = with pkgs; [
    wget
    grim
    slurp
    wl-clipboard
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
    ];
    packages = [];
    shell = pkgs.zsh;
  };

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };

  services.blueman.enable = true;

  services.libinput.enable = true;

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
