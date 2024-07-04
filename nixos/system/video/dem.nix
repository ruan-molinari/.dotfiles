# Desktop Environment Management
{
  config,
  pkgs,
  lib,
  ...
}: {

  services = {
    xserver.enable = true;
    displayManager.sddm.enable = true;
    displayManager.sddm.wayland.enable = true;
    desktopManager.plasma6.enable = true;
  };

  xdg.portal.enable = true;
}
