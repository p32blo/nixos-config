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
    noto-fonts-emoji
    fira-code-nerdfont

    # Apps
    unstable.obsidian
    blender
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

  home.username = "andre";
  home.homeDirectory = "/Users/andre";

  home.stateVersion = "24.05";
  programs.home-manager.enable = true;
}
