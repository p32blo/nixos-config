{
  config,
  pkgs,
  ...
}: {
  home.username = "andre";
  home.homeDirectory = "/home/andre";

  home.packages = with pkgs; [
    firefox
    thunderbird

    unstable.obsidian
    vscode
    wireshark
    insomnia

    blender
    gimp
    vlc

    spotify
    discord
    rpi-imager
    jetbrains.pycharm-professional
    (callPackage ./mqtt-explorer.nix {})
  ];

  programs.git = {
    enable = true;
    userName = "André Oliveira";
    userEmail = "p32blo@gmail.com";
    aliases = {
      st = "status";
      co = "checkout";
      br = "branch --sort=-committerdate --column";
      tree = "log --graph --oneline --decorate";
    };
  };

  home.stateVersion = "23.11";
  programs.home-manager.enable = true;
}
