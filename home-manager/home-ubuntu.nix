{
  config,
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./shared.nix
    ./development.nix
    # ./gui.nix # Use when all packages are proven to work
  ];
  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    thunderbird
    spotify
    discord

    gimp-with-plugins
    wireshark
    vlc
    blender
    rpi-imager

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
