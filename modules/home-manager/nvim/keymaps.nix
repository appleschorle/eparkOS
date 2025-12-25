{
  config,
  lib,
  ...
}: let
  cfg = config.epark.nvim.keymaps;
in {
  imports = [];

  options = {
    epark.nvim.keymaps.enable = lib.mkEnableOption "Enable NeoVim Keymaps";
  };

  config = lib.mkIf cfg.enable {
    programs.nixvim.keymaps = [
      {
        action = "<cmd>Oil<CR>";
        key = "-";
        mode = "n";
        options.desc = "Open parent directory with Oil";
      }
      {
        key = "<leader>y";
        action = "\"+y";
        mode = ["n" "v"];
      }
      {
        key = "<leader>p";
        action = "\"+p";
        mode = "n";
      }
      {
        key = "<leader>P";
        action = "\"+P";
        mode = "n";
      }
      {
        key = "<leader>p";
        action = "\"_dP";
        mode = "v";
      }
    ];
  };
}
