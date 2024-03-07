{inputs, ...}: [
  (
    final: prev: import ../pkgs {pkgs = final;}
  )

  (final: prev: {
    unstable = import inputs.nixpkgs-unstable {
      system = final.system;
      config.allowUnfree = true;
    };
  })
]
