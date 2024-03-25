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
    # ./nvim.nix
  ];


 

  # Add stuff for your user as you see fit:
  programs = {
    neovim.enable = true;
    home-manager.enable = true;
    git.enable = true;
    zsh.enable = true;
    firefox.enable = true;
    hyprland.enable = true;
  };

  pkgs.shell = zsh;

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

}
