{
  config,
  pkgs,
  ...
}: {
  imports = [
    ../shared.nix
    ../development.nix
    # ./gui.nix # Use when all packages are proven to work
  ];
  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    # fonts
    nerd-fonts.fira-code

    # macos

    # Not using for now
    # raycast

    # Apps
    blender
    firefox
    unstable.obsidian
    discord

    # Dev
    bruno
    pulumi
    flyctl

    # Unix Tools
    unixtools.watch
  ];

  programs.alacritty = {
    enable = true;
    settings = {
      font = {
        normal = {
          family = "FiraCode Nerd Font";
          style = "Regular";
        };
        bold = {
          family = "FiraCode Nerd Font";
          style = "Bold";
        };
        italic = {
          family = "FiraCode Nerd Font";
          style = "Italic";
        };
        size = 12.0;
      };
    };
  };

  # Don't add this to rpi4 since it is very big (> 1 Gb)
  programs.yazi = {
    enable = true;
    enableFishIntegration = true;
    package = pkgs.yazi.override {
      extraPackages = [
        pkgs.ueberzugpp
      ];
    };
  };

  home.username = "andre";
  home.homeDirectory = "/Users/andre";

  home.stateVersion = "24.05";
  programs.home-manager.enable = true;
}
