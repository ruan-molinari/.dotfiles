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
    	git
      nerdfonts
    	neovim
    	wezterm
    	nushell
    	starship
    	zoxide

      libratbag # Configuration library for gaming mice
      piper # GTK frontend for libratbag mouse config daemon

      # Programming languages/LSPs/tools
      cargo
      rustup
      zig
      zls
      go
      odin
      ols
      python3
      nodejs_20
      bun
    ];
  };
}
