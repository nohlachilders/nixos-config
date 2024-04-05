#emacs
{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
   programs.emacs = {
    enable = true;
    extraConfig = ''
        ;(load ~/Projects/nohl-emacs-files/dotfiles/init.el)
    '';
    extraPackages = epkgs: with epkgs; [
        emacsql-sqlite
    ];
   };
}
