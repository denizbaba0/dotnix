with import <nixpkgs> {}; (
  let
    python = let
      packageOverrides = self: super: {
        opencv4 = super.opencv4.override {
          enableGtk2 = true;
          gtk2 = pkgs.gtk2;
          enableFfmpeg = true; #here is how to add ffmpeg and other compilation flags
        };
      };
    in
      pkgs.python.override {
        inherit packageOverrides;
        self = python;
      };
  in
    stdenv.mkDerivation {
      name = "impurePythonEnv";
      buildInputs = [
        imagemagick
        v4l-utils
        (pkgs.python.buildEnv.override {
          extraLibs = [
            pkgs.pythonPackages.matplotlib
            pkgs.pythonPackages.numpy
            pkgs.pythonPackages.scipy
            pkgs.pythonPackages.gnureadline
            python.pkgs.opencv4
          ];
          ignoreCollisions = true;
        })
      ];
      shellHook = ''
        # set SOURCE_DATE_EPOCH so that we can use python wheels
        SOURCE_DATE_EPOCH=$(date +%s)
        export LANG=en_US.UTF-8
      '';
    }
)
