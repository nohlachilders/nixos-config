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
            active_opacity = 0.86;
            inactive_opacity = 0.75;
            blur = {
                size = 4;
                noise = .15;
                passes = 3;
            };
        };
    };

    services.mako = with config.colorScheme.palette; {
        backgroundColor = "#${base00}";
        borderColor = "#${base0A}";
        borderRadius = 5;
        borderSize = 2;
        textColor = "#${base04}";
        layer = "overlay";
        font = "Fira Code 14";
    };

    programs.waybar = with config.colorScheme.palette; {
        style = ''
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
            font-family: FiraCode Nerd Font;
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
