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
        previous.emacsPackages.emacsql
        previous.emacsPackages.emacsql-sqlite
    ];

}

