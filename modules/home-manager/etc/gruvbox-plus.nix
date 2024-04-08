{ pkgs }:
pkgs.stdenv.mkDerivation {
 name = "gruvbox-plus";

 src = pkgs.fetchurl {
  url = "https://github.com/SylEleuth/gruvbox-plus-icon-pack/releases/download/v5.2/gruvbox-plus-icon-pack-5.2.zip";
  sha256 = "sha256-o2lOzGqL3PAAPqND+pdz06Ax/PJ2OyQExvp7Xsi7EJc=";
 };

 dontUnpack = true;

 installPhase = ''
    mkdir -p $out
    ${pkgs.unzip}/bin/unzip $src -d $out/
 '';
} 
