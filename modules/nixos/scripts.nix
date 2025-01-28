{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {

    environment.systemPackages = with pkgs; [
        (writeShellApplication {
            name = "flakify";
            text = ''
                if [ $# -eq 0 ]; then
                    echo "Need flake template. use \"default\" if not sure"
                elif [ ! -e flake.nix ]; then
                    nix flake new -t github:nohlachilders/devflakes#"$1" .
                fi

                if [ ! -e .envrc ]; then
                    echo "use flake . --no-pure-eval" > .envrc
                    direnv allow
                fi
                '';
        })
        (writeShellApplication {
        name = "conf";
        text = ''
            if [ $# -eq 0 ]; then
                echo "Need hostname argument to operate on"
            else
                pushd ~/Projects/nixos-config/
                nvim
                lazygit
                sudo nixos-rebuild switch --flake .#"$1"
                popd
            fi
            '';
        })
        (writeShellApplication {
        name = "rebootScript";
        text = ''
            pushd ~/Projects/nohl-emacs-files/
            git add .
            git commit -m "Desktop auto-push: $(date)"
            git push
            popd
            reboot
            '';
        })

        (writeShellApplication {
            name = "ai";
            text = ''
                search=$*
                tgpt -w "answer the following prompt as concisely as possible: $search" | ${pkgs.bat}/bin/bat --paging=never -l markdown --style="plain" --theme=gruvbox-dark
            '';
        })
        (writeShellApplication {
            name = "ds";
            text = ''
                search=$*
                if [ $# -eq 0 ]; then
                    ollama run deepseek-r1:8b
                else
                    ollama run deepseek-r1:8b "answer the following prompt as concisely as possible: $search" | ${pkgs.bat}/bin/bat --paging=never -l markdown --style="plain" --theme=gruvbox-dark
                fi
            '';
        })

        (writeShellApplication {
            name = "chunk";
            text = ''
                search=$*
                tgpt -w "the following is a markdown header containing a task on a to do list. break this taks down into subheadings that contain the substeps needed to get it done. do not return any other text other than the markdown subheadings. do not wrap the returned text in markdown multiline comments. do not number the steps. be as concise as possible. include the original top-level heading. here is the task:$search"
            '';
        })

    ];
}
