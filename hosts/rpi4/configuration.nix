{
  config,
  pkgs,
  lib,
  ...
}: let
  user = "andre";
  password = "andre";
  hostname = "rpi4";
in {

  imports = [
    ../locale.nix
    ../networking.nix
  ];

  boot = {
    kernelPackages = pkgs.linuxKernel.packages.linux_rpi4;
    initrd.availableKernelModules = ["xhci_pci" "usbhid" "usb_storage"];
    loader = {
      grub.enable = false;
      generic-extlinux-compatible.enable = true;
    };
  };

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-label/NIXOS_SD";
      fsType = "ext4";
      options = ["noatime"];
    };
  };

  networking.hostName = hostname;

  environment.systemPackages = with pkgs; [
    vim

    wget
    curl
    git
    file
    rlwrap

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


  users = {
    mutableUsers = false;
    users."${user}" = {
      isNormalUser = true;
      password = password;
      extraGroups = ["wheel"];
    };
  };

  environment.variables.EDITOR = "vim";
  nix.settings.experimental-features = ["nix-command" "flakes"];
  nix.optimise.automatic = true;

  hardware.enableRedistributableFirmware = true;
  system.stateVersion = "24.05";
}
