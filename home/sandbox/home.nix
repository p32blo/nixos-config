{lib, ...}: {
  imports = [
    ../shared.nix
  ];

  home.username = "root";
  home.homeDirectory = "/root";
  home.stateVersion = "24.05";
  programs.home-manager.enable = true;

  programs.jujutsu.settings = {
    user.email = lib.mkForce "andre@green-got.com";
    "--scope" = lib.mkForce [
      {
        "--when".repositories = [
          "/workspace/nixos-anywhere"
          "/workspace/nixos-config"
        ];
        user.email = "p32blo@gmail.com";
      }
    ];
  };

  programs.git = {
    settings.user.email = lib.mkForce "andre@green-got.com";
    includes = lib.mkForce [
      {
        condition = "gitdir:/workspace/nixos-anywhere/";
        contents.user.email = "p32blo@gmail.com";
      }
      {
        condition = "gitdir:/workspace/nixos-config/";
        contents.user.email = "p32blo@gmail.com";
      }
    ];
  };

  targets.genericLinux.enable = true;
}
