{ pkgs, ... }:

{
  programs.zellij = {
    enable = true;

    settings = {
      default_shell = "${pkgs.nushell}/bin/nu";
      show_startup_tips = false;
      ui = {
        pane_frames = {
          hide_session_name = true;
        };
      };
    };
  };

  catppuccin.zellij = {
    enable = true;
    flavor = "mocha";
  };
}
