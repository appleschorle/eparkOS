{
  pkgs,
  flakeRootPath,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    "${flakeRootPath}/modules/nixos/tuigreet.nix"
    "${flakeRootPath}/modules/nixos/sysc-greet.nix"
  ];

  programs.dconf.enable = true;

  epark.tuigreet.enable = true;

  nixpkgs.config.allowUnfree = true;

  nix.settings.experimental-features = ["nix-command" "flakes"];

  environment.systemPackages = with pkgs; [
    wget
    vivaldi
    grim
    slurp
    wl-clipboard
    brightnessctl
    # ddcutil -> external screen brightness
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
      "wheel" # sudo
      "networkmanager"
      "storage"
      "audio"
      "video"
      "camera"
      "lp" # printer devices
      "scanner"
    ];
    packages = [];
    shell = pkgs.zsh;
  };

  services.pipewire = {
    enable = true;
    pulse.enable = true;
    jack.enable = true;
    alsa = {
      enable = true;
      support32Bit = true;
    };
  };

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };
  services.blueman.enable = true;

  services.libinput.enable = true; # Touchpad support

  programs.zsh.enable = true;
  environment.pathsToLink = ["/share/zsh"];

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
