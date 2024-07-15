{
  pkgs,
  ...
}: {
  home = {
    username = "andre";
    homeDirectory = "/home/andre";

    packages = with pkgs; [
      rlwrap
      file
      mtr
      alejandra
      gupnp-tools # SSDP CLI
      hyperfine
      neofetch
      deadnix
      statix
    ];

    file = {
      ".config/starship.toml" = {
        source = ./starship/starship.toml;
        force = true;
      };
    };

    home.stateVersion = "24.05";
    home.enableNixpkgsReleaseCheck = false;
  };

  programs = {
    home-manager.enable = true;

    bat = {
      enable = true;
    };

    htop = {
      enable = true;
    };

    ripgrep = {
      enable = true;
    };

    fd = {
      enable = true;
    };

    jq = {
      enable = true;
    };

    lesspipe = {
      enable = true;
    };

    bash = {
      enable = true;
      historyControl = ["ignoredups" "ignorespace"]; # change to "ignoreboth" on next Release
      shellAliases = {
        ws = "rg --files-with-matches '[^\n]\z'";
      };
    };

    fzf = {
      enable = true;
      enableBashIntegration = true;
    };

    zoxide = {
      enable = true;
      enableBashIntegration = true;
    };

    starship = {
      enable = true;
      enableBashIntegration = true;
    };

    zellij = {
      enable = true;
      enableBashIntegration = true;
      settings = {
        default_layout = "compact";
        pane_frames = false;
        ui.pane_frames.rounded_corners = true;
      };
    };

    eza = {
      enable = true;
      enableBashIntegration = true;
      extraOptions = ["--git" "--group" "--group-directories-first" "--header" "--sort=extension"];
    };

    git = {
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

    ssh = {
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
        "qube-internal-tools-vpn" = {
          user = "qbetter";
          hostname = "192.168.154.91";
          identityFile = "~/.ssh/id_rsa";
        };
      };
    };
  };
}
