{pkgs, ...}: {
  home.packages = with pkgs; [
    # Rust Dev
    #rustc # nightly rust is needed
    #cargo

    # Docker
    dive
  ];
}
