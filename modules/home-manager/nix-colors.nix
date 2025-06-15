{ pkgs, inputs, config,... }:
{
    imports = [
        inputs.nix-colors.homeManagerModules.default
    ];

    colorScheme = inputs.nix-colors.colorSchemes.gruvbox-dark-medium;

    wayland.windowManager.hyprland.settings = {
        general = with config.colorScheme.palette; {
            gaps_in = 2;
            gaps_out = 2;
            border_size = 2;
            "col.active_border" = "rgb(${base0A})";
            "col.inactive_border" = "rgb(${base01})";
        };
        decoration = {
            rounding = 5;
            active_opacity = 1.0;
            inactive_opacity = 0.75;
            blur = {
                size = 4;
                noise = .15;
                passes = 3;
            };
        };
    };

    services.mako = with config.colorScheme.palette; {
        settings.backgroundColor = "#${base00}";
        settings.borderColor = "#${base0A}";
        settings.borderRadius = 5;
        settings.borderSize = 2;
        settings.textColor = "#${base04}";
        settings.layer = "overlay";
        settings.font = "Fira Code 14";
        settings.default-timeout = 4000;
    };

    programs.zathura = with config.colorScheme.palette; {
    extraConfig = ''
        set font "Overpass 14"
        set recolor "true"
        set recolor-lightcolor "#${base00}"
        set recolor-darkcolor "#${base04}"
    '';};

    programs.waybar = with config.colorScheme.palette; {
        style = /*css*/ ''
        @define-color background-darker #${base00};
        @define-color background #${base01};
        @define-color selection #${base03};
        @define-color foreground #${base04}; 
        @define-color comment #${base01}; 
        @define-color cyan #${base0C}; 
        @define-color green #${base0B}; 
        @define-color orange #${base09}; 
        @define-color pink #${base0E}; 
        @define-color purple #${base0E}; 
        @define-color red #${base08}; 
        @define-color yellow #${base0A}; 
        * {
            border: none;
            border-radius: 5px;
            font-family: Fira Code;
            font-size: 12pt;
            min-height: 0px;
        }
        window#waybar {
            opacity: 0.7;
            background: @background-darker;
            color: @foreground;
            border-bottom: 2px solid @purple;
        }
        #workspaces button {
            background: @background-darker;
            border: 2px solid @foreground;
            color: @foreground;
            margin: 4px;
        }
        #workspaces button:hover {
            box-shadow: inherit;
            text-shadow: inherit;
        }
        #workspaces button.active {
            border: 2px solid @yellow;
            border-radius: 5px;
            background: @background;
        }
        #workspaces button.urgent {
            background-image: linear-gradient(0deg, @red, @background-darker);
        }

        #window {
            font-family: Overpass;
            color: @purple;
        }

        #taskbar button.active {
            background-image: linear-gradient(0deg, @selection, @background-darker);
        }

        #clock {
            background: @background-darker;
            border: 2px solid @foreground;
            color: @foreground;
            padding: 0 10px;
            margin: 4px;
        }

        #backlight-slider slider {
            min-height: 10px;
            min-width: 10px;
            border: 2px solid @foreground;
            background: @background;
        }
        #backlight-slider trough {
            min-height: 10px;
            min-width: 80px;
            border: 2px solid @foreground;
            border-radius: 5px;
            background-color: @background-darker;
        }
        #backlight-slider highlight {
            min-width: 10px;
            border-radius: 5px;
            background-color: @foreground;
        }

        #pulseaudio-slider slider {
            min-height: 10px;
            min-width: 10px;
            border: 2px solid @foreground;
            background: @background;
        }
        #pulseaudio-slider trough {
            min-height: 10px;
            min-width: 80px;
            border: 2px solid @foreground;
            border-radius: 5px;
            background-color: @background-darker;
        }
        #pulseaudio-slider highlight {
            min-width: 10px;
            border-radius: 5px;
            background-color: @foreground;
        }

        #tray {
            padding: 2 10px;
            margin: 4px;
        }
    '';
};
}
