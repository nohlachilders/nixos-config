
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

  #programs.neovim.enable = true;

  programs.nixvim = {
    enable = true;

    plugins = {
      lsp= {
        enable = true;
        servers = {
          nix_ls.enable = true;
        };
      };
    };

    colorschemes.gruvbox.enable = true;

    globals.mapleader = " ";

    extraConfigLua = ''
      -- Print a little welcome message when nvim is opened!
      print("Hello world!")
    '';
  };

}