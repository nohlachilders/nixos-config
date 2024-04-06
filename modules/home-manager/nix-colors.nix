{ pkgs, inputs, config,... }:
{
    imports = [
        inputs.nix-colors.homeManagerModules.default
    ];

    colorScheme = inputs.nix-colors.colorSchemes.gruvbox-dark-medium;
    services.mako = with config.colorScheme.colors; {
        backgroundColor = "#${base01}";
        borderColor = "#${base0E}";
        borderRadius = 5;
        borderSize = 2;
        textColor = "#${base04}";
        layer = "overlay";
    };

}
