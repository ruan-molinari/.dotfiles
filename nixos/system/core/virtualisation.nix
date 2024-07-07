{
  pkgs,
  userSettings,
  ...
}: {
  virtualisation = {
    docker = {
      enable = true;

      rootless = {
        enable = true;
        setSocketVariable = true;
      };
    };

    libvirtd = {
      enable = true;
      qemu = {
        package = pkgs.qemu_kvm;
        runAsRoot = true;
        swtpm.enable = true;
        ovmf = {
          enable = true;
          packages = [(pkgs.OVMF.override {
            secureBoot = true;
            tpmSupport = true;
          }).fd];
        };
      };
    };
  };

  programs.virt-manager.enable = true;
  
  programs.dconf = {
    enable = true;

    profiles.${userSettings.username}.databases = [
      {
        settings = {
          "org/virt-manager/virt-manager/connections" = {
            autoconnect = ["qemu:///system"];
            uris = ["qemu:///system"];
          };
        };
      }
    ];
  };

  users.users.${userSettings.username} = {
    extraGroups = [ "docker" "vibvirtd" ]; # virtualisation usually requires some higher privileges
  };
}
