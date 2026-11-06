{pkgs, ...}: {
  imports = [
    ../shared.nix
  ];

  home.username = "andre";
  home.homeDirectory = "/home/andre";

  home.packages = with pkgs; [
    devenv
    btrfs-progs
  ];

  home.stateVersion = "24.05";
  programs.home-manager.enable = true;

  home.sessionVariables = {
    TERM = "xterm-256color";
  };
}
