{ catppuccin, config, pkgs, ...} @ args:

{
  imports = [
    ./hardware-configuration.nix

    ../../modules/aad.nix
    ../../modules/intel.nix
    ../../modules/fhs-fonts.nix
    ../../modules/libvirt.nix
    ../../modules/nfs-mounts.nix
    ../../modules/core-desktop.nix
    ../../modules/user-group.nix
    ../../modules/plasma.nix
    catppuccin.nixosModules.catppuccin
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
    plymouth.enable = false;
    flavor = "mocha";
  };

  boot.plymouth.enable = true;

  networking = {
    hostName = "waffleswork";
    wireless.enable = true;

    networkmanager = {
      enable = true;
      plugins = with pkgs; [
        networkmanager-openvpn
      ];
    };
  };

  virtualisation.docker.storageDriver = "btrfs";

  system.stateVersion = "26.05";
}
