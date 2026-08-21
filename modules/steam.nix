{...}:

{
  programs.steam = {
    enable = true;
  };

  services.udev.extraRules = ''
    SUBSYSTEM=="input", ATTRS{idVendor}=="2dc8", ATTRS{idProduct}=="3106", MODE="0660", GROUP="input"
  '';
}
