# Add your reusable home-manager modules to this directory, on their own file (https://nixos.wiki/wiki/Module).
# These should be stuff you would like to share with others, not your personal configurations.
{
  # List your module files here
  # my-module = import ./my-module.nix;
  common = import ./common.nix;
  hyprland = import ./hyprland.nix;
  sway = import ./sway.nix;
  emacs = import ./emacs.nix;
}
