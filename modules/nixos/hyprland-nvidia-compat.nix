
{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  

  hardware.nvidia.modesetting.enable = true;

  environment.sessionVariables = {
    WLR_NO_HARDWARE_CURSORS = "1";
    NIXOS_OZONE_WL = "1";
  };
}
