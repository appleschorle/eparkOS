{ ... }: {
  imports = [
    ./gnome.nix
    ./media.nix
  ];

  config = {
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

    networking.networkmanager.enable = true;
    hardware.bluetooth = {
      enable = true;
      powerOnBoot = true;
    };

    epark = {
      desktop.gnome.enable = true;
      media.enable = true;
    };
  };
}
