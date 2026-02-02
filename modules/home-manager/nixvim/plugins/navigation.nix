{
  config,
  lib,
  ...
}: let
  cfg = config.epark.nixvim.plugins.navigation;
in {
  imports = [];

  options = {
    epark.nixvim.plugins.navigation.enable = lib.mkEnableOption "Enable NeoVim Plugins for Navigation";
  };

  config = lib.mkIf cfg.enable {
    programs.nixvim = {
      plugins = {
        oil.enable = true;
        telescope = {
          enable = true;
          keymaps = {
            # Keymaps can be defined simply within the plugin's scope
            # The 'action' here points to the Lua function that gets required automatically
            "<leader>ff" = {
              action = "find_files";
              options.desc = "Telescope find files";
            };
            "<leader>fg" = {
              action = "live_grep";
              options.desc = "Telescope live grep";
            };
            "<leader>fb" = {
              action = "buffers";
              options.desc = "Telescope buffers";
            };
            "<leader>fh" = {
              action = "help_tags";
              options.desc = "Telescope help tags";
            };
          };
        };
      };
    };
  };
}
