{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {

    ai = pkgs.writeShellApplication {
        name = "ai";
        text = ''
            local search=$*
            pkgs.tgpt "answer the following prompt as concisely as possible: $search"
        '';
    };

}
