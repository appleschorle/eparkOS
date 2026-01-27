{
  config,
  lib,
  ...
}: let
  cfg = config.epark.chatgpt;
in {
  options.epark.chatgpt.enable = lib.mkEnableOption "Enable ChatGPT for Desktop";

  config = lib.mkIf cfg.enable {
    xdg.desktopEntries.chatgpt = {
      name = "ChatGPT";
      exec = "firefox --new-window https://chat.openai.com --name chatgpt --class chatgpt";
      icon = "firefox";
      categories = ["Network" "Utility"];
    };
  };
}
