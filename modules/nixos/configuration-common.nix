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
    ./hardware-config.nix
  ];

  environment.systemPackages =
    [ inputs.home-manager.packages.${pkgs.system}.default ];

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


  boot.loader.grub.enable = true;
  boot.loader.grub.device = ${fileSystems."/".device};
  boot.loader.grub.efiInstallAsRemovable;
  boot.loader.useOSProber = true;

  networking.networkmanager.enable = true;
  time.timeZone = "America/Los_Angeles";

  system = "x86_64-linux";
  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "23.05";
}
