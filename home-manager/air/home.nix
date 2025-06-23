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

  programs = {
    alacritty = {
      enable = true;
      package = pkgs.alacritty;
    };
  };

  home.username = "andre";
  home.homeDirectory = "/Users/andre";

  home.stateVersion = "24.05";
  programs.home-manager.enable = true;
}
