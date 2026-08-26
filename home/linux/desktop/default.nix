{pkgs, ...}: {
  imports = [
    ./creative.nix
    ./immutable-file.nix
    # ./xdg.nix
  ];

  home.packages = with pkgs; [
    # GUI apps
    firefox # Web browser
    thunderbird # Email client
    insomnia # REST client
    wireshark # network analyzer
    obsidian # note taking
    audacity # audio analysis
    vlc # audio and video player
    
    # e-book viewer(.epub/.mobi/...)
    # do not support .pdf
    foliate

    # instant messaging
    telegram-desktop
    vesktop

    # remote desktop(rdp connect)
    remmina
    freerdp # required by remmina
  ];

  programs.zed-editor = {
    enable = true;
    installRemoteServer = true;
    mutableUserSettings = true;
    
    userSettings = {
      project_panel = {
        dock = "left";
      };
      languages = {
        Python = {
	        formatter.language_server.name = "ruff";
          language_servers = [
            "!ty"
            "ruff"
            "!basedpyright"
            "!pyrefly"
            "!pyright"
            "pylsp"
          ];
	      };
	      Rust = {
          hard_tabs = false;
          formatter.language_server.name = "rust-analyzer";
          language_servers = [
            "rust-analyzer"
            "!rustc"
          ];
        };
        Go = {
          formatter.language_server.name = "gopls";
          language_servers = [
            "gopls"
            "!goimports"
          ];
        };
      };
      load_direnv = "shell_hook";
      base_keymap = "VSCode";
    };
    extensions = [
      "nix"
      "toml"
      "lua"
      "catppuccin-icons"
      "color-highlight"
      "rust"
      "dockerfile"
      "html"
      "catppuccin"
    ];
  };

  catppuccin.zed = {
    enable = true;
    icons.enable = true;
  };
}
