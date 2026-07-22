{inputs, ...}: {
  imports = [
    inputs.nix-colors.homeManagerModules.default

    ../../modules/home-manager/browser
    ../../modules/home-manager/desktop
    ../../modules/home-manager/development
    ../../modules/home-manager/terminal

    (import ../../modules/home-manager/ide {nixvim = inputs.nixvim.nixosModules.nixvim;})
    ./browser/firefox.nix
    ./development/git.nix
    ./terminal/zsh.nix
  ];

  config = {
    home = {
      username = "epark";
      homeDirectory = "/home/epark";
      stateVersion = "25.05";
    };
    programs.home-manager.enable = true;

    colorScheme = inputs.nix-colors.colorSchemes.gruvbox-dark-hard;

    epark = {
      development.nixvim.enable = true;
      development.lazygit.enable = true;
      development.direnv.enable = true;
      development.ruby.enable = true;
      desktop.hyprland.enable = true;
      desktop.discord.enable = true;
      desktop.cursor.enable = true;
      desktop.dunst.enable = true;
      desktop.hyprpolkitagent.enable = true;
      desktop.fonts.enable = true;
      desktop.theme.enable = true;
      desktop.waybar.enable = true;
      desktop.androidIntegration.enable = true;
      terminal.tmux.enable = true;
      terminal.zoxide.enable = true;
      terminal.kitty.enable = true;
      terminal.xdgUser.enable = true;
    };
  };
}
