{
  config,
  pkgs,
  inputs,
  userSettings,
  systemSettings,
  ...
}: {
  imports = [
    # ./nvim
  ]
  ++ (
    if systemSettings.system == "x86_64-linux"
      then [
        # ./linux
      ]
      else []
  );

  home.username = userSettings.username;
  home.homeDirectory =
    (
      if systemSettings.system == "x86_64-linux"
      then "/home/"
      else "/Users/"
    )
    + userSettings.username;

  programs = {
    gpg.enable = true;
    firefox.enable = true;

    # TODO: set up and config nushell through nix insted of standalone files
    # nushell.enable = true;

    carapace.enable = true;
    carapace.enableNushellIntegration = true;

    starship.enable = true;
  };

  home.packages = with pkgs; [

  ];

  home.sessionVariables = {
    EDITOR = userSettings.editor;
    FLAKE = config.home.homeDirectory + "./dotfiles/nixos";
  };

  programs.home-manager.enable = true;
  home.stateVersion = "23.11";
}
