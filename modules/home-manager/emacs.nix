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
        package = pkgs.unstable.emacs;
        extraConfig = ''
            (load-file "~/Projects/nohl-emacs-files/dotfiles/init.el")
            '';
        extraPackages = epkgs: with epkgs; [
            emacsql-sqlite
        ];
    };
}
