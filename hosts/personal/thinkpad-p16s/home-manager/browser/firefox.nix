{flakeRootPath, ...}: {
  imports = [
    "${flakeRootPath}/modules/home-manager/browser/firefox.nix"
    ./firefox/bookmarks.nix
    ./firefox/search_engines.nix
  ];
  config = {
    epark.browser.firefox = {
      enable = true;
      autofillCreditCardEnabled = true;
    };
  };
}
