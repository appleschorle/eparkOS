{
  lib,
  config,
  ...
}: let
  cfg = config.epark.git;
in
  with lib; {
    imports = [];

    options.epark.git.enable = mkEnableOption "Enable Git";

    config = mkIf cfg.enable {
      # https://jvns.ca/blog/2024/02/16/popular-git-config-options/
      programs.git = {
        enable = true;
        settings = {
          init.defaultBranch = "main";
          user.name = "Eugene Park";
          user.email = "eugenepark2001@gmail.com";
          pull.rebase = true;
          push.autoSetupRemote = true;
          help.autocorrect = "prompt";
          # https://luppeng.wordpress.com/2020/10/10/when-to-use-each-of-the-git-diff-algorithms/
          diff.algorithm = "histogram";
        };
      };
    };
  }
