{ config, lib, pkgs, userfullname, useremail, ...}: 

{
  # `programs.git` will generate the config file: ~/.config/git/config
  # to make git use this config file, `~/.gitconfig` should not exist!
  #
  #    https://git-scm.com/docs/git-config#Documentation/git-config.txt---global
  home.activation.removeExistingGitconfig = lib.hm.dag.entryBefore ["checkLinkTargets"] ''
    rm -f ~/.gitconfig
  '';

  programs.git = {
    enable = true;
    lfs.enable = true;
    settings = {
      user = {
        name = userfullname;
        email = useremail;
      };
      init.defaultBranch = "main";
      push.autoSetupRemote = true;
      pull.rebase = true;

      # replace https with ssh
      url = {
        "ssh://git@github.com/" = {
          insteadOf = "https://github.com/";
        };
        "ssh://git@gitlab.com/" = {
          insteadOf = "https://gitlab.com/";
        };
        "ssh://git@bitbucket.com/" = {
          insteadOf = "https://bitbucket.com/";
        };
      };

    };

    includes = [
      {
        # use diffrent email & name for work
        path = "~/work/.gitconfig";
        condition = "gitdir:~/work/";
      }
    ];

    # signing = {
    #   key = "xxx";
    #   signByDefault = true;
    # };

  };

  programs.delta = {
    enable = true;
    enableGitIntegration = true;
    options = {
      side-by-side = true;
      line-numbers = true;
      navigate = true;
    };
  };
}

