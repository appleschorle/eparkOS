# filename: xdg-user.nix (Home Manager Level)
{
  lib,
  config,
  ...
}: let
  cfg = config.epark.terminal.xdgUser;
in
  with lib; {
    options.epark.terminal.xdgUser.enable = mkEnableOption "Enable user XDG base directories and paths";

    config = mkIf cfg.enable {
      xdg = {
        enable = true;

        configHome = "${config.home.homeDirectory}/.config";
        dataHome = "${config.home.homeDirectory}/.local/share";
        cacheHome = "${config.home.homeDirectory}/.cache";

        userDirs = {
          enable = true;
          createDirectories = true;
          download = "${config.home.homeDirectory}/Downloads";
          documents = "${config.home.homeDirectory}/Documents";
          pictures = "${config.home.homeDirectory}/Pictures";
          videos = "${config.home.homeDirectory}/Videos";
          setSessionVariables = false;
        };
      };
    };
  }
