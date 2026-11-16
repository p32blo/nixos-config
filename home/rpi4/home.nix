{pkgs, ...}: {
  imports = [
    ../shared.nix
  ];

  home.username = "andre";
  home.homeDirectory = "/home/andre";

  # No ../development.nix here and no devenv: they are ~0.7 GB of the closure
  # and disk space is tight on the SD card.
  home.packages = with pkgs; [
    btrfs-progs
  ];

  home.stateVersion = "24.05";
  programs.home-manager.enable = true;

  home.sessionVariables = {
    TERM = "xterm-256color";
  };
}
