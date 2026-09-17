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
    ghidra # reverse engineering
    
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

  programs.claude-code = {
    enable = true;
    settings = {
      includeCoAuthoredBy = false;
      model = "claude-sonnet-5";
      theme = "dark";
    };
  };

  programs.zed-editor = {
    enable = true;
    installRemoteServer = true;
    mutableUserSettings = true;
    
    userSettings = {
      agent_servers = {
        "claude-acp" = {
          type = "registry";
          env = {
            CLAUDE_CODE_EXECUTABLE = "${pkgs.claude-code}/bin/claude";
          };
        };
      };
      project_panel = {
        dock = "left";
      };
      languages = {
        Python = {
	        formatter.language_server.name = "ruff";
          language_servers = [
            "!ty"
            "ruff"
            "basedpyright"
            "!pyrefly"
            "!pyright"
            "!pylsp"
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
      load_direnv = "direct";
      base_keymap = "VSCode";
      terminal = {
        font_family = "JetBrainsMono Nerd Font";
        font_size = 14;
      };
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
