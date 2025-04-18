# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  # You can import other home-manager modules here
  imports = [
    #./nixvim.nix
    ./terminal.nix
    ./nix-colors.nix
  ];

  home = {
    username = "nohlachilders";
    homeDirectory = lib.mkForce /home/nohlachilders;
    stateVersion = "23.05";
  };

  nixpkgs = {
    # You can add overlays here
    overlays = [
      # Add overlays your own flake exports (from overlays and pkgs dir):
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.unstable-packages
    ];

    # Configure your nixpkgs instance
    config = {
      # Disable if you don't want unfree packages
      allowUnfree = true;
      # Workaround for https://github.com/nix-community/home-manager/issues/2942
      allowUnfreePredicate = _: true;
    };
  };

    xdg.enable = true;

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

}
