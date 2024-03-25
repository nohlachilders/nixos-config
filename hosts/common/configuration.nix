# main OS config
{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    inputs.home-manager.nixosModules.home-manager
  ];

  nixpkgs = {
    overlays = [
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.unstable-packages
    ];
    config = {
      allowUnfree = true;
    };
  };

  # This will add each flake input as a registry
  # To make nix3 commands consistent with your flake
  nix.registry = (lib.mapAttrs (_: flake: {inherit flake;})) ((lib.filterAttrs (_: lib.isType "flake")) inputs);

  nix.settings = {
    experimental-features = "nix-command flakes";
    auto-optimise-store = true;
  };


  boot.loader.grub= {
    enable = true;
    device = "/dev/sda";
    useOSProber = true;
  };

  networking.networkmanager.enable = true;
  time.timeZone = "America/Los_Angeles";

}
