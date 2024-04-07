# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
{
    inputs,
        outputs,
        lib,
        config,
        pkgs,
        ...
}:

let
    startupScript = pkgs.pkgs.writeShellScriptBin "wallpaper" ''
        swww init
        swww img -o VGA-1 ~/Dropbox/drawings/048.png
        swww img -o DP-3 ~/Dropbox/drawings/face2.png
        swww img -o VGA-1 ~/Dropbox/drawings/047_3.png
    '';
in {
    # You can import other home-manager modules here
    imports = [
        outputs.homeManagerModules.common
        outputs.homeManagerModules.hyprland
        outputs.homeManagerModules.emacs
    ];
    wayland.windowManager.hyprland = {
        settings = {
            exec-once = [''${startupScript}/bin/wallpaper'']; 
            monitor = [
                "DP-3,1920x1080,0x0,1"
                "HDMI-A-1,1920x1080, 0x1080, 1, transform, 2" 
                "VGA-1,1440x900, 1920x-360, 1, transform, 1"
            ];
            workspace = [
                #"name:1, monitor:DP-3, default:true"
                "name:2, monitor:DP-3"
                "name:3, monitor:DP-3"
                "name:4, monitor:DP-3"
                "name:5, monitor:DP-3"
                "name:6, monitor:DP-3"
                "name:7, monitor:DP-3"
                "name:8, monitor:DP-3"
                "name:9, monitor:DP-3"
                "name:10, monitor:DP-3"
                "name:side, monitor:VGA-1, default:true"
                "name:cintiq, monitor:HDMI-A-1, default:true"
            ];
        };
    };
}
