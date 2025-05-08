{
  config,
  pkgs,
  nixgl,
  ...
}: {
  imports = [
    ./shared.nix
    # ./development.nix
    # ./gui.nix # Use when all packages are proven to work
  ];
  nixpkgs.config.allowUnfree = true;

  nixGL.packages = nixgl.packages;
  nixGL.defaultWrapper = "mesa";
  nixGL.offloadWrapper = "nvidiaPrime";
  nixGL.installScripts = ["mesa" "nvidiaPrime"];

  home.packages = with pkgs; [
    lazydocker

    noto-fonts-emoji
    fira-code-nerdfont

    # unstable.obsidian
    # librewolf

    # spotify
    # discord

    # gimp-with-plugins
    # wireshark
    # vlc
    # (config.lib.nixGL.wrap blender)
    # (config.lib.nixGL.wrap rpi-imager)

    # unstable.bruno
    # mqtt-explorer

    # remmina
  ];

  programs = {
    alacritty = {
      enable = true;
      package = config.lib.nixGL.wrap pkgs.alacritty;
    };
  };

  # dconf.settings = {
  #   "com/github/stunkymonkey/nautilus-open-any-terminal" = {
  #     terminal = "gnome-terminal";
  #   };
  # };

  #  home.file = {
  #    ".config/MQTT-Explorer/settings.json" = {
  #      source = ./mqtt-explorer/settings.json;
  #      force = true;
  #    };
  #    ".icons/default" = {
  #      source = "${pkgs.vanilla-dmz}/share/icons/Vanilla-DMZ";
  #    };
  #  };

  home.username = "p32blo";
  home.homeDirectory = "/home/p32blo";

  home.stateVersion = "24.05";
  programs.home-manager.enable = true;

  targets.genericLinux.enable = true;
}
