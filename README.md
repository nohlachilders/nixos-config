# NixOS config
this is using misterio77s starter configs as a template, and at time of writing doesnt deviate from them very much. if youre looking for configs id reccomend checking them out at https://github.com/Misterio77/nix-starter-configs

other than that, i sort of just break stuff into modules when i feel like it and import them into the host profiles as needed. the modules called common get linked into all of them, and other than that i just bundles features and settings for programs into modules as they make sense to me.


# TODO: flesh out these install instructions.
Install NixOS, reboot, log in. Install git. Enable nix-command and flakes. init this repo, pull, run nix flake init from inside it. copy in locally generated hardware-config.nix at /etc/nixos to base directory of this repo. run sudo nixos-rebuild --flake .#%desired-host-preset%, and a similar command for the home-manager preset.

note that if an error is found where the hardware config is not carried over to nixs filestore when building, add it to your local git repo.
