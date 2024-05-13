{
  config,
  pkgs,
  inputs,
  userSettings,
  systemSettings,
  ...
}: {
  imports = [
    ./audio.nix
    ./locale.nix
    ./nix.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = systemSettings.hostname;

  networking.networkmanager.enable = true;

  services.blueman.enable = true;
  services.printing.enable = true;
  services.flatpak.enable = true;
  services.ratbagd.enable = true;
  services.input-remapper.enable = true;
  
  users.users.${userSettings.username} = {
    isNormalUser = true;
    description = userSettings.name;
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      nerdfonts
      usbutils
      appimage-run

      libratbag # Configuration library for gaming mice
      piper # GTK frontend for libratbag mouse config daemon

      # TODO: move programming language config to a separate file/module
      # Programming languages/LSPs/tools
      cargo
      rustup
      zig
      zls
      go
      odin
      ols

      (pkgs.python3.withPackages (python-pkgs: [
        python-pkgs.pip
        python-pkgs.pandas
        python-pkgs.requests
      ]))

      nodejs_20
      bun
    ];
  };
}
