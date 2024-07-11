{
  config,
  pkgs,
  lib,
  ...
}: {
  home.username = "andre";
  home.homeDirectory = "/home/andre";

  home.packages = with pkgs; [
    gupnp-tools # SSDP CLI
    hyperfine
  ];

  programs.bash = {
    enable = true;
    shellAliases = let
      eza-sort-args = "--git --group --group-directories-first --header --sort=extension";
    in {
      ll = "eza -l ${eza-sort-args}";
      l = "eza -la ${eza-sort-args}";
      ws = "rg --files-with-matches '[^\n]\z'";
    };
  };

  programs.fzf = {
    enable = true;
    enableBashIntegration = true;
  };

  programs.git = {
    enable = true;
    userName = "André Oliveira";
    userEmail = "p32blo@gmail.com";
    aliases = {
      st = "status";
      co = "checkout";
      br = "branch --column";
      tree = "log --graph --oneline --decorate";
    };
    extraConfig = {
      push = {
        autoSetupRemote = true;
      };
      rerere = {
        enable = true;
      };
      init = {
        defaultBranch = "main";
      };
      diff = {
        algorithm = "histogram";
      };
      branch = {
        sort = "-committerdate";
      };
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
      # Only temporary. Change after laptop format.
      {
        condition = "gitdir:~/Documents/";
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
      "qube-internal-tools" = {
        user="qbetter";
        hostname = "192.168.154.91";
        identityFile = "~/.ssh/id_rsa";
      };
    };
  };

  home.stateVersion = "24.05";
  programs.home-manager.enable = true;
}
