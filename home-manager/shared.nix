{pkgs, ...}: {
  home.packages = with pkgs; [
    rlwrap
    du-dust
    rsync
    file
    mtr
    alejandra
    # gupnp-tools # SSDP CLI (disabled - it brings gtk which is to heavy)
    hyperfine
    neofetch
    deadnix
    statix
    nh
    nix-tree
    nixd
  ];

  programs.bash = {
    enable = true;
    historyControl = ["ignoredups" "ignorespace"]; # change to "ignoreboth" on next Release
    shellAliases = {
      ws = "rg --files-with-matches '[^\n]\z'";
    };
  };

  programs.direnv = {
    enable = true;
    enableBashIntegration = true;
    nix-direnv = {
      enable = true;
    };
  };

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    extraConfig = ''
      set mouse = "a";
    '';
    coc = {
      enable = true;
      settings = {
        languageserver = {
          nix = {
            command = "nixd";
            filetypes = ["nix"];
          };
        };
      };
    };

    plugins = let
      yankring = pkgs.vimPlugins.YankRing-vim.overrideAttrs {
        sourceRoot = null;
      };
    in
      with pkgs.vimPlugins; [
        vim-sensible
        vim-gitgutter
        vim-airline
        yankring
      ];
  };

  programs.lesspipe.enable = true;

  programs.fzf = {
    enable = true;
    enableBashIntegration = true;
  };

  programs.zoxide = {
    enable = true;
    enableBashIntegration = true;
  };

  programs.starship = {
    enable = true;
    enableBashIntegration = true;
  };

  programs.zellij = {
    enable = true;
    enableBashIntegration = true;
    settings = {
      default_mode = "locked";
      default_layout = "compact";
      pane_frames = false;
      ui.pane_frames.rounded_corners = true;
    };
  };

  programs.eza = {
    enable = true;
    enableBashIntegration = true;
    extraOptions = ["--git" "--group" "--group-directories-first" "--header" "--sort=extension"];
  };

  programs.bat.enable = true;
  programs.htop.enable = true;
  programs.btop.enable = true;
  programs.ripgrep.enable = true;
  programs.fd.enable = true;
  programs.jq.enable = true;

  home.file = {
    ".config/starship.toml" = {
      source = ./starship/starship.toml;
      force = true;
    };
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
      "qube-dev" = {
        user = "ec2-user";
        hostname = "52.18.49.5";
        identityFile = "~/.ssh/qube-dev.pem";
      };
      "qube-test" = {
        user = "ec2-user";
        hostname = "18.202.143.241";
        identityFile = "~/.ssh/qube-test.pem";
      };
      "qube-prod" = {
        user = "ec2-user";
        hostname = "54.170.87.16";
        identityFile = "~/.ssh/qube-prod.pem";
      };
      "qube-prod-jump" = {
        user = "ec2-user";
        hostname = "18.203.87.64";
        identityFile = "~/.ssh/qube-prod.pem";
      };
      "qube-ssh" = {
        user = "sshtunnel";
        hostname = "ssh.qube.q-better.com";
        port = 1022;
      };
    };
  };
}
