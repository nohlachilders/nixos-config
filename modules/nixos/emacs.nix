{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
    imports = [
        #outputs.overlays
    ];

    environment.systemPackages = with pkgs; [
        unstable.texliveMedium
    ];

}

