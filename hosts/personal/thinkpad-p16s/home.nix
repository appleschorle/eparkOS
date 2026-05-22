{
  flakeRootPath,
  inputs,
  ...
}: let
  homePath = "/home/epark";
in {
  imports = [
    "${flakeRootPath}/modules/home-manager/nixvim"
    "${flakeRootPath}/modules/home-manager/browser"
    "${flakeRootPath}/modules/home-manager/hyprland"
    "${flakeRootPath}/modules/home-manager/git.nix"
    "${flakeRootPath}/modules/home-manager/discord.nix"
    "${flakeRootPath}/modules/home-manager/cursor.nix"
    "${flakeRootPath}/modules/home-manager/tmux.nix"
    "${flakeRootPath}/modules/home-manager/lazygit.nix"
    "${flakeRootPath}/modules/home-manager/zoxide.nix"
    "${flakeRootPath}/modules/home-manager/zsh.nix"
    "${flakeRootPath}/modules/home-manager/kitty.nix"
    "${flakeRootPath}/modules/home-manager/icon-pack.nix"
    "${flakeRootPath}/modules/home-manager/dunst.nix"
    "${flakeRootPath}/modules/home-manager/ruby.nix"
    "${flakeRootPath}/modules/home-manager/direnv.nix"
  ];

  config = {
    home = {
      username = "epark";
      homeDirectory = homePath;
      stateVersion = "25.05";
    };
    programs.home-manager.enable = true;

    nixpkgs.config.allowUnfree = true;

    colorScheme = inputs.nix-colors.colorSchemes.gruvbox-dark-hard;

    epark = {
      browser = {
        enable = true;
        firefox = {
          autofillCreditCardEnabled = true;
          engines = {
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
          bookmarks = [
            {
              name = "AI";
              bookmarks = [
                {
                  name = "ChatGPT";
                  tags = ["ai" "gpt"];
                  keyword = "gpt";
                  url = "https://chat.openai.com";
                }
                {
                  name = "Gemini";
                  tags = ["ai" "gemini"];
                  keyword = "gemini";
                  url = "https://gemini.google.com/app";
                }
              ];
            }
            {
              name = "Social";
              bookmarks = [
                {
                  name = "WhatsApp";
                  tags = ["social" "messanger"];
                  keyword = "wa";
                  url = "https://web.whatsapp.com/";
                }
                {
                  name = "LinkedIn";
                  tags = ["social" "job"];
                  keyword = "li";
                  url = "https://www.linkedin.com/feed";
                }
              ];
            }
            {
              name = "Video";
              bookmarks = [
                {
                  name = "CrunchyRoll";
                  tags = ["video" "anime" "streaming" "entertainment"];
                  keyword = "anime";
                  url = "https://www.crunchyroll.com/";
                }
                {
                  name = "YouTube";
                  tags = ["video" "entertainment"];
                  keyword = "yt";
                  url = "https://www.youtube.com/";
                }
              ];
            }
            {
              name = "Nix sites";
              bookmarks = [
                {
                  name = "MyNixOS";
                  tags = ["nix" "wiki" "home-manager" "options"];
                  keyword = "nix";
                  url = "https://mynixos.com/";
                }
                {
                  name = "homepage";
                  tags = ["nix"];
                  url = "https://nixos.org/";
                }
                {
                  name = "wiki";
                  tags = ["wiki" "nix"];
                  url = "https://wiki.nixos.org/";
                }
              ];
            }
          ];
        };
      };
      nixvim.enable = true;
      hyprland.enable = true;
      git.enable = true;
      discord.enable = true;
      cursor.enable = true;
      dunst.enable = true;
      icon-pack.enable = true;
      lazygit.enable = true;
      tmux.enable = true;
      zoxide.enable = true;
      zsh.enable = true;
      kitty.enable = true;
      ruby.enable = true;
      direnv.enable = true;
    };
  };
}
