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
      #bat
      #du-dust
      #dua
      ripgrep
      fd
      zellij

      htop
      mtr
      jq

      alejandra
      unstable.nh
    ];
  };

  console.font = "Lat2-Terminus16";

  programs.vim.defaultEditor = true;

  nix.settings.experimental-features = ["nix-command" "flakes"];
  nix.optimise.automatic = true;
}
