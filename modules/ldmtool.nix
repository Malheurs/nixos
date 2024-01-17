{ pkgs, config, lib, ... }:

{
  systemd.services.ldmtool = {
  wantedBy = [ "multi-user.target" ];
  after = [ "local-fs-pre.target" ];
  serviceConfig = {
        Type = "simple";
        User = "root";
        ExecStart = "${pkgs.ldmtool}/bin/ldmtool create all";
        TimeoutStopSec = 10;
        };
    };
}
