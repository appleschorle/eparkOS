{
  epark.browser.firefox.engines = {
    "Nix Packages" = {
      urls = [
        {
          template = "https://search.nixos.org/packages";
          params = [
            {
              name = "type";
              value = "packages";
            }
            {
              name = "query";
              value = "{searchTerms}";
            }
          ];
        }
      ];
      icon = "https://nixos.wiki/favicon.png";
      definedAliases = ["@np"];
    };
    "NixOS Wiki" = {
      urls = [{template = "https://nixos.wiki/index.php?search={searchTerms}";}];
      icon = "https://nixos.wiki/favicon.png";
      updateInterval = 24 * 60 * 60 * 1000; # every day
      definedAliases = ["@nw"];
    };
    "google".metaData.alias = "@g";
    "bing".metaData.hidden = true;
    "ddg".metaData.hidden = true;
    "ecosia".metaData.hidden = true;
    "perplexity".metaData.hidden = true;
    "wikipedia".metaData.hidden = true;
  };
}
