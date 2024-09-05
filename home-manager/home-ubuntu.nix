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

    unstable.mqtt-explorer # Move to stable on next release
    ungoogled-chromium

    # A temp fix for a crash when opening Downloads
    gnome.nautilus
    gnome.eog
    gnome.file-roller
    gnome.gnome-terminal
    papers

    remmina
  ];

  home.file = {
    ".config/MQTT-Explorer/settings.json" = {
      source = ./mqtt-explorer/settings.json;
      force = true;
    };
  };

  home.username = "andre";
  home.homeDirectory = "/home/andre";

  home.stateVersion = "24.05";
  programs.home-manager.enable = true;

  targets.genericLinux.enable = true;
}
