{pkgs, ...}: {
  home.packages = with pkgs; [
    # Rust Dev
    bacon
    # sccache
    gh
    awscli2
    #rustc # nightly rust is needed
    #cargo
    # lld

    # Docker
    dive
  ];
}
