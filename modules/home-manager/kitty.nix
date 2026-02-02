{
  config,
  lib,
  ...
}: let
  cfg = config.epark.kitty;
in {
  options.epark.kitty.enable = lib.mkEnableOption "Enable Kitty";

  config = lib.mkIf cfg.enable {
    programs.kitty = {
      enable = true;
      themeFile = "GruvboxMaterialDarkHard";
      font = {
        name = "FiraCode Nerd Font";
        size = 16;
      };
    };
  };
}
