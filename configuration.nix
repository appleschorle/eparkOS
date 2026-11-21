{ pkgs, ... }:
{
  imports = [
    ./hardware-configuration.nix
  ];

  environment.systemPackages = with pkgs; [
    clang
    claude-code
    direnv
    discord
    evolution
    firefox
    ghostty
    git
    go
    google-chrome
    jdt-language-server
    lazygit
    lemminx
    libreoffice-fresh
    lua-language-server
    maven
    mullvad-vpn
    neovim
    nixd
    nixfmt
    nodejs
    obsidian
    prettier
    python314
    ripgrep
    ruby
    simple-scan
    spotify
    stylua
    tmux
    tree-sitter
    vlc
    zoxide
    zsh-autosuggestions
    zsh-completions
  ];

  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  nix.gc = {
    automatic = true;
    options = "--delete-older-than 30d";
    dates = "weekly";
    randomizedDelaySec = "45min";
  };

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  networking.networkmanager.enable = true;
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    pulse.enable = true;
    wireplumber.enable = true;

    alsa = {
      enable = true;
      support32Bit = true;
    };
  };

  programs.fuse.enable = true;

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
    packages = [ ];
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

  services.ollama = {
    enable = true;
  };

  services.mullvad-vpn.enable = true;

  programs.kdeconnect.enable = true;

  programs.java.enable = true;

  programs.ausweisapp.enable = true;
  programs.ausweisapp.openFirewall = true;

  hardware.sane.enable = true;

  system.stateVersion = "25.05";
}
