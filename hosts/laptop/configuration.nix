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

            unstable.hyprland
            unstable.wofi
            unstable.mako
            unstable.libnotify
            unstable.swww
            unstable.wl-clipboard
            unstable.cliphist
            unstable.grim
            unstable.slurp
            unstable.grimblast
            unstable.kitty

    maestral
    zathura

    discord

    zap

    acpi
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

  boot.loader.grub.device = "nodev";
  boot.loader.grub.efiSupport = true;
  boot.loader.efi.canTouchEfiVariables = true;


    services.xserver.enable = true;
    services.xserver.displayManager.gdm.enable = true;
    services.xserver.displayManager.gdm.wayland = true;
    programs.hyprland = {
        enable = true;
        xwayland.enable = true;
    };
    environment.sessionVariables.NIXOS_OZONE_WL = "1";
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
