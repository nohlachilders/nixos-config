
{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  
  programs.hyprland.nvidiaPatches.enable = true;

  hardware.nvidia.modesetting.enable = true;

  environment.sessionVariables = {
    WLR_NO_HARDWARE_CURSORS = "1";
    NIXOS_OZONE_WL = "1";
  };
}
