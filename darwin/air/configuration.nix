{
  inputs,
  pkgs,
  ...
}: {
  nixpkgs.hostPlatform = "aarch64-darwin";
  nixpkgs.config.allowUnfree = true;

  system.primaryUser = "andre";
  system.configurationRevision = inputs.self.rev or inputs.self.dirtyRev or null;
  system.stateVersion = 6;

  users.users.andre = {
    name = "andre";
    home = "/Users/andre";
    shell = pkgs.fish;
  };

  environment.systemPackages = with pkgs; [
    curl
    file
    git
    wget
  ];

  environment.shells = [
    pkgs.fish
  ];

  programs.fish.enable = true;

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  nix.optimise.automatic = true;
}
