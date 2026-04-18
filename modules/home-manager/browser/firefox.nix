# TODO: Expose bookmarks as an option and make it more customized with search engines etc.
{
  lib,
  config,
  ...
}: let
  cfg = config.epark.browser.firefox;
in
  with lib; {
    options.epark.browser.firefox = {
      enable = mkEnableOption "Enable FireFox";
      autofillCreditCardEnabled = mkEnableOption "Enable auto fill of credit cards in firefox";
      bookmarks = lib.mkOption {
        type = lib.types.listOf lib.types.attrs;
        default = [];
        description = "Bookmarks in firefox";
      };
      search_engines = lib.mkOption {
        type = lib.types.listOf lib.types.str;
        default = ["ddg" "google"];
      };
    };

    config = mkIf cfg.enable {
      # https://discourse.nixos.org/t/declare-firefox-extensions-and-settings/36265
      programs.firefox = {
        enable = true;

        languagePacks = ["en-US"];

        profiles = {
          personal = {
            id = 0;
            isDefault = true;
            search = {
              force = true;
              default = lib.head cfg.search_engines;
              order = cfg.search_engines;
            };
            settings = {
              "extensions.activeThemeID" = "firefox-compact-dark@mozilla.org";
              "browser.bookmarks.addedImportButton" = false;
            };
            bookmarks = {
              force = true;
              settings = [
                {
                  name = "Bookmarks Toolbar";
                  toolbar = true;
                  bookmarks = cfg.bookmarks;
                }
              ];
            };
          };
        };

        # Check about:policies#documentation for options.
        policies = {
          # Updates & Background Services
          AppAutoUpdate = false;
          BackgroundAppUpdate = false;

          # Feature Disabling
          DisableAccounts = true;
          DisableFirefoxAccounts = true;
          DisableFirefoxStudies = true;
          DisableTelemetry = true;
          DisplayBookmarksToolbar = "always";
          DisplayMenuBar = "default-off";

          # Access Restrictions
          BlockAboutConfig = false;
          BlockAboutSupport = false;
          BlockAboutProfiles = true;

          # UI and behavior
          AutofillCreditCardEnabled = cfg.autofillCreditCardEnabled;
          DontCheckDefaultBrowser = true;
          EnableTrackingProtection = {
            Value = true;
            Locked = true;
            Cryptomining = true;
            Fingerprinting = true;
          };
          OfferToSaveLogins = false;
          PromptForDownloadLocation = false;
          SearchBar = "unified";
          TranslateEnabled = true;

          # Check about:support for extension/add-on ID strings.
          # Valid strings for installation_mode are "allowed", "blocked",
          # "force_installed" and "normal_installed".
          ExtensionSettings = let
            moz = short: "https://addons.mozilla.org/firefox/downloads/latest/${short}/latest.xpi";
          in {
            "*".installation_mode = "blocked"; # blocks all addons except the ones specified below
            # uBlock Origin:
            "uBlock0@raymondhill.net" = {
              install_url = moz "ublock-origin";
              installation_mode = "force_installed";
            };
            "{446900e4-71c2-419f-a6a7-df9c091e268b}" = {
              install_url = moz "bitwarden-password-manager";
              installation_mode = "force_installed";
            };
            # Gruvbox Dark Theme
            # "{eb8c4a94-e603-49ef-8e81-73d3c4cc04ff}" = {
            #   install_url = moz "gruvbox-dark-theme";
            #   installation_mode = "force_installed";
            # };
          };
          # Check about:config for options.
          # Preferences = {
          # "extensions.activeThemeID" = "{eb8c4a94-e603-49ef-8e81-73d3c4cc04ff}"; # Gruvbox Dark Theme
          # };
        };
      };
    };
  }
