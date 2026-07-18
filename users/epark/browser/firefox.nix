{...}: {
  imports = [
    ./firefox/bookmarks.nix
    ./firefox/search_engines.nix
  ];

  epark.browser.firefox = {
    enable = true;
    autofillCreditCardEnabled = true;
  };
}
