{
  config,
  pkgs,
  lib,
  ...
}: {
  home.packages = with pkgs; [
    firefox
    thunderbird
    discord
    spotify

    jetbrains.pycharm-professional
    unstable.vscode
    unstable.obsidian

    insomnia
    unstable.bruno

    # blender
    gimp
    wireshark
    vlc

    rpi-imager
    local.mqtt-explorer
    gssdp-tools # SSDP GUI
    gnome.gnome-remote-desktop
  ];

  home.file = {
    ".config/MQTT-Explorer/settings.json" = {
      source = ./mqtt-explorer/settings.json;
      force = true;
    };
  };
}
