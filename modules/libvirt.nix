{ lib, pkgs, ... }:

{
  virtualisation = {
    libvirtd = {
      enable = true;
      qemu.runAsRoot = true;
      qemu.vhostUserPackages = [ pkgs.virtiofsd ];
    };
  };
  programs.dconf.enable = true;
  environment.systemPackages = with pkgs; [
    virt-manager
    qemu_kvm
    qemu_full
    virtiofsd
  ];
  boot.kernelModules = ["kvm-amd" "kvm-intel"];
  boot.extraModprobeConfig = "options kvm_intel nested=1";
  # boot.extraModprobeConfig = "options kvm_amd nested=1";
}
