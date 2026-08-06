{
  config,
  pkgs,
  lib,
  inputs,
  ...
}: {
  imports = [
    inputs.nixos-hardware.nixosModules.raspberry-pi-4
  ];

  boot = {
    kernelPackages = pkgs.linuxKernel.packages.linux_rpi4;
    initrd.availableKernelModules = [
      "xhci_pci"
      "usbhid"
      "usb_storage"
    ];
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
    "/boot/rpi" = {
      device = "/dev/disk/by-label/FIRMWARE";
      fsType = "vfat";
      options = ["noatime"];
    };
    "/nix" = {
      device = "/dev/disk/by-label/NIX_STORE";
      fsType = "btrfs";
      options = ["subvol=@nix" "compress=zstd" "noatime"];
      neededForBoot = true;
    };
  };

  # Use `zramSwap` instead of `swapDevices` to
  # reduce writes in the SDCard of the rpi4
  # (previously it was a 2Gb swapfile in /var/lib)
  zramSwap = {
    enable = true;
    memoryPercent = 50;
  };

  hardware.enableRedistributableFirmware = true;
}
