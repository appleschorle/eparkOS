{
  config,
  lib,
  ...
}: let
  cfg = config.epark.zsh;
in {
  options.epark.zsh.enable = lib.mkEnableOption "Enable zsh";

  config = lib.mkIf cfg.enable {
    # And add pasting to nvim from + when in visual mode
    home.sessionPath = [
      "/opt/homebrew/bin"
      "/opt/homebrew/sbin"
      "$HOME/.local/bin"
      "/Applications/Rancher Desktop.app/Contents/Resources/resources/darwin/bin"
    ];

    programs.zsh = {
      enable = true;
      enableCompletion = true;
      enableVteIntegration = true;
      autocd = true;
      autosuggestion = {
        enable = true;
      };
      defaultKeymap = "viins";
      history = {
        append = true;
        expireDuplicatesFirst = true;
        extended = true;
        findNoDups = true;
      };
      initContent = ''
        bindkey '^F' autosuggest-accept
        autoload -Uz edit-command-line
        zle -N edit-command-line
        bindkey '^E' edit-command-line
      '';
      shellAliases = {
        ll = "ls -lh";
      };
      shellGlobalAliases = {
        G = "| grep";
      };
      siteFunctions = {
        mkcd = ''
          mkdir --parents "$1" && cd "$1"
        '';
      };
      syntaxHighlighting = {
        enable = true;
        highlighters = [
          "main"
          "brackets"
          "root"
          "cursor"
        ];
      };
      sessionVariables = {
        EDITOR = "vi";

        AWS_CONFIG_FILE = "$HOME/.config/aws/config";

        XDG_CONFIG_HOME = "$HOME/.config";
        XDG_CACHE_HOME = "$HOME/.cache";
        XDG_DATA_HOME = "$HOME/.local/share";
        XDG_STATE_HOME = "$HOME/.local/share";
      };
    };
  };
}
