{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.epark.desktop.clipboard;
in {
  options.epark.desktop.clipboard.enable =
    lib.mkEnableOption "Enable persistent clipboard history via cliphist";

  config = lib.mkIf cfg.enable {
    home.packages = [
      pkgs.cliphist
      pkgs.wl-clipboard
    ];

    services.cliphist.enable = true;

    # # 2. Inject autostart commands into your existing Hyprland service config
    # wayland.windowManager.hyprland.settings.exec-once = [
    #   # Listens for clipboard text changes and writes them to cliphist
    #   "${pkgs.wl-clipboard}/bin/wl-paste --type text --watch ${pkgs.cliphist}/bin/cliphist store"
    #   # Listens for copied images and writes them to cliphist
    #   "${pkgs.wl-clipboard}/bin/wl-paste --type image --watch ${pkgs.cliphist}/bin/cliphist store"
    # ];
  };
}
