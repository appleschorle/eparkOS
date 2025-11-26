{flakeRootPath, ...}: {
  home = {
    username = "epark";
    homeDirectory = "/home/epark";
    stateVersion = "25.05";
  };
  programs.home-manager.enable = true;

  imports = [
    "${flakeRootPath}/modules/home-manager/editors/nvim.nix"
    "${flakeRootPath}/modules/home-manager/kanshi.nix"
    "${flakeRootPath}/modules/home-manager/hyprpaper.nix"
    "${flakeRootPath}/modules/home-manager/rofi.nix"
    "${flakeRootPath}/modules/home-manager/waybar.nix"
    "${flakeRootPath}/modules/home-manager/git.nix"
    "${flakeRootPath}/modules/home-manager/hyprland.nix"
    "${flakeRootPath}/modules/home-manager/discord.nix"
  ];

  nixpkgs.config.allowUnfree = true;

  epark.kanshi.enable = true;
  epark.nvim.enable = true;
  epark.hyprpaper.enable = true;
  epark.rofi.enable = true;
  epark.waybar.enable = true;
  epark.git.enable = true;
  epark.hyprland.enable = true;
  epark.discord.enable = true;
}
