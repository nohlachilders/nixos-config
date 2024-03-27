{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  
  environment.systemPackages = with pkgs; [
    pkgs.swayfx
  ];

}

