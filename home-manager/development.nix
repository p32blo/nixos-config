{pkgs, ...}: {
  home.packages = with pkgs; [
    # Python Dev
    isort
    yapf

    # Qube player
    mpg123

    # Qube UI Projects
    nodejs_22

    # Docker
    dive
  ];

  # Python Dev
  programs.poetry.enable = true;

  # Obsidian export plugin
  programs.pandoc.enable = true;
}
