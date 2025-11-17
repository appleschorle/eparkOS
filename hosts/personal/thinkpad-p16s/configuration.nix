{ pkgs, inputs, config, ... }:

let
	flakeRootPath = ../../../.;
in
{
	imports = [
		./hardware-configuration.nix
		"${flakeRootPath}/modules/configuration/users.nix"
		"${flakeRootPath}/modules/configuration/networking.nix"
		"${flakeRootPath}/modules/configuration/boot-loader.nix"
		"${flakeRootPath}/modules/configuration/audio.nix"
	];

	myBootLoader.enable = true;
	myAudio.enable = true;

	myUsers.names = [ "epark" ];
	myNetwork.hostName = "eugene-laptop";

	time.timeZone = "Europe/Stockholm";

  	nixpkgs.config.allowUnfree = true;
	nix.settings.experimental-features = [ "nix-command" "flakes" ];


  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput.enable = true;

  programs.firefox.enable = true;

  # List packages installed in system profile.
  # You can use https://search.nixos.org/ to find more packages (and options).
  environment.systemPackages = with pkgs; [
    wget
    kitty
    vivaldi
  ];

  # swapDevices = [
  #   { device = "/dev/nvme0n1p3"; }
  # ];
  system.stateVersion = "25.05"; # Did you read the comment?

  # CUSTOM
  programs.hyprland.enable = true;

  # https://github.com/sjcobb2022/nixos-config/blob/main/hosts/common/optional/greetd.nix
  services.greetd = {
    enable = true;
    settings.default_session = {
      command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --remember --remember-session --sessions ${pkgs.hyprland}/share/wayland-sessions";
      user = "epark";
    };
  };

  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };
  
}
