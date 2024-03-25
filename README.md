# NixOS config
ignore this please and thank you :)
at time of writing this is under development and public for the purposes of easier testing on VMs. im trying to wrap my head around the language and layout of the OS currently. this is using misterio77s starter configs as a template, and at time of writing doesnt deviate from them very much. if youre looking for configs id reccomend checking them out at https://github.com/Misterio77/nix-starter-configs

# TODO: flesh out these install instructions.
Install NixOS, reboot, log in. Install git. Enable nix-command and flakes. init this repo, pull, run nix flake ini from inside it. replace hosts/common/hardware-configuration.nix with the locally generated one at /etc/nixos. run sudo nixos-rebuild --flake .#%desired-host-preset%

note that if an error is found where the hardware config is not carried over to nixs filestore when building, add it to your local git repo.