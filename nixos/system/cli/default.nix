{
  pkgs,
  inputs,
  systemSettings,
  ...
}: {
  imports = [
    #if systemSettings.system == "x86_64-linux"
    #then [
    #  ./linux.nix
    #]
    #else [];
  ];

  environment.systemPackages = with pkgs; [
    neovim
    git
    curl
    wget
    gnumake
    stow
    clang
    lsof
    xclip
    ripgrep
    fzf
    fd
    unzip
    zoxide
    usbutils
    nushell
    wezterm
    alacritty
    starship
  ];

  users.defaultUserShell = pkgs.nushell;
  environment.shells = with pkgs; [nushell];
}
