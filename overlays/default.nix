{inputs, ...}: [
  (final: prev: {
    local = import ../pkgs {
      pkgs = final;
    };
  })

  (final: prev: {
    unstable = import inputs.nixpkgs-unstable {
      system = prev.system;
      config.allowUnfree = true;
    };
  })
]
