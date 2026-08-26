{
  pkgs,
  config,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ../../modules/nixos
  ];

  environment.systemPackages = with pkgs; [
    sops
    spotify
    zoxide
  ];

  time.timeZone = "Europe/Stockholm";
  networking.hostName = "eugene-laptop";

  programs.zsh.enable = true;
  users.mutableUsers = true;
  users.users.epark = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "networkmanager"
      "storage"
      "audio"
      "video"
      "camera"
      "lp"
      "scanner"
      "docker"
    ];
    packages = [];
    shell = pkgs.zsh;
  };

  systemd.tmpfiles.rules = [
    "d /home/epark/Media 0700 epark users -"
    "d /home/epark/Media/Screenshots 0700 epark users -"
  ];

  fonts.packages = with pkgs; [
    nerd-fonts.fira-code
  ];

  virtualisation.docker.enable = true;

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };

  services.ollama = {
    enable = true;
  };

  services.mullvad-vpn.enable = true;
  services.homepage-dashboard = {
    enable = true;
    settings = {
      title = "Homepage";
    };
    environmentFiles = [
      (/. + config.sops.secrets."homepage/google_calendar_api_url".path)
    ];
    widgets = [
      {
        openmeteo = {
          label = "Aachen";
          latitude = 50.77535;
          longitude = 6.08389;
          timezone = "Europe/Berlin";
          units = "metric";
          cache = 5;
          format = {
            maximumFractionDigits = 1;
          };
        };
      }
      {
        datetime = {
          text_size = "xl";
          format = {
            timeStyle = "short";
            dateStyle = "short";
          };
        };
      }
      {
        greeting = {
          text_size = "xl";
          text = "Hello!";
        };
      }
      {
        search = {
          provier = "google";
          focus = true;
          showSearchSuggestions = true;
          target = "_blank";
        };
      }
    ];
    services = [
      {
        Calendars = [
          {
            Personal = {
              widget = {
                type = "calendar";
                integrations = [
                  {
                    type = "ical";
                    name = "Google";
                    url = "{{HOMEPAGE_VAR_GOOGLE_CALENDAR_API_URL}}";
                  }
                ];
              };
            };
          }
          {
            Agenda = {
              widget = {
                type = "calendar";
                view = "agenda";
                showTime = true;
                integrations = [
                  {
                    type = "ical";
                    name = "Google";
                    url = "{{HOMEPAGE_VAR_GOOGLE_CALENDAR_API_URL}}";
                  }
                ];
              };
            };
          }
        ];
      }
    ];
    bookmarks = [
      {
        AI = [
          {
            OpenAI = [
              {
                abbr = "OP";
                icon = "openai.png";
                href = "https://openai.com";
              }
            ];
          }
          {
            Gemini = [
              {
                abbr = "GE";
                icon = "google-gemini.png";
                href = "https://google.com";
              }
            ];
          }
        ];
      }
      {
        Social = [
          {
            WhatsApp = [
              {
                abbr = "WA";
                icon = "si-whatsapp";
                href = "https://whatsapp.com";
              }
            ];
          }
          {
            LinkedIn = [
              {
                abbr = "LI";
                icon = "si-linkedin";
                href = "https://linkedin.com";
              }
            ];
          }
        ];
      }
      {
        Media = [
          {
            Crunchyroll = [
              {
                abbr = "CR";
                icon = "crunchyroll.png";
                href = "https://crunchyroll.com";
              }
            ];
          }
          {
            YouTube = [
              {
                abbr = "YT";
                icon = "si-youtube";
                href = "https://www.youtube.com/";
              }
            ];
          }
        ];
      }
      {
        Nix = [
          {
            MyNixOS = [
              {
                abbr = "MY";
                icon = "nixos.png";
                href = "https://mynixos.com";
              }
            ];
          }
          {
            NixOS = [
              {
                abbr = "NI";
                icon = "nixos.png";
                href = "https://nixos.org";
              }
            ];
          }
          {
            NixOSWiki = [
              {
                abbr = "WI";
                icon = "nixos.png";
                href = "https://nixos.org";
              }
            ];
          }
        ];
      }
      {
        Android = [
          {
            FydeOS = [
              {
                abbr = "SF";
                icon = "mdi-android";
                href = "https://fydeos.io";
              }
            ];
          }
        ];
      }
    ];
  };

  system.stateVersion = "25.05";
}
