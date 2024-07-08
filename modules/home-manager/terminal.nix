{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {

imports = [
];

  home.file = {
    ".local/share/zsh/zsh-autosuggestions".source = "${pkgs.zsh-autosuggestions}/share/zsh-autosuggestions";
    ".local/share/zsh/zsh-fast-syntax-highlighting".source = "${pkgs.zsh-fast-syntax-highlighting}/share/zsh/site-functions";
    ".local/share/zsh/nix-zsh-completions".source = "${pkgs.nix-zsh-completions}/share/zsh/plugins/nix";
    ".config/tms/default-config.toml".text = ''
      search_paths = [
      '~/Projects',
      ]
      default_session = 'default-session'
    '';
  };

  programs = {
    ssh.enable = true;
    ssh.extraConfig = ''
      AddKeysToAgent yes
    '';

    git = {
      enable = true;
      userEmail = "nohlachilders@github.com";
      userName = "Nohl Childers";
      extraConfig = {
        push.default = "upstream";
        init.defaultBranch = "main";
      };
    };
    gh.enable = true;

    zsh = {
      enable = true;
      shellAliases = {
        v = "nvim";
        nixme = "sudo nixos-rebuild switch --flake";
        ls = "ls --color=auto"; 
      };
      initExtra = ''
        bindkey -v
        bindkey -M viins jk vi-cmd-mode
        bindkey -M viins "^P" up-line-or-history
        bindkey -M viins "^N" down-line-or-history
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
        bindkey '^ ' autosuggest-accept

        [ -f "$HOME/.local/share/zsh/zsh-autosuggestions/zsh-autosuggestions.zsh" ] && \
        source "$HOME/.local/share/zsh/zsh-autosuggestions/zsh-autosuggestions.zsh"

        [ -f "$HOME/.local/share/zsh/nix-zsh-completions/nix.plugin.zsh" ] && \
        source "$HOME/.local/share/zsh/nix-zsh-completions/nix.plugin.zsh"

        duck (){
            local search=$@
            search="''${search// /%20}"
            w3m "https://lite.duckduckgo.com/html/?q=$search";
        }

        ai (){
            local search=$*
            tgpt "answer the following prompt as concisely as possible: $search";
        }

        flakify (){
            if [ ! -e flake.nix ]; then
                nix flake new -t github:nix-community/nix-direnv . 
            elif [ ! -e .envrc ]; then
                echo "use flake" > .envrc
                direnv allow
            fi
        }

      '';
    };

    tmux = {
      enable = true;
      extraConfig = ''
        # leader
        unbind C-b
        set-option -g prefix C-a
        bind-key C-a send-prefix

        # split panes
        bind - split-window -h
        bind | split-window -v

        # Vim style pane selection
        unbind h
        unbind j
        unbind k
        unbind l
        unbind g
        unbind n
        bind j next-window
        bind k previous-window
        bind -r h switch-client -p\; refresh-client -S
        bind -r l switch-client -n\; refresh-client -S
        bind-key -r g run-shell "tmux neww -c lazygit"
        # Start windows and panes at 1, not 0
        set -g base-index 1
        set -g pane-base-index 1
        set-window-option -g pane-base-index 1
        set-option -g renumber-windows on

        unbind f
        bind f display-popup -E "tms"
        unbind r
        bind r display-popup -E "tms switch"

        set-option -g status-position top
        set-option -g status-style fg=gold,bg=black

        set -g status-left ""
        set -g status-right "tmux @ #S "
        set-option -g default-shell ${pkgs.zsh}/bin/zsh
        set-window-option -g mode-keys vi
      
      '';
    };

    fzf = {
        enable = true;
        enableZshIntegration = true;
    };

    direnv = {
        enable = true;
        enableZshIntegration = true;
        nix-direnv.enable = true;
    };
  };

  services = {
  };

}

