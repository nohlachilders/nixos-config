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
    shellAliases = {
      nixme = "sudo nixos-rebuild switch --flake";
    };
    initExtra = ''
      bindkey -v
      bindkey -M viins jk vi-cmd-mode
      export VISUAL=nvim
      # Remove mode switching delay.
      KEYTIMEOUT=10
      # Change cursor shape for different vi modes.
      function zle-keymap-select {
      if [[ ''${KEYMAP} == vicmd ]] ||
        [[ $1 = 'block' ]]; then
            echo -ne '\e[1 q'

        elif [[ ''${KEYMAP} == main ]] ||
            [[ ''${KEYMAP} == viins ]] ||
            [[ ''${KEYMAP} = ''\'''\' ]] ||
            [[ ''$1 = 'beam' ]]; then
                    echo -ne '\e[5 q'
      fi
      }
      zle -N zle-keymap-select

      # Use beam shape cursor on startup.
      echo -ne '\e[5 q'
      _fix_cursor() {
         echo -ne '\e[5 q'
      }

      precmd_functions+=(_fix_cursor)
      echo "hi welcome to zsh lol"
    '';
  };

  tmux.enable = true;
};
}

