{
  config,
  pkgs,
  ...
}: {
  home.username = "andre";
  home.homeDirectory = "/home/andre";

  home.packages = with pkgs; [
    blender
    gimp
    vlc
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
