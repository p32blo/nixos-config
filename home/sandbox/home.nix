{...}: {
  imports = [
    ../shared.nix
  ];

  home.username = "root";
  home.homeDirectory = "/root";
  home.stateVersion = "24.05";
  programs.home-manager.enable = true;
  targets.genericLinux.enable = true;
}
