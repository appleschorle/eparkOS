{inputs, ...}: {
  imports = [
    inputs.nix-colors.homeManagerModules.default

    ../../modules/home-manager/desktop/app
    ../../modules/home-manager/desktop/linux/wayland/hyprland
    ../../modules/home-manager/development
    ../../modules/home-manager/ide
    ../../modules/home-manager/terminal

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
      desktop.app.libreOffice.enable = true;
      desktop.app.discord.enable = true;
      desktop.app.firefox.enable = true;
      desktop.app.vlc.enable = true;
      desktop.app.vpn.enable = true;
      desktop.linux.wayland.hyprland.enable = true;
      terminal.tmux.enable = true;
      terminal.zoxide.enable = true;
      terminal.kitty.enable = true;
    };
  };
}
