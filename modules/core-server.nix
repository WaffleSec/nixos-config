{ lib, pkgs, ...}:

{
  boot.loader.systemd-boot.configurationLimit = lib.mkDefault 10;
  nix.gc = {
    automatic = lib.mkDefault true;
    dates = lib.mkDefault "weekly";
    options = lib.mkDefault "--delete-older-than 1w";
  };

  nix.settings = {
    auto-optimise-store = true;
    builders-use-substitutes = true;
    experimental-features = ["nix-command" "flakes"];
  };

  nixpkgs.config.allowUnfree = lib.mkDefault false;

  time.timeZone = "America/Chicago";

  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  networking.firewall.enable = lib.mkDefault false;
  networking.resolvconf.enable = false;

  services.resolved = {
    enable = true;
    settings.Resolve = {
      FallbackDNS = [
        "94.140.14.14"
        "94.140.15.15"
      ];
    };
  };

  services.openssh = {
    enable = lib.mkDefault true;
    settings = {
      X11Forwarding = true;
      PermitRootLogin = "no";
      PasswordAuthentication = false;
    };
    openFirewall = true;
  };

  services.tailscale = {
    enable = true;
  };

  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };

  services = {
    power-profiles-daemon = {
      enable = true;
    };
    upower.enable = true;
  };

  environment.systemPackages = with pkgs; [
    wget
    curl
    aria2
    git

    (
      let
        base = pkgs.appimageTools.defaultFhsEnvArgs;
      in
        pkgs.buildFHSEnv
        (
          {
            name = "fhs";
            targetPkgs = pkgs: (base.targetPkgs pkgs) ++ [pkgs.pkg-config];
            profile = "export FHS=1";
            runScript = "bash";
            extraOutputsToInstall = ["dev"];
          }
        )
    )
  ];

  environment.variables.EDITOR = "nvim";

  virtualisation.docker = {
    enable = true;
    enableOnBoot = true;
  };
}
