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
    #outputs.nixosModules.swayX
    outputs.nixosModules.common
    outputs.nixosModules.hyprland-nvidia-compat
    outputs.nixosModules.emacs
    ./hardware-configuration.nix
  ];

  environment.systemPackages = with pkgs; [
    foot
    wofi
    mako
    libnotify
    swww

    #discord
    vesktop
  ];

fonts.packages = with pkgs;[
    source-sans-pro
    helvetica-neue-lt-std
    fira-code
    font-awesome
];


  #virtualisation.virtualbox.guest.enable = true;
  boot.loader.grub.device = "/dev/sda";

  services.xserver.enable = true;
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.displayManager.sddm.wayland.enable = true;
  programs.hyprland = {
    enable = true;
    package = pkgs.unstable.hyprland;
    xwayland.enable = true;
  };

xdg.portal.enable = true;
xdg.portal.extraPortals = [pkgs.xdg-desktop-portal-gtk];
xdg.portal.config.common.default = "*";

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
      extraGroups = ["networkmanager" "wheel" "audio" ];

      shell = pkgs.zsh;
    };
  };
  


}
