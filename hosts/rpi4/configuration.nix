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

  networking = {
    hostName = hostname;
    networkmanager.enable = true;
  };

  time.timeZone = "Europe/Lisbon";

  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "pt_PT.UTF-8";
    LC_IDENTIFICATION = "pt_PT.UTF-8";
    LC_MEASUREMENT = "pt_PT.UTF-8";
    LC_MONETARY = "pt_PT.UTF-8";
    LC_NAME = "pt_PT.UTF-8";
    LC_PAPER = "pt_PT.UTF-8";
    LC_TELEPHONE = "pt_PT.UTF-8";
  };

  console.keyMap = "pt-latin1";

  environment.systemPackages = with pkgs; [
    vim

    wget
    curl
    git
    file

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

  services.openssh.enable = true;
  services.tailscale = {
    enable = true;
    # revert to stable because tailscale is failing to startup
    #package = pkgs.unstable.tailscale;
  };

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
