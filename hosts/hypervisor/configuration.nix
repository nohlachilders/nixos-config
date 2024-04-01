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

  #virtualisation.virtualbox.guest.enable = true;
  virtualisation.hypervGuest.enable = true;
  boot.loader.grub.device = "nodev";
  boot.loader.grub.efiSupport = true;
  boot.loader.efi.canTouchEfiVariables = true;


  networking.hostName = "nixos";

  services.xserver = {
    enable = true;
    modules = [ pkgs.xorg.xf86videofbdev ]; 
    videoDrivers = [ "hyperv_fb" ]; 
  };

  # Enable OpenGL
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };

  home-manager = {
    extraSpecialArgs = { inherit inputs outputs; };
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
