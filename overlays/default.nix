{inputs, ...}: [
  (final: prev: {
    local = import ../pkgs {
      pkgs = final;
    };
  })

  (final: prev: {
    unstable = import inputs.nixpkgs-unstable {
      system = final.stdenv.hostPlatform.system;
      config.allowUnfree = true;
    };
  })
]
