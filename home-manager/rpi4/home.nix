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
    devenv
  ];

  home.stateVersion = "24.05";
  programs.home-manager.enable = true;

  home.pointerCursor = {
    x11.enable = true;
    name = "DMZ-White";
    size = 16;
    package = pkgs.vanilla-dmz;
    gtk.enable = true;
  };
}
