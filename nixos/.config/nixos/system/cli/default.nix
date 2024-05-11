{
  pkgs,
  inputs,
  systemSettings,
  ...
}: {
  imports = [
    if systemSettings.system == "x86_64-linux"
    then [
      ./linux.nix
    ]
    else [];

    environment.systemPackages = with pkgs; [
      neovim
      git
      curl
      wget
      gnumake
      stow
      clang
      ripgrep
      fzf
      zoxide
    ];
  ];

  environment.shells = with pkgs; [nushell];
  programs.nushell.enable = true;
}
