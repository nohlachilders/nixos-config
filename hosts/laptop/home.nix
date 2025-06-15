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
        discord &
    '';
    wallpaperScript = pkgs.pkgs.writeShellScriptBin "wallpaper" ''
        swww-daemon &
        swww img ~/Dropbox/drawings/049.png
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
                "eDP-1,1920x1080,0x0,1"
            ];
            windowrule = [
                "float,title:^(Picture-in-Picture)$"
            ];
            workspace = [
            ];
        };
    };
}
