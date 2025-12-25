{
  pkgs,
  flakeRootPath,
  ...
}: {
  # TODO: Refactor file further and check home-manager, rofi, nvim configuration, wallpapers, lazygit, waybar, etc.
  imports = [
    ./hardware-configuration.nix
    "${flakeRootPath}/modules/nixos/users.nix"
    "${flakeRootPath}/modules/nixos/networking.nix"
    "${flakeRootPath}/modules/nixos/boot-loader.nix"
    "${flakeRootPath}/modules/nixos/audio.nix"
  ];

  myBootLoader.enable = true;
  myAudio.enable = true;

  myUsers.names = ["epark"];
  myNetwork.hostName = "eugene-laptop";

  time.timeZone = "Europe/Stockholm";

  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = ["nix-command" "flakes"];

  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput.enable = true;

  # List packages installed in system profile.
  # You can use https://search.nixos.org/ to find more packages (and options).
  environment.systemPackages = with pkgs; [
    wget
    kitty
    vivaldi
    grim
    slurp
    wl-clipboard
  ];

  systemd.tmpfiles.rules = [
    "d /home/epark/Media 0700 epark users -"
    "d /home/epark/Media/Screenshots 0700 epark users -"
  ];

  system.stateVersion = "25.05"; # Did you read the comment?

  # https://github.com/sjcobb2022/nixos-config/blob/main/hosts/common/optional/greetd.nix
  services.greetd = {
    enable = true;
    settings.default_session = {
      command = "${pkgs.tuigreet}/bin/tuigreet --time --remember --remember-session --sessions ${pkgs.hyprland}/share/wayland-sessions";
      user = "epark";
    };
  };

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };
}
