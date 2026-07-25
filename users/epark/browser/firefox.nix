{...}: {
  imports = [
    ./firefox/bookmarks.nix
    ./firefox/search_engines.nix
  ];

  epark.desktop.app.firefox = {
    enable = true;
  };
}
