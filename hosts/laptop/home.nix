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
                ''${workspaceScript}/bin/workspace''
                ''${wallpaperScript}/bin/wallpaper'' 
            ]; 
            monitor = [
            ];
            windowrule = [
                "float,title:^(Picture-in-Picture)$"
            ];
            workspace = [
            ];
        };
    };
}
