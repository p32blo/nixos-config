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
      ];
      language-server.nixd.command = "nixd";
    };
  };

  programs.neovim = {
    enable = true;
    viAlias = true;
    extraConfig = ''
      set mouse=a
      set number
    '';
    extraLuaConfig = ''
      vim.g.mapleader = ' '

      vim.api.nvim_set_keymap('n', 'ç', ':', { noremap = true, silent = false })
      vim.api.nvim_set_keymap('v', 'ç', ':', { noremap = true, silent = false })

      vim.api.nvim_set_keymap('n', '<leader>o', 'o<esc>', { noremap = true, silent = false })
      vim.api.nvim_set_keymap('n', '<leader>O', 'O<esc>', { noremap = true, silent = false })

      vim.api.nvim_set_keymap('n', '<C-s>', ':w<CR>', { noremap = true, silent = false })
    '';
    coc = {
      enable = true;
      settings = {
        languageserver = {
          nix = {
            command = "nixd";
            filetypes = ["nix"];
          };
          python = {
            command = "pyright";
            filetypes = ["python"];
          };
          go = {
            command = "gopls";
            filetypes = ["go" "gomod"];
          };
        };
      };
    };

    # TODO: Remove override after PR #389256 goes to unstable
    plugins = with pkgs.vimPlugins; [
      vim-sensible
      vim-gitgutter
      vim-airline
      telescope-nvim
      undotree
      harpoon
      vim-dadbod
      vim-dadbod-ui
      nvim-treesitter-parsers.templ
    ];

    extraPackages = with pkgs; [
      nixd
      pyright
      python311Packages.pylint
      python311Packages.pylint-django
      gopls
    ];
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

  programs.yazi = {
    enable = true;
    enableFishIntegration = true;
    package = pkgs.yazi.override {
      extraPackages = [
        pkgs.ueberzugpp
      ];
    };
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
