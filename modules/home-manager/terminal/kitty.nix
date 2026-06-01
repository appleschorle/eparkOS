{
  config,
  lib,
  ...
}: let
  cfg = config.epark.terminal.kitty;
in {
  options.epark.terminal.kitty.enable = lib.mkEnableOption "Enable Kitty";

  config = lib.mkIf cfg.enable {
    programs.kitty = {
      enable = true;
      themeFile = "GruvboxMaterialDarkHard";
      font = {
        name = "FiraCode Nerd Font";
        size = 16;
      };
      settings = {
        scrollback_lines = 10000;
      };
    };
  };
}
