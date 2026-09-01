{ config, lib, pkgs, inputs, ... }:

{
  imports =
    [  ];

 boot = {
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
    "/" =
    { device = "/dev/disk/by-label/NIXOS_SD";
      fsType = "ext4";
      options = ["noatime"];
    };

 "/boot/rpi" = {
      device = "/dev/disk/by-label/FIRMWARE";
      fsType = "vfat";
      options = ["noatime"];
    };
    };
  swapDevices = [ ];

  hardware.enableRedistributableFirmware = true;
  #nixpkgs.hostPlatform = lib.mkDefault "aarch64-linux";
}
