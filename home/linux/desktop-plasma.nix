{ username, catppuccin, ... }:

{
  imports = [
    catppuccin.homeModules.catppuccin
    ../base/desktop

    ./base
    ./desktop
  ];

  catppuccin = {
    enable = true;
    autoEnable = true;
    cache.enable = true;
    flavor = "mocha";
    accent = "mauve";
  };

  home = {
    username = username;
    homeDirectory = "/home/${username}";
    stateVersion = "26.05";
  };
  programs.home-manager.enable = true;
}
