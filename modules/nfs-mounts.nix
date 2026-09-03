{ config, pkgs, ... }:

{
  fileSystems."/mnt/misc/code_projects" = {
    device = "wafflestation:/mnt/misc/code_projects";
    fsType = "nfs";
    options = [
      "x-systemd.automount"
      "noauto"
      "x-systemd.idle-timeout=600"
      "x-systemd.mount-timeout=10"
      "nfsvers=4.2"
      "soft"
      "timeo=100"
      "retrans=2"
    ];
  };

  services.rpcbind.enable = true;
  boot.supportedFilesystems = [ "nfs" ];
}
