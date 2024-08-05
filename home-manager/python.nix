{pkgs, ...}: {
  home.packages = with pkgs; [
    isort
  ];
  programs.poetry.enable = true;
}
