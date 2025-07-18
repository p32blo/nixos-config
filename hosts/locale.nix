{...}: {
  # Set your time zone.
  time.timeZone = "Europe/Lisbon";

  # Configure console keymap
  console.keyMap = "pt-latin1";

  # Select internationalisation properties.
  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
      LC_ALL = "pt_PT.UTF-8";
      LC_CTYPE = "pt_PT.UTF-8";
    };
  };
}
