# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).
{
  ...
}: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ../locale.nix
    ../networking.nix
    ../environment.nix
  ];

  # Use the GRUB 2 boot loader.
  boot = {
    loader.grub = {
      enable = true;
      # boot.loader.grub.efiSupport = true;
      # boot.loader.grub.efiInstallAsRemovable = true;
      # boot.loader.efi.efiSysMountPoint = "/boot/efi";
      # Define on which hard drive you want to install Grub.
      device = "/dev/sda"; # or "nodev" for efi only
      useOSProber = true;
    };

    binfmt.emulatedSystems = ["aarch64-linux"];
  };

  networking.hostName = "nixos"; # Define your hostname.

  # Define a user account. Don't forget to set a password with 'passwd'.
  users.users.andre = {
    isNormalUser = true;
    extraGroups = ["wheel"]; # Enable 'sudo' for the user.
  };

  system.stateVersion = "24.05"; # Did you read the comment?

  virtualisation.virtualbox.guest.enable = true;
}
