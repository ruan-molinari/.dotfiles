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
    ./virtualisation.nix
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
  
  programs.nix-ld.enable = true;

  virtualisation.docker = {
    enable = true;

    rootless = {
      enable = true;
      setSocketVariable = true;
    };
  };

  users.users.${userSettings.username} = {
    isNormalUser = true;
    description = userSettings.name;
    extraGroups = [ "networkmanager" "wheel" "docker" ];
    packages = with pkgs; [
      nerdfonts
      usbutils
      appimage-run
      readline
      zlib
      zlib.dev

      pkg-config # needed for openssl
      openssl # needed for rust
      openssl.dev
          
      libratbag # Configuration library for gaming mice
      piper # GTK frontend for libratbag mouse config daemon

      # TODO: move programming language config to a separate file/module
      # Programming languages/LSPs/tools
      cargo
      rustup
      # zig
      zls
      go
      # odin
      # ols

      (pkgs.python3.withPackages (python-pkgs: [
        python-pkgs.pip
        python-pkgs.pandas
        python-pkgs.requests
      ]))

      nodejs_20
      bun

      (with dotnetCorePackages; combinePackages [
       sdk_7_0_3xx
      ])
    ];
  };
}
