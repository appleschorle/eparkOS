{pkgs, ...}: {
  imports = [
    ./hardware-configuration.nix
    ../../modules/nixos
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

  services.mullvad-vpn.enable = true;
  services.homepage-dashboard = {
    enable = true;
    settings = {
      title = "Homepage";
    };
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
    ];
    bookmarks = [
      {
        AI = [
          {
            OpenAI = [
              {
                abbr = "OP";
                href = "https://openai.com";
              }
            ];
          }
          {
            Gemini = [
              {
                abbr = "GE";
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
                href = "https://whatsapp.com";
              }
            ];
          }
          {
            LinkedIn = [
              {
                abbr = "LI";
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
                href = "https://crunchyroll.com";
              }
            ];
          }
          {
            YouTube = [
              {
                abbr = "YT";
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
                href = "https://mynixos.com";
              }
            ];
          }
          {
            NixOS = [
              {
                abbr = "NI";
                href = "https://nixos.org/";
              }
            ];
          }
          {
            NixOSWiki = [
              {
                abbr = "WI";
                href = "https://wiki.nixos.org/";
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
