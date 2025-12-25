{
  config,
  lib,
  ...
}: let
  cfg = config.epark.nvim.extra-config;
in {
  imports = [];

  options = {
    epark.nvim.extra-config.enable = lib.mkEnableOption "Enable NeoVim Extra Lua Config";
  };

  config = lib.mkIf cfg.enable {
    programs.nixvim = {
      extraConfigLuaPre = builtins.readFile ./config/pre-config.lua;
      # extraConfigLuaPost = builtins.readFile ./config/post-config.lua;
    };
  };
}
