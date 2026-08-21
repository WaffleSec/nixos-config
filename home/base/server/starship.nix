{ lib, ...}:

{
  programs.starship = {
    enable = true;

    enableBashIntegration = true;
    enableZshIntegration = true;
    enableNushellIntegration = true;

    presets = [ "nerd-font-symbols" "catppuccin-powerline"];

    settings = {
      character = {
        success_symbol = "[›](bold green)";
        error_symbol = "[›](bold red)";
      };
      format = lib.concatStrings [
        "[](red)"
        "$os"
        "$username"
        "[](bg:peach fg:red)"
        "$directory"
        "[](bg:yellow fg:peach)"
        "$git_branch"
        "$git_status"
        "[](fg:yellow bg:green)"
        "$c"
        "$rust"
        "$golang"
        "$nodejs"
        "$bun"
        "$php"
        "$java"
        "$kotlin"
        "$haskell"
        "$python"
        "[](fg:green bg:sapphire)"
        "$conda"
        "[](fg:sapphire bg:lavender)"
        "$time"
        "[ ](fg:lavender)"
        "$cmd_duration"
        "$line_break"
        "$character"
      ];
    };
    cmd_duration = {
      enabled = true;
      show_notifications = false;
    };
  };
}
