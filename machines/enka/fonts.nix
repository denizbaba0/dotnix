{
  lib,
  pkgs,
  systemConfiguration,
  systemFonts,
  ...
}:
lib.recursiveUpdate
(systemConfiguration {
  console = {
    earlySetup = true;
    font = "Lat2-Terminus16";
    packages = with pkgs; [
      terminus-nerdfont
    ];
  };
})
(with pkgs;
  systemFonts [
    (nerdfonts.override {
      # Nerd Fonts to install
      fonts = [
        "JetBrainsMono"
        # "Iosevka"
      ];
    })
    # open-sans
    # noto-fonts
    # noto-fonts-cjk-sans
    iosevka
    noto-fonts-emoji
  ])
