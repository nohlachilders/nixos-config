
{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: 

    let
        startupScript = pkgs.pkgs.writeShellScriptBin "start" ''
        ${pkgs.waybar}/bin/waybar 
        nohup ${pkgs.discord}/bin/discord
        ${pkgs.wl-clipboard}/bin/wl-paste --type text --watch ${pkgs.cliphist}/bin/cliphist store
        '';
        gruvbox-plus = import ./etc/gruvbox-plus.nix {inherit pkgs; };
    in {
    imports = [
    ];
    wayland.windowManager = {
        hyprland = {
            enable = true;
            xwayland.enable = true;
            settings = {
               exec-once = ''${startupScript}/bin/start''; 
               "$mod" = "SUPER";
               bindm = [
                "$mod, mouse:272, movewindow"
                "$mod, mouse:273, resizewindow"
                ];
               bind = [
                    "$mod, RETURN, exec, kitty"
                    "ALT_L, SPACE, exec, pkill wofi || wofi --show drun --allow-images"
                    "$mod SHIFT, Q, killactive"
                    "$mod, h, movefocus, l"
                    "$mod SHIFT, h, movewindow, l"
                    "$mod, l, movefocus, r"
                    "$mod SHIFT, l, movewindow, r"
                    "$mod, k, movefocus, u"
                    "$mod SHIFT, k, movewindow, u"
                    "$mod, j, movefocus, d"
                    "$mod SHIFT, j, movewindow, d"
                    "$mod, 1, workspace, 1"
                    "$mod, 2, workspace, 2"
                    "$mod, 3, workspace, 3"
                    "$mod, 4, workspace, 4"
                    "$mod, 5, workspace, 5"
                    "$mod, 6, workspace, 6"
                    "$mod, 7, workspace, 7"
                    "$mod, 8, workspace, 8"
                    "$mod, 9, workspace, 9"
                    "$mod, 0, workspace, 10"
                    "$mod SHIFT, 1, movetoworkspace, 1"
                    "$mod SHIFT, 2, movetoworkspace, 2"
                    "$mod SHIFT, 3, movetoworkspace, 3"
                    "$mod SHIFT, 4, movetoworkspace, 4"
                    "$mod SHIFT, 5, movetoworkspace, 5"
                    "$mod SHIFT, 6, movetoworkspace, 6"
                    "$mod SHIFT, 7, movetoworkspace, 7"
                    "$mod SHIFT, 8, movetoworkspace, 8"
                    "$mod SHIFT, 9, movetoworkspace, 9"
                    "$mod SHIFT, 0, movetoworkspace, 10"
               ];
               misc = {
                    disable_hyprland_logo = true;
               };
               input = {
                    "kb_options" = "ctrl:nocaps";
                    "sensitivity" = "-.15";
                    "accel_profile" = "flat";
               };
               decoration = {
                   #rounding = 5;
                   active_opacity = 0.86;
                   inactive_opacity = 0.75;
                   blur = {
                       size = 4;
                       noise = .15;
                       passes = 3;
                   };
               };
            };
        };
    };

    programs = {
        firefox.enable = true;
        kitty = {
            enable = true;
            theme = "Gruvbox Dark";
            font = {
                name = "Fira Code";
                size = 12;
            };
        };
    };

    services = {
        gammastep = {
            enable = true;
            provider = "manual";
            latitude = 32.79294;
            longitude = -117.159;
            temperature.night = 2300;
            tray = true;
            };
        };

    fonts.fontconfig.enable = true;
    gtk = {
        enable = true;
        theme = {
            name = "Adwaita-dark";
            package = pkgs.gnome.gnome-themes-extra;
        };
        font.name = "Overpass";
        font.size = 14;
        iconTheme.package = gruvbox-plus;
        iconTheme.name = "GruvboxPlus";
    };

    }

