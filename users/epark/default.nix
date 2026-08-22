{pkgs, ...}: {
  imports = [
    ../../modules/home-manager
    ../../modules/home-manager/desktop/linux/wayland/gnome
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

    home.packages = with pkgs; [
      discord
      libreoffice-fresh
      vlc
    ];

    programs.mullvad-vpn = {
      enable = true;
    };

    epark = {
      development.nixvim.enable = true;
      development.lazygit.enable = true;
      development.direnv.enable = true;
      development.ruby.enable = true;
      desktop.app.firefox.enable = true;
      desktop.linux.wayland.gnome.enable = true;
      terminal.tmux.enable = true;
      terminal.zoxide.enable = true;
      terminal.kitty.enable = true;
    };
  };
}
