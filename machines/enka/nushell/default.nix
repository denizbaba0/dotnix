{
  lib,
  pkgs,
  systemConfiguration,
  homeConfiguration,
  homePackages,
  enabled,
  ...
}:
lib.recursiveUpdate3
(systemConfiguration {
  users.users.nixos.shell = pkgs.nushell;
  environment.sessionVariables = rec {
    # Not officially in the specification
    XDG_BIN_HOME = "$HOME/.local/bin";
    PATH = [
      "${XDG_BIN_HOME}"
    ];
  };
})
(homeConfiguration "nixos" {
  programs.starship = enabled {
    enableNushellIntegration = true;
  };

  programs.nushell = enabled {
    configFile.source = ./configuration.nu;
    envFile.source = ./environment.nu;

    shellAliases = {
      la = "ls --all";
      ll = "ls --long";
      lla = "ls --long --all";
      sl = "ls";
    };

    environmentVariables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
    };
  };
})
(with pkgs;
  homePackages "nixos" [
    carapace
  ])
