{
  config,
  pkgs,
  lib,
  ...
}: {
  # Set your time zone.
  time.timeZone = "Europe/Lisbon";

  # Configure console keymap
  console.keyMap = "pt-latin1";

  # Select internationalisation properties.
  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = "pt_PT.UTF-8";
      LC_IDENTIFICATION = "pt_PT.UTF-8";
      LC_MEASUREMENT = "pt_PT.UTF-8";
      LC_MONETARY = "pt_PT.UTF-8";
      LC_NAME = "pt_PT.UTF-8";
      #LC_NUMERIC = "pt_PT.UTF-8";
      LC_PAPER = "pt_PT.UTF-8";
      LC_TELEPHONE = "pt_PT.UTF-8";
      #LC_TIME = "pt_PT.UTF-8";
    };
  };
}
