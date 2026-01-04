{pkgs, ...}: {
  imports = [
    ./hardware-configuration.nix
  ];

  nixpkgs.config.allowUnfree = true;

  nix.settings.experimental-features = ["nix-command" "flakes"];

  environment.systemPackages = with pkgs; [
    wget
    kitty
    vivaldi
    grim
    slurp
    wl-clipboard
    brightnessctl
    # ddcutil -> external screen brightness
  ];

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

  services.greetd.enable = true;
  services.greetd.settings.default_session = {
    command = "${pkgs.tuigreet}/bin/tuigreet --time --remember --remember-session --sessions ${pkgs.hyprland}/share/wayland-sessions";
    user = "epark";
  };

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
