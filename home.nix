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
    mqtt-explorer
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
    includes = [
      {
        condition = "gitdir:~/Work/";
        contents = {
          user = {
            name = "André Oliveira";
            email = "andre.oliveira@q-better.com";
          };
        };
      }
    ];
  };

  home.stateVersion = "23.11";
  programs.home-manager.enable = true;
}
