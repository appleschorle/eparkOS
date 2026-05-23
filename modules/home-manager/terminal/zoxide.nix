{
  config,
  lib,
  ...
}: let
  cfg = config.epark.zoxide;
in {
  options.epark.zoxide.enable = lib.mkEnableOption "Enable zoxide";

  config = lib.mkIf cfg.enable {
    programs.zoxide = {
      enable = true;
      enableZshIntegration = true;
    };
  };
}
