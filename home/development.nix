{pkgs, ...}: {
  home.packages = with pkgs; [
    # Nix (large: nixd pulls LLVM). Not installed on hosts that skip this file,
    # like the rpi4, where disk space is tight.
    nixd
    fastfetch

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
