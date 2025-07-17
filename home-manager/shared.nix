{pkgs, ...}: {
  fonts.fontconfig.enable = true;

  home.packages = with pkgs; [
    rlwrap
    du-dust
    duf
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
    bashrcExtra = ''
      export PATH=$PATH:/nix/var/nix/profiles/default/bin/
      . "$HOME/.cargo/env"
    '';
    enableCompletion = false;
  };

  programs.fish = {
    enable = true;
    shellAliases = {
      ws = "rg --files-with-matches '[^\n]\z'";
    };
    interactiveShellInit = ''
      set fish_greeting # Disable greeting
      source "$HOME/.cargo/env.fish"
      eval "$(/opt/homebrew/bin/brew shellenv)"
      export RUSTC_WRAPPER=sccache
      alias docker=podman
    '';
  };

  programs.direnv = {
    enable = true;
    #enableFishIntegration = true;
    nix-direnv = {
      enable = true;
    };
  };

  programs.helix = {
    enable = true;
    defaultEditor = true;
    extraPackages = with pkgs; [
      golangci-lint-langserver
    ];
    settings = {
      editor = {
        lsp.display-inlay-hints = true;
      };
    };
    languages = {
      language = [
        {
          name = "templ";
          language-servers = ["templ" "tailwindcss-ls"];
          auto-format = true;
        }
        {
          name = "nix";
          language-servers = ["nixd"];
          formatter = {
            command = "alejandra";
            args = ["-"];
          };
          auto-format = true;
        }
        {
          name = "go";
          auto-format = true;
        }
        {
          name = "sql";
          language-servers = ["sqruff"];
          formatter = {
            command = "sqruff";
            args = ["fix" "-"];
          };
          auto-format = true;
        }
      ];
      language-server = {
        nixd = {
          command = "nixd";
        };
        rust-analyzer = {
          config.check.command = "clippy";
        };
      };
    };
  };

  programs.lesspipe.enable = true;

  programs.fzf = {
    enable = true;
    enableFishIntegration = true;
  };

  programs.zoxide = {
    enable = true;
    enableFishIntegration = true;
  };

  programs.starship = {
    enable = true;
    enableFishIntegration = true;
  };

  programs.zellij = {
    enable = true;
    package = pkgs.unstable.zellij;
    enableFishIntegration = true;
    settings = {
      default_mode = "locked";
      default_layout = "default"; # change to "compact" later
      pane_frames = false;
      ui.pane_frames.rounded_corners = true;
      default_shell = "fish";
      show_startup_tips = false;
    };
  };

  programs.eza = {
    enable = true;
    enableFishIntegration = true;
    extraOptions = ["--git" "--group" "--group-directories-first" "--header" "--sort=extension"];
  };

  programs.bat.enable = true;
  programs.htop.enable = true;
  programs.btop.enable = true;
  programs.ripgrep.enable = true;
  programs.fd.enable = true;
  programs.jq.enable = true;
  programs.lazygit.enable = true;

  home.file = {
    ".config/starship.toml" = {
      source = ./starship/starship.toml;
      force = true;
    };
    ".config/git/ignore".text = ''
      .DS_Store
    '';
  };

  programs.jujutsu = {
    enable = true;
    package = pkgs.unstable.jujutsu;
    settings = {
      "$schema" = "https://jj-vcs.github.io/jj/latest/config-schema.json";
      user = {
        name = "André Oliveira";
        email = "p32blo@gmail.com";
      };
      "--scope" = [
        {
          "--when" = {
            repositories = ["~/Work"];
          };
          user = {
            email = "andre@green-got.com";
          };
        }
      ];

      ui.default-command = "log";
      revset-aliases = {
        "wip()" = "description(glob:'wip:*')";
      };
      git.private-commits = "wip()";
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
      core = {
        excludesfile = "~/.config/git/ignore";
      };
    };
    includes = [
      {
        condition = "gitdir:~/Work/";
        contents = {
          user = {
            name = "André Oliveira";
            email = "andre@green-got.com";
          };
        };
      }
    ];
  };
}
