{ pkgs, ... }: {
  services.xserver.videoDrivers = [ "modesetting" ];

  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver   # For Broadwell (2014) and newer processors (iHD)
      intel-vaapi-driver   # For older processors (i965) if needed
      intel-compute-runtime # OpenCL support
    ];
  };

  environment.sessionVariables = {
    LIBVA_DRIVER_NAME = "iHD";
  };
}
