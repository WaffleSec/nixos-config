{username, ...}:

{
  nix.settings.trusted-users = [username];

  users.groups = {
    "${username}" = {};
    docker = {};
    wireshark = {};
  };

  users.users."${username}" = {
    hashedPassword = "$y$j9T$fhjSCt7bpwFLIRXrRFtLI1$637lKbrHg//OveyMtXkNWuF55Lvagv0lrR6W14.6qkA";
    home = "/home/${username}";
    isNormalUser = true;
    description = username;
    extraGroups = [
      username
      "users"
      "networkmanager"
      "wheel"
      "docker"
      "wireshark"
      "adbusers"
      "libvirtd"
    ];
  };

  security.sudo.extraRules = [
    {
      users = [username];
      commands = [
        {
          command = "/run/current-system/sw/bin/nix-store";
          options = ["NOPASSWD"];
        }
        {
          command = "/run/current-system/sw/bin/nix-copy-closure";
          options = ["NOPASSWD"];
        }
      ];
    }
  ];
}
