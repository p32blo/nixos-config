{
  config,
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./shared.nix
    # ./gui.nix # Use when all packages are proven to work
  ];
  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    thunderbird
    spotify
    discord

    gimp
    wireshark
    vlc

    unstable.obsidian
    unstable.bruno

    unstable.mqtt-explorer # Move to stable on next release
    ungoogled-chromium

    # A temp fix for a crash when opening Downloads
    gnome.nautilus
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
