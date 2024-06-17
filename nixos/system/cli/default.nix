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
    xclip
    ripgrep
    fzf
    fd
    zoxide
    usbutils
    nushell
    wezterm
    starship
  ];

  users.defaultUserShell = pkgs.nushell;
  environment.shells = with pkgs; [nushell];
}
