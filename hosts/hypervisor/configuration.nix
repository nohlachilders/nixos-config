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
    #outputs.nixosModules.sway
    outputs.nixosModules.common
    inputs.home-manager.nixosModules.home-manager
  ];

  boot.loader.grub= {
    enable = true;
    useOSProber = true;
  };

  #virtualisation.virtualbox.guest.enable = true;
  virtualisation.hypervGuest.enable = true;
  boot.loader.grub.device = "nodev";
  boot.loader.grub.efiSupport = true;
  boot.loader.efi.canTouchEfiVariables = true;


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
