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
    outputs.nixosModules.common
    inputs.home-manager.nixosModules.home-manager
    inputs.nixos-wsl.nixosModules.default
    outputs.nixosModules.emacs
    ./hardware-configuration.nix
  ];

  #virtualisation.virtualbox.guest.enable = true;
  wsl.enable = true;
  wsl.defaultUser = "nohlachilders";
  wsl.startMenuLaunchers = true;


  networking.hostName = "nixos";

    fonts.packages = with pkgs;[
        overpass
            source-sans-pro
            helvetica-neue-lt-std
            fira-code
            fira-code-nerdfont
            font-awesome
    ];

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
