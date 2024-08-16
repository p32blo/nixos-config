{
  config,
  pkgs,
  lib,
  ...
}: {
  imports = [
    ../shared.nix
  ];

  home.username = "andre";
  home.homeDirectory = "/home/andre";

  home.packages = with pkgs; [
    ungoogled-chromium
    alacritty
  ];

  home.stateVersion = "24.05";
  programs.home-manager.enable = true;
}
