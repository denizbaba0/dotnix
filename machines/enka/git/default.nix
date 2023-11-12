{ homeConfiguration, enabled, ... }:

homeConfiguration "nixos" {
  programs.nushell.shellAliases = {
    g    = "git";
    ga   = "git add";
    gaa  = "git add ./";
    grb  = "git rebase";
    grbi = "git rebase --interactive";
    grba = "git rebase --abort";
    gc   = "git commit";
    gcm  = "git commit --message";
    gca  = "git commit --amend --no-edit";
    gcl  = "git clone";
    gd   = "git diff";
    gds  = "git diff --staged";
    gp   = "git push";
    gs   = "git stash";
    gsp  = "git stash pop";
    gst  = "git status";
  };

  programs.git = enabled {
    userName  = "utfeight";
    userEmail = "utfeightt@gmail.com";

    extraConfig = {
      init.defaultBranch = "master";
      push.autoSetupRemote = true;

      # commit.gpgSign  = true;
      # gpg.format      = "ssh";
      # user.signingKey = "~/.ssh/id_rsa";

      # url."ssh://git@github.com/".insteadOf = "https://github.com/";
    };
  };
}
