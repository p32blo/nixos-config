{inputs, ...}: [
  (final: _prev: {
    local = import ../pkgs {
      pkgs = final;
    };
  })

  (final: _prev: {
    unstable = import inputs.nixpkgs-unstable {
      inherit (final) system;
      config.allowUnfree = true;
    };
  })
]
