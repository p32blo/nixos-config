{
  config,
  pkgs,
  lib,
  ...
}: let
  user = "andre";
  password = "andre";
  hostname = "rpi4";
in {
  imports = [
    ./hardware-configuration.nix
    ../locale.nix
    ../networking.nix
    ../environment.nix
  ];

  networking.hostName = hostname;

  # In order to enable exit node for tailsacale
  #services.tailscale.useRoutingFeatures = "both";

  nix.settings.trusted-users = [
    "root"
    "andre"
  ];

  time.timeZone = lib.mkForce null;

  users = {
    mutableUsers = false;
    users."${user}" = {
      isNormalUser = true;
      password = password;
      extraGroups = ["wheel" "podman"];
    };
  };

  # # systemd.tmpfiles.rules = [
  # #   "d /home/andre 0711 andre users -"
  # # ];

  # hardware.raspberry-pi."4".fkms-3d.enable = true;
  # hardware.raspberry-pi."4".bluetooth.enable = true;
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  # Needed for passive scanning (AdvertisementMonitor API), used by the Renpho integration
  hardware.bluetooth.settings.General.Experimental = true;

  # programs.niri.enable = true;

  # services.pinchflat = {
  #   enable = true;
  #   mediaDir = "/data/media/youtube";
  #   selfhosted = true;
  #   openFirewall = true;
  # };

  # programs.nix-ld = {
  #   enable = true;
  #   libraries = with pkgs; [
  #     # The missing library causing your error
  #     libxcursor

  #     # Common companion libraries required by graphical binaries
  #     libx11
  #     libxi
  #     ffmpeg
  #   ];
  # };

  nixflix = {
    enable = true;
    # mediaDir = "/home/nixflix/media";
    # stateDir = "/home/nixflix/.state";
    mediaUsers = ["andre"];

    theme = {
      enable = true;
      name = "overseerr";
    };

    # Reverse proxy (choose nginx or caddy, not both)
    # nginx = {
    #   enable = true;
    #   addHostsEntries = true; # Disable this if you have your own DNS configuration
    # };
    # caddy = {
    #   enable = true;
    #   addHostsEntries = true;
    # };

    postgres.enable = true;

    sonarr = {
      enable = true;
      config = {
        apiKey = "9bf58ce2598f984c86cff3f0d2943efa";
        hostConfig.password = "sonarr";
        hostConfig.bindAddress = "0.0.0.0";
      };
      openFirewall = true;
    };

    radarr = {
      enable = true;
      config = {
        apiKey = "48389bb9d9f8babe740b5c75d6977865";
        hostConfig.password = "radarr";
        hostConfig.bindAddress = "0.0.0.0";
      };
      openFirewall = true;
    };

    # recyclarr = {
    #   enable = true;
    #   cleanupUnmanagedProfiles = true;
    # };

    # lidarr = {
    #   enable = true;
    #   config = {
    #     apiKey = "";
    #     hostConfig.password = "";
    #   };
    # };

    torrentClients.qbittorrent = {
      enable = true;
      webuiPort = 8282;
      password = "test123";
      # downloadsDir = "/downloads/torrent";

      # categories = {
      #   movies = "/downloads/torrent/movies";
      #   tv = "/downloads/torrent/tv";
      # };
      openFirewall = true;
      serverConfig = {
        LegalNotice.Accepted = true;
        # The unit overwrites qBittorrent.conf with this file on every start, so
        # anything set only in the web UI is lost on restart. Keep these here.
        # One active torrent at a time so a restart cannot saturate the SD card.
        BitTorrent.Session = {
          QueueingSystemEnabled = true;
          MaxActiveDownloads = 1;
          MaxActiveUploads = 1;
          MaxActiveTorrents = 1;
          # Seeding limits: stop a torrent when any of these is reached.
          GlobalMaxRatio = 1;
          GlobalMaxSeedingMinutes = 1440; # total seeding time (24 h)
          GlobalMaxInactiveSeedingMinutes = 1440; # inactive seeding time (24 h)
          ShareLimitAction = "Stop";
        };
        Preferences = {
          WebUI = {
            Username = "admin";
            LocalHostAuth = false;
            Address = "*";
            Password_PBKDF2 = "@ByteArray(j6D9vTrWjOmw5j02ASIXAQ==:+DScFwqKrXArZoqNq7winYNX0CJroYrWZzbis9OniYzRgVWZYl1vNwvyMpp2cTdITbiGyuWvrB0fpFcUZMVwuQ==)";
          };
          General.Locale = "en";
        };
      };
    };

    prowlarr = {
      enable = true;
      config = {
        apiKey = "658ddb8742e6257dc7d1a7bf400cb5fe";
        hostConfig.password = "prowlarr";
        hostConfig.bindAddress = "0.0.0.0";
        indexers = [
          {
            name = "The Pirate Bay";
          }
          {
            name = "LimeTorrents";
          }
          # {
          #   name = "NzbPlanet";
          #   apiKey = "ebacee80a26ca2424574dca206e2c84e";
          # }
        ];
      };

      openFirewall = true;
    };

    jellyfin = {
      enable = true;
      package = pkgs.unstable.jellyfin;
      apiKey = "d1992334d2de1f24dc75e2cccf221406";
      network.localNetworkAddresses = ["0.0.0.0"];
      # cacheDir = "/tmp/.cache/jellyfin";

      users = {
        admin = {
          policy.isAdministrator = true;
          password = "jellyfin";
        };
      };
      # encoding = {
      #   enableHardwareEncoding = false;
      # };
      openFirewall = true;
    };

    # seerr = {
    #   enable = true;
    #   apiKey = "NTlhOWFkYTktZWVmMC00NTM3LTg1NjYtMDRiN2Y3NjRjMjI0Cg==";
    #   openFirewall = true;
    # };

    # vpn = {
    #   enable = true;
    #   wgConfFile = "";
    #   accessibleFrom = ["192.168.1.0/24"];
    # };
  };

  services.bazarr = {
    enable = true;
    openFirewall = true;
    group = "media";
  };

  # Crash recovery and out-of-memory priorities (1.8 GB RAM, so the OOM killer is
  # a real possibility). Higher OOMScoreAdjust = killed earlier, lower = killed later.
  systemd.services = {
    # qBittorrent had no restart policy, so a crash left it down until noticed.
    qbittorrent.serviceConfig = {
      Restart = "on-failure";
      RestartSec = "10s";
      OOMScoreAdjust = 500;
    };
    bazarr.serviceConfig.OOMScoreAdjust = 300;
    sshd.serviceConfig.OOMScoreAdjust = -900; # always keep remote access

    # Ask the .NET GC to compact more aggressively and give memory back (0-9).
    # No hard heap limit, so this cannot cause .NET out-of-memory errors.
    prowlarr.environment.DOTNET_GCConserveMemory = "7";
    sonarr.environment.DOTNET_GCConserveMemory = "7";
    radarr.environment.DOTNET_GCConserveMemory = "7";
    jellyfin.environment.DOTNET_GCConserveMemory = "7";
  };

  # services.jellyfin = {
  #   enable = true;
  #   openFirewall = true;
  #   user = "andre";
  # };

  # services.gitea.enable = true;
  # programs.mosh.enable = true;

  # Podman fails if the bind-mount source is missing
  systemd.tmpfiles.rules = ["d /var/lib/homeassistant 0755 root root -"];

  virtualisation = {
    podman = {
      enable = true;
      dockerCompat = true;
      autoPrune.enable = true;
    };

    oci-containers = {
      backend = "podman";
      containers.homeassistant = {
        image = "ghcr.io/home-assistant/home-assistant:2026.11.1";
        autoStart = true;
        volumes = [
          "/var/lib/homeassistant:/config"
          "/run/dbus:/run/dbus:ro" # BlueZ access for the Bluetooth integration
        ];
        extraOptions = [
          "--network=host" # Recommended for mDNS/discovery and device tracking
          "--cap-add=NET_ADMIN" # Bluetooth (BlueZ/HCI)
          "--cap-add=NET_RAW"
          "--oom-score-adj=-500" # keep Home Assistant alive longest
          # "--device=/dev/serial/by-id/usb-Korbit_Zigbee_Dongle-if00:/dev/zigbee" # Example USB pass-through
        ];
      };
    };
  };

  services.journald = {
    storage = "volatile";
    extraConfig = ''
      SystemMaxUse=200M
      RuntimeMaxUse=64M
      MaxLevelStore=info
      RateLimitIntervalSec=30s
      RateLimitBurst=500
      Compress=yes
    '';
  };

  # services.home-assistant = {
  #   enable = true;
  #   # openFirewall = true;
  #   # Inject missing Python packages required by your integrations
  #   extraPackages = ps:
  #     with ps; [
  #       pyatv
  #       getmac
  #       samsungctl
  #       samsungtvws
  #       wakeonlan
  #       ssdp
  #       go2rtc-client
  #       av
  #       aiodhcpwatcher
  #       aiodiscover
  #       async-upnp-client
  #       websockets
  #       gtts
  #     ];
  #   extraComponents = [
  #     # Components required to complete the onboarding
  #     "esphome"
  #     "met"
  #     "radio_browser"
  #     "isal"
  #     "hacs"
  #   ];

  #   config = null;
  #   lovelaceConfig = null;
  #   # configure the path to your config directory
  #   configDir = "/etc/home-assistant";
  # };

  networking.firewall.allowedTCPPorts = [8123];

  environment.systemPackages = with pkgs; [
    libraspberrypi
    raspberrypi-eeprom
    # waybar
    # xwayland-satellite
    # fuzzel
    # mako
    # libcap
  ];

  system.stateVersion = "24.05";
}
