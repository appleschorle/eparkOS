{ ... }: {
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
}
