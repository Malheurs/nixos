{ pkgs, ... }:

{
  # Linux Kernel - Xanmod
  boot.kernelPackages = pkgs.linuxPackages_xanmod_stable;

  # Use this to pin the kernel you want 
  #boot.kernelPackages = pkgs.linuxPackagesFor (pkgs.linux_6_5.override {
  #  argsOverride = rec {
  #    src = pkgs.fetchurl {
  #      url = "https://gitlab.com/xanmod/linux/-/archive/6.5.12-xanmod1/linux-6.5.12-xanmod1.tar.gz";
  #      sha256 = "17jq50g0xw3fh9p0ga7md440nm2bsdskk06wpaxvwwh8n8cw6jhw";
  #    };
  #    version = "6.5.12-xanmod1";
  #    modDirVersion = "6.5.12-xanmod1";
  #  };
  #});
}
