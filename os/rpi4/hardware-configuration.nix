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
    initrd = {
      availableKernelModules = [
        "xhci_pci"
        "usbhid"
        "usb_storage"
      ];
    };
    loader = {
      grub.enable = false;
      generic-extlinux-compatible.enable = true;
    };
    # zswap = {
    #   enable = true;
    #   maxPoolPercent = 20;
    # };
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
    "/tmp" = {
      device = "/dev/disk/by-label/NIX_STORE";
      fsType = "btrfs";
      options = ["subvol=@tmp" "compress=zstd" "noatime"];
    };
    "/swap" = {
      device = "/dev/disk/by-label/NIX_STORE";
      fsType = "btrfs";
      options = ["subvol=@swap" "noatime"];
    };
  };

  swapDevices = [
    {
      device = "/swap/swapfile";
      size = 4 * 1024; # 4GB
    }
  ];

  hardware.enableRedistributableFirmware = true;
}
