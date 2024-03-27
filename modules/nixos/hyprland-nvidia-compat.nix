
{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  
  programs.hyprland.enableNvidiaPatches = true;

  hardware.nvidia.modesetting.enable = true;

  environment.sessionVariables = {
    WLR_NO_HARDWARE_CURSORS = "1";
    NIXOS_OZONE_WL = "1";
  };
}
