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
    "/boot/rpi" = {
      device = "/dev/disk/by-label/FIRMWARE";
      fsType = "FAT16";
      options = ["noatime"];
    };
  };

  swapDevices = [
    {
      device = "/var/lib/swapfile";
      size = 2 * 1024;
    }
  ];

  hardware.enableRedistributableFirmware = true;
}
