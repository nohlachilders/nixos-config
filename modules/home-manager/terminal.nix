{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
programs = {
  zsh = {
    enable = true;
    initExtra = ''
      bindkey -v
      bindkey -M viins jk vi-cmd-mode
      export VISUAL=nvim
      # Remove mode switching delay.
      KEYTIMEOUT=10
    '';
  };

  tmux.enable = true;
};
}

