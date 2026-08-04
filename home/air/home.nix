{
  lib,
  pkgs,
  ...
}: let
  alacrittyThemeSwitcher = "${pkgs.writeShellApplication {
    name = "alacritty-theme";
    runtimeInputs = [pkgs.coreutils];
    text = builtins.readFile ../alacritty/theme-switcher.sh;
  }}/bin/alacritty-theme";
in {
  imports = [
    ../shared.nix
    ../development.nix
    # ./gui.nix # Use when all packages are proven to work
  ];

  home.packages = with pkgs; [
    # fonts
    nerd-fonts.fira-code

    # macos

    # Not using for now
    # raycast

    # Apps
    unstable.obsidian
    discord
    unstable.dbeaver-bin
    unstable.zed-editor
    vscode-extensions.ms-python.debugpy
    unstable.zig

    # Not working in 25.11
    # blender
    # firefox
    # unstable.gimp
    unstable.bruno

    # Dev
    nodejs
    (pulumi.withPackages (
      ps:
        with ps; [
          pulumi-nodejs
          pulumi-aws-native
        ]
    ))
    flyctl

    # Unix Tools
    unixtools.watch
  ];

  programs.alacritty = {
    enable = true;
    settings = {
      general = {
        import = [
          "~/.config/alacritty/theme.toml"
        ];
        live_config_reload = true;
      };
      font = {
        normal = {
          family = "FiraCode Nerd Font";
          style = "Regular";
        };
        bold = {
          family = "FiraCode Nerd Font";
          style = "Bold";
        };
        italic = {
          family = "FiraCode Nerd Font";
          style = "Italic";
        };
        size = 12.0;
      };
    };
  };

  programs.nix-index.enable = true;
  programs.nix-index-database.comma.enable = true;

  home.file = {
    ".config/alacritty/catppuccin-latte.toml" = {
      source = ../alacritty/catppuccin-latte.toml;
    };

    ".config/alacritty/catppuccin-mocha.toml" = {
      source = ../alacritty/catppuccin-mocha.toml;
    };
  };

  home.activation.setAlacrittyTheme = lib.hm.dag.entryAfter ["writeBoundary"] ''
    ${alacrittyThemeSwitcher}
  '';

  launchd.agents.alacritty-theme = {
    enable = true;
    config = {
      ProgramArguments = [
        "${pkgs.dark-mode-notify}/bin/dark-mode-notify"
        "${alacrittyThemeSwitcher}"
      ];
      RunAtLoad = true;
      KeepAlive = true;
      StandardOutPath = "/tmp/alacritty-theme.log";
      StandardErrorPath = "/tmp/alacritty-theme.log";
    };
  };

  # Don't add this to rpi4 since it is very big (> 1 Gb)
  programs.yazi = {
    enable = true;
    enableFishIntegration = true;
    package = pkgs.yazi.override {
      extraPackages = with pkgs; [
        ueberzugpp
      ];
    };
  };

  home.username = "andre";
  home.homeDirectory = "/Users/andre";

  home.stateVersion = "24.05";
  programs.home-manager.enable = true;
}
