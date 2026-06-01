{
  config,
  lib,
  ...
}: let
  cfg = config.epark.terminal.zoxide;
in {
  options.epark.terminal.zoxide.enable = lib.mkEnableOption "Enable zoxide";

  config = lib.mkIf cfg.enable {
    programs.zoxide = {
      enable = true;
      enableZshIntegration = true;
    };
  };
}
