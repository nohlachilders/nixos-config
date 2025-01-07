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
    ## these are loaded from in the local repo, and can be live edited without reloading the system
    ".config/nvim/init.lua".source = config.lib.file.mkOutOfStoreSymlink /home/nohlachilders/Projects/nixos-config/dotfiles/.config/nvim/init.lua;
    ".zshrc".source = config.lib.file.mkOutOfStoreSymlink /home/nohlachilders/Projects/nixos-config/dotfiles/.zshrc;
    ".config/tmux/tmux.conf".source = config.lib.file.mkOutOfStoreSymlink /home/nohlachilders/Projects/nixos-config/dotfiles/.config/tmux/tmux.conf;

    ".local/share/zsh/zsh-autosuggestions".source = "${pkgs.zsh-autosuggestions}/share/zsh-autosuggestions";
    ".local/share/zsh/zsh-fast-syntax-highlighting".source = "${pkgs.zsh-fast-syntax-highlighting}/share/zsh/site-functions";
    ".local/share/zsh/nix-zsh-completions".source = "${pkgs.nix-zsh-completions}/share/zsh/plugins/nix";
    ".config/tms/default-configuration.toml".text =/*toml*/ ''
        search_paths = [
              '~/Projects',
        ]
        default_session = 'default-session'
      '';
  };

  programs = {
    neovim = {
        enable = true;
        plugins = [
            pkgs.vimPlugins.nvim-treesitter.withAllGrammars
        #pkgs.vimPlugins.nvim-lspconfig
        ];
        extraWrapperArgs = [
            "--prefix"
            "PATH"
            ":"
            "${lib.makeBinPath [pkgs.gcc]}"
        ];
    };
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

