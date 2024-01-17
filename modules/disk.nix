{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    ldmtool # Windows Dynamic Disk Tools
    ntfs3g # NTFS Filesystem
  ];

  # Enable NTFS Support at boot
  boot.supportedFilesystems = [ "ntfs" ];

  # File Systems. Mount disk
  fileSystems."/WD_Black_Steam" =
    {
      device = "/dev/disk/by-uuid/5DD70597675EEEC6";
      fsType = "ntfs";
      options = [
        "nofail"
        "uid=1000"
        "gid=100"
        "rw"
        "exec"
        "umask=000 0 0"
        "x-gvfs-show"
        "noatime"
        "nodiratime"
        "discard"
      ];
    };

  fileSystems."/840_Evo_GoG" =
    {
      device = "/dev/disk/by-uuid/12F85F29F85F09FD";
      fsType = "auto";
      options = [
        "nofail"
        "uid=1000"
        "gid=100"
        "rw"
        "exec"
        "umask=000 0 0"
        "x-gvfs-show"
        "noatime"
        "nodiratime"
        "discard"
      ];
    };
  fileSystems."/WD_Red_Stockage" =
    {
      device = "/dev/disk/by-uuid/D682492882490E85";
      fsType = "ntfs-3g";
      options = [
        "nofail"
        "uid=1000"
        "gid=100"
        "rw"
        "exec"
        "umask=000 0 0"
        "x-gvfs-show"
      ];
    };
  fileSystems."/Samsung_HDD_Jap'anims" =
    {
      device = "dev/disk/by-uuid/9AE09B8DE09B6DEF";
      fsType = "auto";
      options = [
        "nofail"
        "uid=1000"
        "gid=100"
        "rw"
        "exec"
        "umask=000 0 0"
        "x-gvfs-show"
      ];
    };
}
