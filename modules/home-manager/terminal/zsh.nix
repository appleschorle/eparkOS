{
  config,
  lib,
  ...
}: let
  cfg = config.epark.terminal.zsh;
in {
  options.epark.terminal.zsh = {
    enable = lib.mkEnableOption "Enable zsh";

    cdpath = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [];
      description = "List of base paths that cd should also scan";
      example = ["~/repos"];
    };

    ignorePatterns = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [];
      description = "A custom list of Zsh history ignore patterns";
      example = ["*TOKEN*" "*SECRET*"];
    };

    zshrc = lib.mkOption {
      type = lib.types.str;
      default = "";
      description = "Additional settings written to zshrc";
      example = "bindkey ^F autosuggest-accept";
    };

    zshenv = lib.mkOption {
      type = lib.types.str;
      default = "";
      description = "Additional settings written to zshenv";
      example = "export EDITOR=nvim";
    };

    shellAliases = lib.mkOption {
      type = lib.types.attrsOf lib.types.str;
      default = {};
      description = "Extra shell aliases to merge with defaults";
    };

    shellGlobalAliases = lib.mkOption {
      type = lib.types.attrsOf lib.types.str;
      default = {};
      description = "Extra global shell aliases to merge with defaults";
    };

    sessionVariables = lib.mkOption {
      type = lib.types.attrsOf lib.types.str;
      default = {};
      description = "Environment variables to set in the shell session";
    };

    zlogin = lib.mkOption {
      type = lib.types.str;
      default = "";
      description = "Additional settings written to zlogin";
    };

    zlogout = lib.mkOption {
      type = lib.types.str;
      default = "";
      description = "Additional settings written to zlogout";
    };
  };

  config = lib.mkIf cfg.enable {
    programs.zsh = {
      enable = true;
      autocd = true;

      autosuggestion = {
        enable = true;
        highlight = "fg=#928374";
        strategy = ["match_prev_cmd" "history" "completion"];
      };

      cdpath = cfg.cdpath;
      defaultKeymap = "viins";
      dotDir = "${config.xdg.configHome}/zsh/";
      enableCompletion = true;
      enableVteIntegration = true;

      history = {
        append = true;
        expireDuplicatesFirst = false;
        extended = true;
        findNoDups = true;
        ignorePatterns = cfg.ignorePatterns;
        save = 10000;
        share = true;
      };

      historySubstringSearch = {
        enable = true;
        searchUpKey = ["^[OA"];
        searchDownKey = ["^[OB"];
      };

      shellAliases =
        {
          ll = "ls -lh";
        }
        // cfg.shellAliases;

      shellGlobalAliases =
        {
          G = "| grep";
        }
        // cfg.shellGlobalAliases;

      siteFunctions = {
        mkcd = "mkdir --parents $1 && cd $1";
      };

      syntaxHighlighting = {
        enable = true;
        highlighters = ["main" "brackets" "root" "cursor"];
      };

      sessionVariables = cfg.sessionVariables;
      initContent = cfg.zshrc;
      envExtra = cfg.zshenv;
      loginExtra = cfg.zlogin;
      logoutExtra = cfg.zlogout;
    };
  };
}
