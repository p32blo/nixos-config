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

  programs.ssh = {
    enable = true;
    matchBlocks = {
      "qube*.local" = {
        user = "qube";
        extraOptions = {
          StrictHostKeyChecking = "no";
        };
      };
      "qube-gh-action-vpn" = {
        user = "qbetter";
        hostname = "192.168.154.184";
      };
      "qube-ssh" = {
        user = "ec2-user";
        hostname = "ssh.myqube.io"; # this will be changed soon to ssh.qube.q-better.com
        identityFile = "~/.ssh/aws_admin_rsa";
      };
      "qube-dev-aux" = {
        user = "ubuntu";
        hostname = "ec2-3-248-205-52.eu-west-1.compute.amazonaws.com";
        identityFile = "~/.ssh/aws_rsa";
      };
      "qube-preview" = {
        user = "ec2-user";
        hostname = "ec2-34-240-12-31.eu-west-1.compute.amazonaws.com";
        identityFile = "~/.ssh/aws_admin_rsa";
      };
    };
  };

  home.file = {
    ".config/MQTT-Explorer/settings.json" = {
      source = ./mqtt-explorer/settings.json;
      force = true;
    };
  };

  home.stateVersion = "23.11";
  programs.home-manager.enable = true;
}
