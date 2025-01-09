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
        name = "conf";
        text = ''
            if [ $# -eq 0 ]; then
                echo "Need hostname argument to operate on"
            else
                pushd ~/Projects/nixos-config/
                nvim
                lazygit
                nixme .#"$1"
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
                tgpt -w "answer the following prompt as concisely as possible: $search"
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
