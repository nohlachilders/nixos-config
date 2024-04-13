# main OS config
{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    <nixos-wsl/modules>
    outputs.nixosModules.common
    inputs.home-manager.nixosModules.home-manager
  ];

  #virtualisation.virtualbox.guest.enable = true;
  wsl.enable = true;
  wsl.defaultUser = "nohlachilders";


  networking.hostName = "nixos";

  home-manager = {
    users = {
      # Import your home-manager configuration
      nohlachilders = import ./home.nix;
    };
  };

  users.users = {
    # FIXME: Replace with your username
    nohlachilders = {
      isNormalUser = true;
      # TODO: Be sure to add any other groups you need (such as networkmanager, audio, docker, etc)
      extraGroups = ["networkmanager" "wheel" ];

      shell = pkgs.zsh;
    };
  };
  


}
