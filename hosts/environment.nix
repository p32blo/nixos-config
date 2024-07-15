{
  pkgs,
  ...
}: {
  environment = {
    systemPackages = with pkgs; [
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

    variables = {
      EDITOR = "vim";
      VISUAL = "vim";
    };
  };

  nix.settings.experimental-features = ["nix-command" "flakes"];
  nix.optimise.automatic = true;
}
