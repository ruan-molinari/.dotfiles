{...}: {
  nixpkgs.config.allowUnfree = true;

  nix.settings.experimental-features = ["flakes" "nix-command"];

  system.stateVersion = "24.11";
}
