# Add your reusable NixOS modules to this directory, on their own file (https://nixos.wiki/wiki/Module).
# These should be stuff you would like to share with others, not your personal configurations.
{
  # List your module files here
  # my-module = import ./my-module.nix;
  common = import ./common.nix;
  hyprland-nvidia-compat = import ./hyprland-nvidia-compat.nix;
  sway = import ./sway.nix;
    emacs = import ./emacs.nix;
    cyber = import ./cyber.nix;
}


