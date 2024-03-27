# NixOS config
ignore this please and thank you :)
at time of writing this is under development and public for the purposes of easier testing on VMs. im trying to wrap my head around the language and layout of the OS currently. this is using misterio77s starter configs as a template, and at time of writing doesnt deviate from them very much. if youre looking for configs id reccomend checking them out at https://github.com/Misterio77/nix-starter-configs

# TODO: flesh out these install instructions.
Install NixOS, reboot, log in. Install git. Enable nix-command and flakes. init this repo, pull, run nix flake ini from inside it. copy in locally generated hardware-config.nix at /etc/nixos to base directory of this repo. run sudo nixos-rebuild --flake .#%desired-host-preset%, and a similar command for the home-manager preset.

note that if an error is found where the hardware config is not carried over to nixs filestore when building, add it to your local git repo.

# why are there so many commits?
i havent set up secrets yet, and tbh because of that im editing the files in here in VScode on my host windows machine for now. theres no good editing environment set up yet in this config, either haha. hence why this repo is currently public and im pushing a commit on every single file change. this wont be this way forever.