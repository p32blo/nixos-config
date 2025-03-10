{inputs, ...}: [
  (final: prev: {
    local = import ../pkgs {
      pkgs = final;
    };
  })

  (final: prev: {
    unstable = import inputs.nixpkgs-unstable {
      system = final.system;
      config.allowUnfree = true;
    };
  })

  (final: prev: {
    unstable-vlc4 = import inputs.nixpkgs-vlc4 {
      system = final.system;
      config.allowUnfree = true;
    };
  })
]
