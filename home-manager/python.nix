{pkgs, ...}: {
  home.packages = with pkgs; [
    isort
    yapf
  ];
  programs.poetry.enable = true;
}
