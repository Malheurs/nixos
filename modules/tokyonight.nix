{ pkgs }:

{
  pkgs.stdenv.mkDerivation = {
    name = "Tokyo-Night-Icons-Dark";
    src = pkgs.fetchurl {
      url = "https://github.com/JaKooLit/GTK-themes-icons/blob/main/icon/Tokyonight-Dark-Icons.zip";
      sha256 = "https://github.com/JaKooLit/GTK-themes-icons/blob/main/icon/Tokyonight-Dark-Icons.zip";
    };
  };

  dontUnpack = true;

  installPhase = ''
    mkdir -p $out
    ${pkgs.unzip}/bin/unzip $src -d $out/
  '';
}
