{...}: {
  # Set your time zone.
  time.timeZone = "Europe/Lisbon";

  # Configure console keymap
  console.keyMap = "pt-latin1";

  # Select internationalisation properties.
  i18n = {
    defaultLocale = "en_GB.UTF-8";
    extraLocaleSettings = {
      LC_ALL = "en_GB.UTF-8";
      LC_CTYPE = "en_GB.UTF-8";
    };
  };
}
