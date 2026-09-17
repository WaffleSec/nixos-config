{ pkgs, ...}:

{
  services.onedrive.enable = true;
  environment.systemPackages = with pkgs; [
    intune-portal
    microsoft-identity-broker
  ];
}
