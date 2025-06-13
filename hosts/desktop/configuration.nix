# main OS configdcon
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
        discord
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
        dolphin
        kdePackages.qtsvg

        krita
        obs-studio
        unstable.godot_4
        unstable.mesa
        chatterino2

    ];

    fonts.packages = with pkgs;[
        overpass
        source-sans-pro
        helvetica-neue-lt-std
        fira-code
        fira-code-nerdfont
        font-awesome
    ];

    virtualisation.docker.enable = true;

    #    services.ollama = {
    #        enable = true;
    #        acceleration = "cuda";
    #    };

    boot.loader.grub= {
        enable = true;
        useOSProber = true;
    };

    boot.loader.grub.device = "/dev/sda";

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

    hardware.opentabletdriver.enable = true;

    home-manager = {
        users = {
# Import your home-manager configuration
            nohlachilders = import ./home.nix;
        };
    };

    users.users = {
        nohlachilders = {
            isNormalUser = true;
            extraGroups = ["networkmanager" "wheel" "audio" "docker" ];

            shell = pkgs.zsh;
        };
    };


}
