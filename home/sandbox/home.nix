{
  lib,
  pkgs,
  ...
}: {
  imports = [
    ../shared.nix
  ];

  home.username = "root";
  home.homeDirectory = "/root";
  home.stateVersion = "24.05";
  home.sessionVariables = {
    NO_ZELLIJ = "1";
    TERM = "xterm-256color";
  };

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

  # only here because sandbox forces bash on startup
  programs.bash.profileExtra = lib.mkAfter ''
    if [[ $- == *i* && -z ''${BASH_EXECUTION_STRING:-} ]]; then
      exec "$HOME/.nix-profile/bin/fish" --login
    fi
  '';

  programs.fish = {
    plugins = [
      {
        name = "bass";
        src = pkgs.fishPlugins.bass.src;
      }
    ];
    shellInit = ''
      if test -r /etc/profile.d/sandbox-env.sh
        bass source /etc/profile.d/sandbox-env.sh
      end
    '';
  };

  targets.genericLinux.enable = true;
}
