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
    inputs.home-manager.nixosModules.home-manager
  ];

  networking.hostName = "nixos";

  users.defaultUserShell =pkgs.zshell;
  users.users = {
    # FIXME: Replace with your username
    nohlachilders = {
      isNormalUser = true;
      # TODO: Be sure to add any other groups you need (such as networkmanager, audio, docker, etc)
      extraGroups = ["networkmanager" "wheel" ];
    };
  };

  home-manager = {
    extraSpecialArgs = { inherit inputs outputs; };
    users = {
      # Import your home-manager configuration
      nohlachilders = import ./home.nix;
    };
  };

}
