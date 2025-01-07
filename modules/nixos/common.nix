# main OS config
{
    inputs,
        outputs,
        lib,
        config,
        pkgs,
        ...
}: {
    imports = [
        #inputs.home-manager.nixosModules.home-manager
        ./scripts.nix
    ];

    nixpkgs = {
        overlays = [
            outputs.overlays.additions
            outputs.overlays.modifications
            outputs.overlays.unstable-packages
        ];
        config = {
            allowUnfree = true;
        };
    };

    environment.systemPackages = with pkgs; [
        home-manager
        nix-prefetch-github

        unstable.neovim
        gopls
        nil
        lua-language-server
        shellcheck
        vscode-langservers-extracted
        marksman
        (pkgs.python3.withPackages (ps: [ ps.python-lsp-server ps.debugpy ]))
        delve

        git
        lazygit
        wget
        ripgrep
        zsh
        tmux
        tmux-sessionizer
        ranger
        lf
        unstable.fzf
        w3m
        unstable.tgpt
        zip
        unzip
        zig

        jq
    ];

    programs.nix-ld.enable = true;
    programs.nix-ld.libraries = with pkgs; [
        # dependencies for non-nixpkgs binaries go here
        unstable.go
    ];

    security.polkit.enable = true;

    programs.zsh.enable = true;
    programs.ssh.startAgent = true;


    console.useXkbConfig = true;
    services.interception-tools.enable = true;
    services.xserver.xkb.options = "ctrl:nocaps";

    services.pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
    };

# This will add each flake input as a registry
# To make nix3 commands consistent with your flake
    nix.registry = (lib.mapAttrs (_: flake: {inherit flake;})) ((lib.filterAttrs (_: lib.isType "flake")) inputs);

    nix.settings = {
        experimental-features = "nix-command flakes";
        auto-optimise-store = true;
        substituters = ["https://hyprland.cachix.org"];
        trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
    };

    nix = {
        package = pkgs.nixVersions.stable;
        extraOptions = lib.optionalString (config.nix.package == pkgs.nixVersions.stable)
            "experimental-features = nix-command flakes";
    };

    home-manager = {
        extraSpecialArgs = { inherit inputs outputs; };
    };

    hardware ={
        graphics.enable = true;
        graphics.enable32Bit = true;
        nvidia.open = false;
    };

    networking.networkmanager.enable = true;
    time.timeZone = "America/Los_Angeles";

# https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
    system.stateVersion = "23.11";
}
