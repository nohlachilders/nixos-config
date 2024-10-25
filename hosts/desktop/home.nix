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
    workspaceScript = pkgs.pkgs.writeShellScriptBin "workspace" ''
        firefox &
        cd ~/Projects/nohl-emacs-files/
        git pull
        emacs &
    '';
    wallpaperScript = pkgs.pkgs.writeShellScriptBin "wallpaper" ''
        swww init
        swww img -o DP-4 ~/Dropbox/drawings/048.png
        swww img -o HDMI-A-3 ~/Dropbox/drawings/047_3.png
        swww img -o DP-5 ~/Dropbox/drawings/049.png
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
            exec-once = [
                ''${wallpaperScript}/bin/wallpaper'' 
                ''${workspaceScript}/bin/workspace''
            ]; 
            monitor = [
                "DP-5,1920x1080@120,0x0,1"
                "HDMI-A-3,1920x1080, 0x1080, 1, transform, 2" 
                "DP-4,1440x900, 1920x-360, 1, transform, 1"
            ];
            windowrule = [
                "float,title:^(Picture-in-Picture)$"
            ];
            workspace = [
                #"name:1, monitor:DP-3, default:true"
                "name:2, monitor:DP-5"
                "name:3, monitor:DP-5"
                "name:4, monitor:DP-5"
                "name:5, monitor:DP-5"
                "name:6, monitor:DP-5"
                "name:7, monitor:DP-5"
                "name:8, monitor:DP-5"
                "name:9, monitor:DP-5"
                "name:10, monitor:DP-5"
                "name:side, monitor:DP-4, default:true"
                "name:cintiq, monitor:HDMI-A-3, default:true"
            ];
        };
    };
}
