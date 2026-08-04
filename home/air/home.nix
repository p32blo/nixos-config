{pkgs, ...}: {
  imports = [
    ../shared.nix
    ../development.nix
    ../alacritty
    # ./gui.nix # Use when all packages are proven to work
  ];

  home.packages = with pkgs; [
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

  programs.nix-index.enable = true;
  programs.nix-index-database.comma.enable = true;

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

  home.sessionVariables = {
    LANG = "en_US.UTF-8";
    LC_CTYPE = "en_US.UTF-8";
  };

  home.stateVersion = "24.05";
  programs.home-manager.enable = true;
}
