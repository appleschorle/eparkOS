{
  config,
  lib,
  ...
}: let
  cfg = config.epark.whatsapp;
in {
  options.epark.whatsapp.enable = lib.mkEnableOption "Enable WhatsApp";

  config = lib.mkIf cfg.enable {
    xdg.desktopEntries.whatsapp = {
      name = "WhatsApp";
      exec = "firefox --new-window https://web.whatsapp.com --name whatsapp --class whatsapp";
      icon = "whatsapp";
      categories = ["Network" "Chat"];
    };
  };
}
