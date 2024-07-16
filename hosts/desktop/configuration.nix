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
    outputs.nixosModules.cyber
    ./hardware-configuration.nix
  ];

  environment.systemPackages = with pkgs; [
    neofetch

    wofi
    mako
    libnotify
    swww
    wl-clipboard
    cliphist
    grim
    slurp
    grimblast

    maestral
    zathura

    discord

    krita
    obs-studio
    unstable.godot_4
  ];

fonts.packages = with pkgs;[
    overpass
    source-sans-pro
    helvetica-neue-lt-std
    fira-code
    fira-code-nerdfont
    font-awesome
];


  boot.loader.grub= {
    enable = true;
    useOSProber = true;
  };

  #virtualisation.virtualbox.guest.enable = true;
  boot.loader.grub.device = "/dev/sda";

  services.xserver.enable = true;
  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.wayland.enable = true;
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

xdg.portal.enable = true;
xdg.portal.extraPortals = [pkgs.xdg-desktop-portal-gtk];
xdg.portal.config.common.default = "*";

  networking.hostName = "nixos";

hardware.opentabletdriver.enable = true;

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
