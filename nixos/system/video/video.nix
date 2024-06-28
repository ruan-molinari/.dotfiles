{ 
  pkgs, 
  config, 
  ... 
}: {

  services.xserver.enable = true;

  hardware.opengl = {
      # Enables the graphics driver for OpenGL
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
      extraPackages = with pkgs; [ vaapiVdpau ];
  };

  # Load default nvidia drivers for Xorg and wayland
  services.xserver.videoDrivers = [ "nvidia" ];
   
  hardware.nvidia = {
    # Modesetting is required.
    modesetting.enable = true;
    powerManagement.enable = false;
    powerManagement.finegrained = false;
    open = true;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };
}
