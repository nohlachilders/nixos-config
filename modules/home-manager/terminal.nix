{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  home.file = {
    ".local/share/zsh/zsh-autosuggestions".source = "${pkgs.zsh-autosuggestions}/share/zsh-autosuggestions";
    ".local/share/zsh/zsh-fast-syntax-highlighting".source = "${pkgs.zsh-fast-syntax-highlighting}/share/zsh/site-functions";
    ".local/share/zsh/nix-zsh-completions".source = "${pkgs.nix-zsh-completions}/share/zsh/plugins/nix";
  };

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

      [ -f "$HOME/.local/share/zsh/zsh-fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh" ] && \
      source "$HOME/.local/share/zsh/zsh-fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh"

      #ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#''${config.colorScheme.colors.base03}"
      #bindkey '^ ' autosuggest-accept

      [ -f "$HOME/.local/share/zsh/zsh-autosuggestions/zsh-autosuggestions.zsh" ] && \
      source "$HOME/.local/share/zsh/zsh-autosuggestions/zsh-autosuggestions.zsh"

      [ -f "$HOME/.local/share/zsh/nix-zsh-completions/nix.plugin.zsh" ] && \
      source "$HOME/.local/share/zsh/nix-zsh-completions/nix.plugin.zsh"
    '';
  };

  tmux.enable = true;
};
}

