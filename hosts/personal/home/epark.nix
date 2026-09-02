{ config, ... }:
let
  dotfiles = [
    "ghostty"
    "git"
    "lazygit"
    "nvim"
    "tmux"
    "zsh"
  ];
in
{
  config = {
    programs.home-manager.enable = true;
    home = {
      username = "epark";
      homeDirectory = "/home/epark";
      stateVersion = "25.05";
    };
    xdg.configFile = builtins.listToAttrs (
      map (name: {
        inherit name;
        value = {
          source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/repos/dotfiles/${name}";
        };
      }) dotfiles
    );
  };
}
