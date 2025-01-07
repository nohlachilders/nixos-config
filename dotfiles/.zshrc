alias vi="nvim";
alias nixme="sudo nixos-rebuild switch --flake";
alias homeme="home-manager switch --flake .#nohlachilders";
alias ls="ls --color=auto"; 
alias lg="lazygit";


alias source ~/.env
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
NEWLINE=$'\n'
PROMPT='${NEWLINE}╭───%F{white}${vcs_info_msg_0_} %F{yellow}zsh @ %~ ${NEWLINE}%F{default}╰─%F{yellow}|>%f'

[ -f "$HOME/.local/share/zsh/zsh-fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh" ] && \
    source "$HOME/.local/share/zsh/zsh-fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh"

#ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#''${config.colorScheme.colors.base03}"
bindkey '^ ' autosuggest-accept

[ -f "$HOME/.local/share/zsh/zsh-autosuggestions/zsh-autosuggestions.zsh" ] && \
    source "$HOME/.local/share/zsh/zsh-autosuggestions/zsh-autosuggestions.zsh"

[ -f "$HOME/.local/share/zsh/nix-zsh-completions/nix.plugin.zsh" ] && \
    source "$HOME/.local/share/zsh/nix-zsh-completions/nix.plugin.zsh"

eval "$(direnv hook zsh)"

duck (){
    local search=$@
    search="''${search// /%20}"
    w3m "https://lite.duckduckgo.com/html/?q=$search";
}

flakify (){
    if [ ! -e flake.nix ]; then
        nix flake new -t github:nix-community/nix-direnv . 
    elif [ ! -e .envrc ]; then
        echo "use flake" > .envrc
        direnv allow
    fi
}

