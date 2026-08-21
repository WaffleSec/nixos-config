{ config, pkgs,  ...} @ args:

{
  imports = [
    ./hardware-configuration.nix

    ../../modules/fhs-fonts.nix
    ../../modules/libvirt.nix
    ../../modules/core-desktop.nix
    ../../modules/user-group.nix
  ];

  boot.binfmt.emulatedSystems = ["aarch64-linux" "riscv64-linux"];

  boot.supportedFilesystems = [
    "ext4"
    "btrfs"
    "xfs"
    #"zfs"
    "ntfs"
    "fat"
    "vfat"
    "exfat"
    "cifs"
  ];

  boot.consoleLogLevel = 3;
  boot.initrd.verbose = false;
  boot.kernelParams = [
    "quiet"
    "rd.udev.log_level=3"
    "rd.systemd.show_status=auto"
  ];

  boot.loader = {
    systemd-boot.enable = true;
    timeout = 0;
  };

  catppuccin = {
    enable = true;
    autoEnable = true;
    flavor = "mocha";
  };

  boot.plymouth.enable = true;

  networking = {
    hostName = "wafflestation";
    wireless.enable = true;

    networkmanager = {
      enable = true;
      plugins = with pkgs; [
        networkmanager-openvpn
      ];
    };
  };

  fileSystems = {
    "/mnt/misc" = {
      device = "/dev/disk/by-uuid/a14a996c-be9d-4a12-9241-8c3a8349f136";
      fsType = "ext4";
      options = [ "nofail" ];
    };
    "/mnt/vms" = {
      device = "/dev/disk/by-uuid/4ff594cd-294a-4e4c-be22-ce512c297c39";
      fsType = "ext4";
      options = [ "nofail" ];  
    };
  };
  

  virtualisation.docker.storageDriver = "btrfs";

  system.stateVersion = "26.05";
}
