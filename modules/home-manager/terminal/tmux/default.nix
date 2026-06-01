{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.epark.terminal.tmux;
in {
  options.epark.terminal.tmux = {
    enable = lib.mkEnableOption "Enable Tmux";
  };

  config = lib.mkIf cfg.enable {
    programs.tmux = {
      enable = true;
      mouse = true;
      shortcut = "a";
      sensibleOnTop = true;
      terminal = "screen-256color";
      extraConfig =
        ''
          ${lib.optionalString pkgs.stdenv.isDarwin ''
            # Needed on macOS for proper clipboard integration
            set -g default-command "${pkgs.reattach-to-user-namespace}/bin/reattach-to-user-namespace ${pkgs.zsh}/bin/zsh"
          ''}

          ${lib.optionalString pkgs.stdenv.isLinux ''
            set -g default-command "${pkgs.zsh}/bin/zsh"
          ''}
        ''
        + builtins.readFile ./tmux.conf;
      # TODO: Set up tmux properly with vim https://github.com/christoomey/vim-tmux-navigator
      plugins = with pkgs; [
        {
          plugin = tmuxPlugins.gruvbox;
          extraConfig = ''
            set -g @tmux-gruvbox "dark" # Options: dark, dark256, light, light256
            set -g @tmux-gruvbox-right-status-x "Split"
            set -g @tmux-gruvbox-right-status-y "Screen"
            set -g @tmux-gruvbox-right-status-z "Magic  "
          '';
        }
        # {
        #   plugin = tmuxPlugins.vim-tmux-navigator;
        #   extraConfig = ''
        #     bind C-z send-keys 'C-l'
        #   '';
        # }
        tmuxPlugins.pain-control
      ];
    };
  };
}
