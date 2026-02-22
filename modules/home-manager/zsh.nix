{
  config,
  lib,
  ...
}: let
  colors = config.colorScheme.palette;
  cfg = config.epark.zsh;
in {
  options.epark.zsh.enable = lib.mkEnableOption "Enable zsh";

  config = lib.mkIf cfg.enable {
    # TODO: Refactor with seperate file, see why after failed command its still green, check why on load up the git info is not displayed properly, check completion menu and prettify it
    # https://discourse.nixos.org/t/string-interpolation-in-files-without-substituteall/38779/3
    # https://thevaluable.dev/zsh-completion-guide-examples/
    # And add pasting to nvim from + when in visual mode
    home.sessionPath = [
      "/opt/homebrew/bin"
      "/opt/homebrew/sbin"
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
      dirHashes = {
        repos = "~/repos";
      };
      history = {
        append = true;
        expireDuplicatesFirst = true;
        extended = true;
        findNoDups = true;
      };
      historySubstringSearch = {
        enable = true;
        searchDownKey = "^[[B";
        searchUpKey = "^[[A";
      };
      initContent =
        # bash
        ''
          # -----------------------
          # Colors
          # -----------------------
          BASE_COLOR='#${colors.base01}'
          STATUS_FAILED_COLOR='#${colors.base08}'
          STATUS_SUCCESS_COLOR='#${colors.base0B}'
          DIRECTORY_COLOR='#${colors.base0A}'
          GIT_COLOR='#${colors.base04}'
          STAGED_CHANGES_COLOR='#${colors.base0B}'
          UNSTAGED_CHANGES_COLOR='#${colors.base08}'
          VENV_COLOR='#${colors.base01}'
          VENV_FG_COLOR='#${colors.base02}'

          # -----------------------
          # Prompt symbols
          # -----------------------
          RIGHT=0
          LEFT=1

          ARROW_RIGHT="\ue0b0"
          ARROW_LEFT="\ue0b2"
          WEAK_SEPARATOR_LEFT="\ue0b3"

          STAGED_CHANGES="\u229E"
          UNSTAGED_CHANGES="\u229f"
          BRANCH="\u03bb"

          PROMPT_EOL_MARK=""

          # -----------------------
          # Functions
          # -----------------------
          arrow_segment() {
          local FOREGROUND=$1
          local BACKGROUND=$2
          local ARROW=$([[ $DIRECTION -eq 0 ]] && echo $ARROW_RIGHT || echo $ARROW_LEFT)

          if [[ -z "$BACKGROUND" ]]; then
          print -n "%{%F{$FOREGROUND}%}$ARROW%{%f%}"
          else
          print -n "%{%K{$BACKGROUND}%}%{%F{$FOREGROUND}%}$ARROW%{%f%}%{%k%}"
          fi
          }

          status_segment() {
          print -n "%{%K{$STATUS_COLOR}%} %{%k%}"
          }

          directory_segment() {
          print -n "%{%K{$DIRECTORY_COLOR}%}%{%F{$BASE_COLOR}%} %(5~|%-1~/…/%2~|%~) %{%f%}%{%k%}"
          }

          venv_segment() {
          if [[ -n "$VIRTUAL_ENV" ]]; then
          print -n "%{%K{$VENV_COLOR}%}%{%F{$VENV_FG_COLOR}%} $(basename $VIRTUAL_ENV)%{%f%}%{%k%}"
          fi
          }

          git_segment() {
          if [[ -n "$vcs_info_msg_0_" ]]; then
          print -n "%{%K{$GIT_COLOR}%}%{%F{$BASE_COLOR}%} ''${vcs_info_msg_0_} %{%f%}%{%k%}"
          else
          print -n "%{%K{$GIT_COLOR}%} %{%k%}"
          fi
          }

          # -----------------------
          # Set prompt
          # -----------------------
          set_prompt() {
          local EXIT_STATUS=$?
          STATUS_COLOR=$([[ $EXIT_STATUS -eq 0 ]] && echo $STATUS_SUCCESS_COLOR || echo $STATUS_FAILED_COLOR)

          DIRECTION=$RIGHT
          PROMPT="$(status_segment)$(arrow_segment $STATUS_COLOR $BASE_COLOR)$(arrow_segment $BASE_COLOR $DIRECTORY_COLOR)$(directory_segment)$(arrow_segment $DIRECTORY_COLOR) %# "

          zstyle ':vcs_info:git:*' stagedstr "%{%F{$STAGED_CHANGES_COLOR}%}''${STAGED_CHANGES}%{%f%}"
          zstyle ':vcs_info:git:*' unstagedstr "%{%F{$UNSTAGED_CHANGES_COLOR}%}''${UNSTAGED_CHANGES}%{%f%}"
          zstyle ':vcs_info:git:*' branchformat '%b'
          zstyle ':vcs_info:git:*' check-for-changes true
          zstyle ':vcs_info:git:*' get-revision true
          zstyle ':vcs_info:git:*' formats "''${BRANCH} %b ''${WEAK_SEPARATOR_LEFT} %u%c"
          zstyle ':vcs_info:git:*' actionformats "''${BRANCH} %b ''${WEAK_SEPARATOR_LEFT} %a"

          DIRECTION=$LEFT
          RPROMPT="$(arrow_segment $VENV_COLOR)$(venv_segment)$(arrow_segment $BASE_COLOR $VENV_COLOR)$(arrow_segment $GIT_COLOR $BASE_COLOR)$(git_segment)"
          }

          # -----------------------
          # Initialize
          # -----------------------
          autoload -Uz vcs_info

          precmd() {
          # Print one free line after every prompt
          print ""
          vcs_info
          set_prompt
          }

          # 1. Load the completion list module (MANDATORY for menu-select)
          zmodload -i zsh/complist

          # 2. Initialize completion system
          autoload -Uz compinit && compinit

          # 3. Enable interactive menu selection
          zstyle ':completion:*' menu select

          # Autosuggest accept
          bindkey '^f' autosuggest-accept

          # Exit menu cleanly
          bindkey -M menuselect '^[' send-break
        '';
      shellAliases = {
        ll = "ls -l";
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

        AWS_CONFIG_FILE = "$XDG_CONFIG_HOME/aws/config";

        XDG_CONFIG_HOME = "$HOME/.config";
        XDG_CACHE_HOME = "$HOME/.cache";
        XDG_DATA_HOME = "$HOME/.local/share";
        XDG_STATE_HOME = "$HOME/.local/share";
      };
    };
  };
}
