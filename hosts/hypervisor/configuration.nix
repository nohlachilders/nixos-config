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
  ];

  #virtualisation.virtualbox.guest.enable = true;
  virtualisation.hypervGuest.enable = true;
  boot.loader.grub.device = "/dev/disk/by-uuid/6BF4-EA9C";

  programs.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.system}.hyprland;
  };

  networking.hostName = "nixos";

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
