# /etc/nixos/pkgs/default.nix
{ pkgs, ... }:
let
  callPackage = pkgs.callPackage;
in
{
  nixpkgs.overlays = [
    (final: prev: {
      mypackages = {
        kanagawa = callPackage ./kanagawa.nix { };
      };
    })
  ];
}
