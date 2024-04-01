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
      ls = "ls --color=auto";
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

      if [ -z $TMUX ]
      then
          tmux attach -t defaultsession || tmux new -s defaultsession
      fi

      autoload -Uz vcs_info
      precmd() { vcs_info }
      zstyle ':vcs_info:git:*' check-for-changes true formats '[%b%u%c] '
      setopt PROMPT_SUBST
      PROMPT=''\'''${vcs_info_msg_0_} %F{yellow}zsh @ %~ |>%f'

    '';
  };

  tmux.enable = true;
};
}

