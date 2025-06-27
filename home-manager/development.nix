{pkgs, ...}: {
  home.packages = with pkgs; [
    # Rust Dev
    bacon
    sccache

    #rustc # nightly rust is needed
    #cargo
    lld

    # Docker
    dive

    # Podman
    podman
    podman-compose
  ];
}
