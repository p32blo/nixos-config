{
  config,
  pkgs,
  lib,
  ...
}: {
  environment = {
    systemPackages = with pkgs; [
      vim

      wget
      curl
      git
      file
      rlwrap
      rsync

      eza
      bat
      du-dust
      dua
      ripgrep
      fd
      zellij

      htop
      mtr
      jq

      alejandra
    ];
  };

  fonts.packages = with pkgs; [
    corefonts
  ];
  console.font = "Lat2-Terminus16";

  programs.vim.defaultEditor = true;

  programs.fish.enable = true;

  programs.nh = {
    enable = true;
  };

  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = ["nix-command" "flakes"];
  nix.optimise.automatic = true;
}
