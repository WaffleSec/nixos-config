{ ...}:

{
  programs.nushell ={
    enable = true;
    settings = {
      show_banner = false;
    };

    extraConfig = ''
      if ($nu.is-interactive) and ("ZELLIJ" not-in $env) and (which zellij | is-not-empty) {
          exec zellij
      }
    '';    
  };
}
