
{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    inputs.nixvim.homeManagerModules.nixvim
  ];

  programs.nixvim = {
    enable = true;
    defaultEditor = true;

    colorschemes.gruvbox.enable = true;

    globals.mapleader = " ";

    extraConfigLua = ''
      -- Print a little welcome message when nvim is opened!
      print("Hello world!")
    '';
  };

};