{inputs, pkgs, ...}:
{
    programs.waybar.settings = {
        mainBar = {
            layer = "top";
            position = "top";
            height = 20;
            modules-left = [ "hyprland/workspaces" ];
            modules-center = [ "hyprland/window" ];
            modules-right = [ "pulseaudio" "pulseaudio/slider" "clock" "tray" ];

            "hyprland/workspaces" = {
                disable-scroll = true;
                all-outputs = true;
            };

            "hyprland/window" = {
            };

            pulseaudio = {
                format = "󰕾 {volume}%";
            };

            "clock" = {
                format = " {:%I:%M}";
            };

        };
    };
}
