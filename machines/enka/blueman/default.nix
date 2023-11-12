{ systemConfiguration, enabled, ... }:

systemConfiguration {
  services.blueman = enabled {};

  hardware.bluetooth = enabled {
    powerOnBoot = true;
  };
}
