{...}: {
  nixpkgs.config.allowUnfree = true;

  nix.settings.experimental-features = ["flakes" "nix-command"];

  system.stateVersion = "23.11";
}
