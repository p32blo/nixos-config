{
  config,
  pkgs,
  nixgl,
  ...
}: let
  vlc4 = pkgs.unstable-vlc4.vlc4.overrideAttrs (
    oldAttrs: {
      waylandSupport = false;
      src = pkgs.fetchFromGitLab {
        owner = "videolan";
        repo = "vlc";
        rev = "master";
        domain = "code.videolan.org";
        hash = "sha256-XrAz4ywVelu4X4GfZhiszvxPyXL+xN2GbkL3JclHYWM=";
      };
    }
  );
in {
  imports = [
    ./shared.nix
    ./development.nix
    # ./gui.nix # Use when all packages are proven to work
  ];
  nixpkgs.config.allowUnfree = true;

  nixGL.packages = nixgl.packages;
  nixGL.defaultWrapper = "mesa";
  nixGL.offloadWrapper = "nvidiaPrime";
  nixGL.installScripts = ["mesa" "nvidiaPrime"];

  home.packages = with pkgs; [
    lazydocker

    thunderbird
    spotify
    discord

    gimp-with-plugins
    wireshark
    #    vlc
    (config.lib.nixGL.wrap vlc4)
    (config.lib.nixGL.wrap blender)
    (config.lib.nixGL.wrap rpi-imager)

    unstable.obsidian
    unstable.bruno

    mqtt-explorer
    ungoogled-chromium

    # A temp fix for a crash when opening Downloads
    nautilus
    # nautilus-open-any-terminal
    eog
    file-roller
    gnome-terminal
    papers

    remmina
  ];

  # dconf.settings = {
  #   "com/github/stunkymonkey/nautilus-open-any-terminal" = {
  #     terminal = "gnome-terminal";
  #   };
  # };

  home.file = {
    ".config/MQTT-Explorer/settings.json" = {
      source = ./mqtt-explorer/settings.json;
      force = true;
    };
    ".icons/default" = {
      source = "${pkgs.vanilla-dmz}/share/icons/Vanilla-DMZ";
    };
  };

  home.username = "andre";
  home.homeDirectory = "/home/andre";

  home.stateVersion = "24.05";
  programs.home-manager.enable = true;

  targets.genericLinux.enable = true;
}
