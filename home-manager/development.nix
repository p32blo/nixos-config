{pkgs, ...}: {
  home.packages = with pkgs; [
    # Python Dev
    isort
    yapf

    # Qube UI Projects
    nodejs_22
  ];

  # Python Dev
  programs.poetry.enable = true;

  # Obsidian export plugin
  programs.pandoc.enable = true;
}
