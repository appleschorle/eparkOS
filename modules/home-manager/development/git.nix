{
  lib,
  config,
  ...
}: let
  cfg = config.epark.development.git;
in
  with lib; {
    options.epark.development.git = {
      enable = mkEnableOption "Enable Git";
      userEmail = mkOption {
        type = lib.types.str;
        default = "";
        description = "Email used for git";
        example = "max.mustermann@gmail.com";
      };
    };

    config = mkIf cfg.enable {
      # https://jvns.ca/blog/2024/02/16/popular-git-config-options/
      programs.git = {
        enable = true;
        settings = {
          init.defaultBranch = "main";
          user.name = "Eugene Park";
          user.email = cfg.userEmail;
          pull.rebase = true;
          push.autoSetupRemote = true;
          help.autocorrect = "prompt";
          # https://luppeng.wordpress.com/2020/10/10/when-to-use-each-of-the-git-diff-algorithms/
          diff.algorithm = "histogram";
        };
      };
    };
  }
