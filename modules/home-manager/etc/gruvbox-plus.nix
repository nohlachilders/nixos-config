{ pkgs }:
pkgs.stdenv.mkDerivation {
 name = "gruvbox-plus";

 src = pkgs.fetchurl {
  url = "https://github.com/SylEleuth/gruvbox-plus-icon-pack/releases/download/v6.3.0/gruvbox-plus-icon-pack-6.3.0.zip";
  sha256 = "df22395a75b156afbe668e5afd7dbef8bce8b2d1";
 };

 dontUnpack = true;

 installPhase = ''
    mkdir -p $out
    ${pkgs.unzip}/bin/unzip $src -d $out/
 '';
} 
