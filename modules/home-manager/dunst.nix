{pkgs, ...}: {
  home.packages = with pkgs; [
    libnotify
  ];
  services.dunst = {
    enable = true;
    settings = {
      global = {
        enable_posix_regex = true;
        offset = "(10, 10)";
      };
    };
  };
}
