{pkgs, ...}: {
  home.packages = with pkgs; [
    # Python Dev
    isort
    yapf

    # Qube player
    mpg123

    # Qube UI Projects
    nodejs_22
  ];

  # Python Dev
  programs.poetry.enable = true;

  # Obsidian export plugin
  programs.pandoc.enable = true;
}
