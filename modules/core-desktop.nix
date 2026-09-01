{ config, lib, pkgs, ...}:

{
  imports = [
    ./core-server.nix
  ];

  nixpkgs.config.allowUnfree = lib.mkForce true;

  environment.shells = with pkgs; [
    bash
    zsh
    nushell
  ];

  users.defaultUserShell = pkgs.bash;

  environment.systemPackages = with pkgs; [
    android-tools
    psmisc
  ];

  programs = {
    ssh.startAgent = true;
    dconf.enable = true;
  };

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  security.rtkit.enable = true;
  services.pulseaudio.enable = false;

  hardware.bluetooth.enable = false;

  services.power-profiles-daemon = {
    enable = true;
  };
  security.polkit.enable = true;
  
  services = {
    printing.enable = true;

    flatpak.enable = true;

    dbus.packages = [pkgs.gcr];
    geoclue2.enable = true;

  };

  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = false;
    extraPortals = with pkgs; [
      kdePackages.xdg-desktop-portal-kde
    ];
  };

  fonts = {
    enableDefaultPackages = false;
    fontDir.enable = true;

    packages = with pkgs; [
      #Icon Fonts
      material-design-icons
      font-awesome

      #Noto
      noto-fonts
      noto-fonts-color-emoji

      #Source 3
      source-sans
      source-serif

      #Nerdfonts
      nerd-fonts.fira-code
      nerd-fonts.jetbrains-mono
      nerd-fonts.iosevka
    ];
    fontconfig.defaultFonts = {
      serif = ["Noto Serif" "Noto Color Emoji"];
      sansSerif = ["Noto Sans" "Noto Color Emoji"];
      monospace = ["JetBrainsMono Nerd Font" "Noto Color Emoji"];
      emoji = ["Noto Color Emoji"];
    };
  };

  environment.variables = {
    TZ = "${config.time.timeZone}";
  };
}
