{
  config,
  pkgs,
  nixgl,
  ...
}: {
  imports = [
    ../shared.nix
    # ./development.nix
    # ./gui.nix # Use when all packages are proven to work
  ];
  nixpkgs.config.allowUnfree = true;

  nixGL.packages = nixgl.packages;
  nixGL.defaultWrapper = "mesa";
  nixGL.offloadWrapper = "nvidiaPrime";
  nixGL.installScripts = [
    "mesa"
    "nvidiaPrime"
  ];

  home.packages = with pkgs; [
    lazydocker

    noto-fonts-emoji
    fira-code-nerdfont

    unstable.obsidian
    librewolf

    vscodium
    spotify
    discord
  ];

  programs = {
    alacritty = {
      enable = true;
      package = config.lib.nixGL.wrap pkgs.alacritty;
    };
  };

  home.username = "andre";
  home.homeDirectory = "/home/andre";

  home.stateVersion = "24.05";
  programs.home-manager.enable = true;

  targets.genericLinux.enable = true;
}
