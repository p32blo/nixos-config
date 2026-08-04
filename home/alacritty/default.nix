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
  home.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
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
          family = "JetBrainsMono Nerd Font";
          style = "Light";
        };
        bold = {
          family = "JetBrainsMono Nerd Font";
          style = "Medium";
        };
        italic = {
          family = "JetBrainsMono Nerd Font";
          style = "Light Italic";
        };
        bold_italic = {
          family = "JetBrainsMono Nerd Font";
          style = "Medium Italic";
        };
        glyph_offset = {
          x = 0;
          y = 1;
        };
        size = 13.0;
      };
      colors = {
        draw_bold_text_with_bright_colors = false;
      };
      terminal = {
        shell = {
          program = "${pkgs.fish}/bin/fish";
        };
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
