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

  programs.firefox.enable = true;
  home.packages = with pkgs; [
    git
    nerdfonts
    zoxide
    wezterm
    starship
    neovim
    nushell
  ];

  programs.gpg.enable = true;

  home.sessionVariables = {
    EDITOR = userSettings.editor;
    FLAKE = config.home.homeDirectory + "./dotfiles/nixos";
  };

  programs.home-manager.enable = true;
  home.stateVersion = "23.11";
}
