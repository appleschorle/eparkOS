{
  config,
  lib,
  ...
}: let
  cfg = config.epark.development.lazygit;
in {
  options.epark.development.lazygit.enable = lib.mkEnableOption "Enable lazygit";

  config = lib.mkIf cfg.enable {
    programs.lazygit = {
      enable = true;
      enableZshIntegration = true;
      settings = {
        gui.theme = {
          selectedLineBgColor = ["default"];
        };
      };
    };
  };
}
