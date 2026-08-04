{
  lib,
  pkgs,
  ...
}: let
  alacrittyThemeSwitcher = "${pkgs.writeShellApplication {
    name = "alacritty-theme";
    runtimeInputs = [pkgs.coreutils];
    text = builtins.readFile ./theme-switcher.sh;
  }}/bin/alacritty-theme";
in {
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

  home.file = {
    ".config/alacritty/catppuccin-latte.toml" = {
      source = ./catppuccin-latte.toml;
    };

    ".config/alacritty/catppuccin-mocha.toml" = {
      source = ./catppuccin-mocha.toml;
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
}
