{pkgs, ...}: {
  programs.zellij = {
    enable = true;
    package = pkgs.unstable.zellij;
    enableFishIntegration = false;
    settings = {
      default_mode = "locked";
      default_layout = "compact"; # change to "compact" later
      pane_frames = false;
      theme = "catppuccin-latte";
      theme_dark = "catppuccin-mocha";
      theme_light = "catppuccin-latte";
      ui.pane_frames.rounded_corners = true;
      default_shell = "fish";
      show_startup_tips = false;
      themes = {
        "catppuccin-latte" = {
          fg = [
            76
            79
            105
          ];
          bg = [
            239
            241
            245
          ];
          black = [
            220
            224
            232
          ];
          red = [
            210
            15
            57
          ];
          green = [
            64
            160
            43
          ];
          yellow = [
            223
            142
            29
          ];
          blue = [
            30
            102
            245
          ];
          magenta = [
            136
            57
            239
          ];
          cyan = [
            4
            165
            229
          ];
          white = [
            76
            79
            105
          ];
          orange = [
            254
            100
            11
          ];
        };
        "catppuccin-mocha" = {
          fg = [
            205
            214
            244
          ];
          bg = [
            30
            30
            46
          ];
          black = [
            17
            17
            27
          ];
          red = [
            243
            139
            168
          ];
          green = [
            166
            227
            161
          ];
          yellow = [
            249
            226
            175
          ];
          blue = [
            137
            180
            250
          ];
          magenta = [
            203
            166
            247
          ];
          cyan = [
            137
            220
            235
          ];
          white = [
            205
            214
            244
          ];
          orange = [
            250
            179
            135
          ];
        };
      };
      plugins = {
        "compact-bar" = {
          _props = {
            location = "zellij:compact-bar";
          };
          tooltip = "F1";
        };
      };
    };
  };
}
