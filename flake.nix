{
  description = "My NixOS Configurations";

  nixConfig = {
    extra-substituters = ''
      https://nix-community.cachix.org/
      https://hyprland.cachix.org/
      https://cache.privatevoid.net/
      https://cache.garnix.io/
    '';

    extra-trusted-public-keys = ''
      nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs=
      hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=
      cache.privatevoid.net-1:SErQ8bvNWANeAvtsOESUwVYr2VJynfuc9JRwlzTTkVg=
      cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g=
    '';
  };

  inputs = {
    vimacs = {
      url = "github:orhnk/vimacs-flake";
    };

    nixSuper = {
      url = "github:privatevoid-net/nix-super";
    };

    nixpkgs = {
      url = "github:NixOS/nixpkgs/nixos-unstable";
    };

    homeManager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nuScripts = {
      url = "github:nushell/nu_scripts";
      flake = false;
    };

    fenix = {
      url = "github:nix-community/fenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zls = {
      url = "github:zigtools/zls";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    tools = {
      url = "github:RGBCube/FlakeTools";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    themes = {
      url = "github:RGBCube/ThemeNix";
    };
  };

  outputs = {
    nixSuper,
    nixpkgs,
    homeManager,
    nuScripts,
    fenix,
    tools,
    themes,
    ...
  } @ inputs: let
    lib = nixpkgs.lib;

    ulib = import ./lib lib;

    configuration = host: system: let
      pkgs = import nixpkgs {inherit system;};

      upkgs =
        {inherit nuScripts;}
        // (lib.genAttrs
          ["nixSuper" "zls" "vimacs" "iamb"]
          (name: inputs.${name}.packages.${system}.default));

      theme = themes.custom (themes.raw.ayu-dark
        // {
          corner-radius = 8;
          border-width = 2;

          margin = 6;
          padding = 8;

          font.size.normal = 12;
          font.size.big = 18;

          font.sans.name = "Iosevka";
          font.sans.package = pkgs.iosevka;

          # font.mono.name = "creep";
          # font.mono.package = pkgs.creep;

          font.mono.name = "JetBrainsMono Nerd Font";
          font.mono.package = pkgs.nerdfonts.override {fonts = ["JetBrainsMono"];};

          icons.name = "Gruvbox-Plus-Dark";
          icons.package = pkgs.callPackage (import ./derivations/gruvbox-icons.nix) {};
        });

      defaultConfiguration = {
        environment.defaultPackages = [];

        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;

        networking.hostName = host;
        nixpkgs.hostPlatform = system;
      };
    in
      lib.nixosSystem {
        inherit system;

        specialArgs = {inherit inputs ulib upkgs theme;};
        modules = [
          homeManager.nixosModules.default
          defaultConfiguration
          ./hosts/${host}
        ];
      };

    configurations = builtins.mapAttrs configuration;
  in {
    nixosConfigurations = configurations {
      enka = "x86_64-linux";
    };
  };
}
